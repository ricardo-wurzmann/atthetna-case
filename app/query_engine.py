import os
import anthropic
from database import run_query
from formulas import FORMULAS

client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

SCHEMA_CONTEXT = """
Você é um assistente especializado em dados financeiros. Converta perguntas em linguagem
natural para SQL PostgreSQL, usando o schema abaixo.

SCHEMA:
- companies(id, name, ticker)
- periods(id, date_start, date_end, period_type, fiscal_year, fiscal_quarter)
- metrics(id, name, statement_type, level_type, unit, parent_id)
- sources(id, company_id, document_type, file_name, publication_date)
- source_locations(id, source_id, page_number, section_name)
- financial_values(id, company_id, period_id, metric_id, value, consolidation_type, source_location_id)

REGRAS:
1. Sempre inclua sl.page_number e sl.section_name no SELECT para rastreabilidade.
2. Use consolidation_type = 'consolidado' por padrão, a menos que o usuário peça 'controladora'.
3. Para períodos trimestrais use fiscal_year e fiscal_quarter. Ex: 1T22 = fiscal_year=2022, fiscal_quarter=1.
4. Retorne APENAS o SQL, sem explicações, sem markdown, sem blocos de código.
5. Nunca faça cálculos complexos — retorne os valores brutos e deixe o Python calcular.

EXEMPLO:
Pergunta: "Qual a receita líquida da Magazine Luiza no 1T22?"
SQL:
SELECT fv.value, m.unit, sl.page_number, sl.section_name
FROM financial_values fv
JOIN companies c ON c.id = fv.company_id
JOIN periods p ON p.id = fv.period_id
JOIN metrics m ON m.id = fv.metric_id
JOIN source_locations sl ON sl.id = fv.source_location_id
WHERE c.ticker = 'MGLU3'
AND p.fiscal_year = 2022 AND p.fiscal_quarter = 1
AND m.name = 'Receita líquida de vendas'
AND fv.consolidation_type = 'consolidado'
"""

FORMULAS_CONTEXT = f"""
FÓRMULAS DISPONÍVEIS (use quando o usuário pedir métricas calculadas):
{", ".join(FORMULAS.keys())}
Se a pergunta envolver uma dessas fórmulas, responda apenas com o nome da fórmula.
Exemplo: "margem_bruta"
"""

def format_value(value, unit: str) -> str:
    """Formata o valor com unidade legível."""
    if unit == "BRL_thousands":
        return f"R$ {value:,.0f} mil"
    if unit == "BRL_per_share":
        return f"R$ {value:.3f} por ação"
    return str(value)

def ask_llm(question: str) -> dict:
    """
    Fluxo principal:
    1. Checa se é uma fórmula conhecida
    2. Gera SQL via LLM
    3. Roda no banco
    4. Formata resposta com rastreabilidade
    """

    # Passo 1: checa se o LLM reconhece uma fórmula
    formula_check = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=50,
        system=FORMULAS_CONTEXT,
        messages=[{"role": "user", "content": question}],
    )
    formula_name = formula_check.content[0].text.strip().lower()

    if formula_name in FORMULAS:
        # Extrai parâmetros via LLM para preencher a fórmula
        params = extract_params(question)
        sql = FORMULAS[formula_name]["sql"].format(**params)
        rows = run_query(sql)
        if not rows:
            return {"answer": "Não encontrei dados para essa consulta.", "source": None}
        value = list(rows[0].values())[0]
        return {
            "answer": f"{value}%",
            "metric": formula_name,
            "formula": FORMULAS[formula_name]["description"],
            "source": None,  # fórmulas calculadas não têm source_location único
        }

    # Passo 2: gera SQL via LLM
    response = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=500,
        system=SCHEMA_CONTEXT,
        messages=[{"role": "user", "content": question}],
    )
    sql = response.content[0].text.strip()

    # Passo 3: roda no banco
    try:
        rows = run_query(sql)
    except Exception as e:
        return {"answer": f"Erro ao executar a query: {e}", "sql": sql, "source": None}

    if not rows:
        return {"answer": "Não encontrei dados para essa consulta.", "source": None}

    # Passo 4: formata resposta
    row = rows[0]
    value = row.get("value")
    unit = row.get("unit", "BRL_thousands")
    page = row.get("page_number")
    section = row.get("section_name")

    # Gera resposta em linguagem natural via LLM
    answer_prompt = f"""
    O usuário perguntou: "{question}"
    O resultado da query foi: {value} ({unit})
    Responda em português, de forma direta, incluindo o valor formatado.
    Não mencione SQL ou banco de dados.
    """
    answer_response = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=200,
        messages=[{"role": "user", "content": answer_prompt}],
    )

    return {
        "answer": answer_response.content[0].text.strip(),
        "value": float(value) if value is not None else None,
        "unit": unit,
        "source": {
            "document": "MGLU_DF_POR_1T22.pdf",
            "page": page,
            "section": section,
        },
    }

def extract_params(question: str) -> dict:
    """Extrai ticker, fiscal_year, fiscal_quarter e consolidation_type da pergunta."""
    prompt = f"""
    Extraia do texto os seguintes parâmetros e retorne APENAS um JSON:
    - ticker (ex: MGLU3)
    - fiscal_year (ex: 2022)
    - fiscal_quarter (ex: 1)
    - consolidation_type (consolidado ou controladora)

    Texto: "{question}"

    Retorne apenas o JSON, sem explicações.
    Exemplo: {{"ticker": "MGLU3", "fiscal_year": 2022, "fiscal_quarter": 1, "consolidation_type": "consolidado"}}
    """
    import json
    response = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=100,
        messages=[{"role": "user", "content": prompt}],
    )
    return json.loads(response.content[0].text.strip())
