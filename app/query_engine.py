import os
import anthropic
from pathlib import Path
from dotenv import load_dotenv
from database import run_query
from formulas import FORMULAS

load_dotenv(dotenv_path=Path(__file__).parent.parent / ".env")

client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))

SCHEMA_CONTEXT = """
Você é um assistente especializado em dados financeiros. Converta perguntas em linguagem
natural para SQL PostgreSQL, usando o schema abaixo.

SCHEMA:
- empresas(id, nome, ticker)
- periodos(id, data_inicio, data_fim, tipo_periodo, ano_fiscal, trimestre_fiscal)
- metricas(id, nome, tipo_demonstracao, tipo_nivel, unidade, pai_id)
- fontes(id, empresa_id, tipo_documento, nome_arquivo, data_publicacao)
- localizacoes_fonte(id, fonte_id, numero_pagina, nome_secao)
- valores_financeiros(id, empresa_id, periodo_id, metrica_id, valor, tipo_consolidacao, localizacao_fonte_id)

REGRAS:
1. Sempre inclua lf.numero_pagina e lf.nome_secao no SELECT para rastreabilidade.
2. Use tipo_consolidacao = 'consolidado' por padrão, a menos que o usuário peça 'controladora'.
3. Para períodos trimestrais use ano_fiscal e trimestre_fiscal. Ex: 1T22 = ano_fiscal=2022, trimestre_fiscal=1.
4. Retorne APENAS o SQL, sem explicações, sem markdown, sem blocos de código.
5. Nunca faça cálculos complexos — retorne os valores brutos e deixe o Python calcular.

EXEMPLO:
Pergunta: "Qual a receita líquida da Magazine Luiza no 1T22?"
SQL:
SELECT vf.valor, m.unidade, lf.numero_pagina, lf.nome_secao
FROM valores_financeiros vf
JOIN empresas e ON e.id = vf.empresa_id
JOIN periodos p ON p.id = vf.periodo_id
JOIN metricas m ON m.id = vf.metrica_id
JOIN localizacoes_fonte lf ON lf.id = vf.localizacao_fonte_id
WHERE e.ticker = 'MGLU3'
AND p.ano_fiscal = 2022 AND p.trimestre_fiscal = 1
AND m.nome = 'Receita líquida de vendas'
AND vf.tipo_consolidacao = 'consolidado'
"""

FORMULAS_CONTEXT = f"""
FÓRMULAS DISPONÍVEIS (use quando o usuário pedir métricas calculadas):
{", ".join(FORMULAS.keys())}
Se a pergunta envolver uma dessas fórmulas, responda apenas com o nome da fórmula.
Exemplo: "margem_bruta"
"""

def format_value(value, unit: str) -> str:
    if unit == "BRL_milhares":
        return f"R$ {value:,.0f} mil"
    if unit == "BRL_por_acao":
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
    value = row.get("valor")
    unit = row.get("unidade", "BRL_milhares")
    page = row.get("numero_pagina")
    section = row.get("nome_secao")

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
