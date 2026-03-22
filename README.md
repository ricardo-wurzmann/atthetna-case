# Atthena Case — Financial Query API

API que recebe perguntas em linguagem natural sobre dados financeiros e retorna respostas com rastreabilidade ao documento original.

## Stack
- **FastAPI** — endpoint REST
- **PostgreSQL** — banco de dados relacional
- **Claude (Anthropic)** — conversão de linguagem natural para SQL

## Setup

### 1. Banco de dados
```bash
createdb atthena
psql atthena < db/schema.sql
psql atthena < db/seed.sql
```

### 2. Variáveis de ambiente
```bash
cp .env.example .env
# edite .env com suas credenciais
```

### 3. Dependências
```bash
pip install -r requirements.txt
```

### 4. Rodar
```bash
cd app
uvicorn main:app --reload
```

## Uso

```bash
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"question": "Qual a receita líquida da Magazine Luiza no 1T22?"}'
```

Resposta:
```json
{
  "answer": "A receita líquida da Magazine Luiza no 1T22 foi de R$ 8.762.176 mil.",
  "value": 8762176.0,
  "unit": "BRL_thousands",
  "source": {
    "document": "MGLU_DF_POR_1T22.pdf",
    "page": 7,
    "section": "Demonstração dos Resultados"
  }
}
```

## Estrutura
```
atthena-case/
├── db/
│   ├── schema.sql       # CREATE TABLEs
│   └── seed.sql         # Dados reais MGLU 1T22
├── app/
│   ├── main.py          # FastAPI endpoint
│   ├── database.py      # Conexão PostgreSQL
│   ├── query_engine.py  # LLM → SQL → resposta
│   └── formulas.py      # Catálogo de fórmulas financeiras
├── .env.example
└── requirements.txt
```

## Decisões de design

- **Schema EAV híbrido** — financial_values no estilo Entity-Attribute-Value permite múltiplas empresas e períodos sem mudar o schema
- **Rastreabilidade via source_locations** — todo valor tem página e seção do documento original
- **Fórmulas pré-definidas** — métricas calculadas (margem bruta, liquidez) ficam em formulas.py para o LLM nunca alucinar contas
- **Text-to-SQL** — o LLM só traduz linguagem natural para SQL; os cálculos ficam no banco

## Limitação conhecida

O mesmo conceito econômico (ex: Estoques) aparece em demonstrações diferentes com semânticas diferentes — saldo no Balanço vs variação no DFC. Hoje são duas linhas separadas em `metrics`. Um `canonical_metric_id` resolveria isso mas adiciona complexidade desnecessária para o escopo atual.
