# Atthena Case — Financial Query API

API que recebe perguntas em linguagem natural sobre dados financeiros
e retorna respostas com rastreabilidade ao documento original.

## Stack
- **FastAPI** — endpoint REST
- **PostgreSQL** — banco de dados relacional
- **Claude (Anthropic)** — conversão de linguagem natural para SQL

## Setup

### 1. Banco de dados

Sobe o PostgreSQL via Docker:
```bash
docker run --name atthena-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=atthena \
  -p 5432:5432 \
  -d postgres
```

> **Atenção:** se você tiver o PostgreSQL instalado localmente, a porta 5432 pode estar ocupada.
> Nesse caso use `-p 5433:5432` e ajuste o `DB_PORT` no `.env` para `5433`.

Copia os arquivos para o container e popula:
```bash
docker cp db/schema.sql atthena-postgres:/schema.sql
docker cp db/seed.sql atthena-postgres:/seed.sql
docker exec -i atthena-postgres psql -U postgres atthena -f /schema.sql
docker exec -i atthena-postgres psql -U postgres atthena -f /seed.sql
```

### 2. Variáveis de ambiente
```bash
cp .env.example .env
# edite .env com suas credenciais
```

O `.env` deve ficar assim:
```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=atthena
DB_USER=postgres
DB_PASSWORD=postgres
ANTHROPIC_API_KEY=sk-ant-...
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

Acesse a documentação interativa em `http://127.0.0.1:8000/docs`

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
  "unit": "BRL_milhares",
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

- **Schema EAV híbrido** — `valores_financeiros` no estilo
  Entity-Attribute-Value permite múltiplas empresas e períodos
  sem alterar o schema
- **Rastreabilidade via localizacoes_fonte** — todo valor tem
  página e seção do documento original
- **Nota 19 em tabelas especializadas** — `instrumentos_divida`
  para os números estruturados e `notas_explicativas` para o
  texto analítico, pois não cabem no modelo EAV padrão
- **Fórmulas pré-definidas** — métricas calculadas (margem bruta,
  liquidez) ficam em `formulas.py` para o LLM nunca alucinar contas
- **Text-to-SQL** — o LLM só traduz linguagem natural para SQL;
  os cálculos ficam no banco

## Limitações conhecidas

1. O mesmo conceito econômico (ex: Estoques) aparece em
   demonstrações diferentes com semânticas diferentes — saldo
   no Balanço vs variação no DFC. Hoje são duas linhas separadas
   em `metricas`. Um `canonical_metrica_id` resolveria isso mas
   adiciona complexidade desnecessária para o escopo atual.

2. `localizacoes_fonte` está amarrado a um único documento por
   empresa. Se a mesma empresa publicar uma reapresentação,
   não há distinção entre versões. Resolvível adicionando
   `versao` ou hash do arquivo em `fontes`.
