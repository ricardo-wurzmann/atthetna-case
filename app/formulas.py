# Catálogo de fórmulas financeiras pré-definidas.
# O LLM consulta esse catálogo para nunca alucinar cálculos.
# Cada fórmula referencia os metric.name exatos do banco.

FORMULAS = {
    "margem_bruta": {
        "description": "Lucro bruto dividido pela receita líquida",
        "sql": """
            SELECT
                ROUND(
                    MAX(CASE WHEN m.name = 'Lucro bruto' THEN fv.value END) * 100.0 /
                    NULLIF(MAX(CASE WHEN m.name = 'Receita líquida de vendas' THEN fv.value END), 0),
                2) AS margem_bruta_pct
            FROM financial_values fv
            JOIN metrics m ON m.id = fv.metric_id
            JOIN companies c ON c.id = fv.company_id
            JOIN periods p ON p.id = fv.period_id
            WHERE c.ticker = '{ticker}'
            AND p.fiscal_year = {fiscal_year}
            AND p.fiscal_quarter = {fiscal_quarter}
            AND fv.consolidation_type = '{consolidation_type}'
            AND m.name IN ('Lucro bruto', 'Receita líquida de vendas')
        """,
    },
    "liquidez_corrente": {
        "description": "Ativo circulante dividido pelo passivo circulante",
        "sql": """
            SELECT
                ROUND(
                    MAX(CASE WHEN m.name = 'Total do ativo circulante' THEN fv.value END) /
                    NULLIF(MAX(CASE WHEN m.name = 'Total do passivo circulante' THEN fv.value END), 0),
                2) AS liquidez_corrente
            FROM financial_values fv
            JOIN metrics m ON m.id = fv.metric_id
            JOIN companies c ON c.id = fv.company_id
            JOIN periods p ON p.id = fv.period_id
            WHERE c.ticker = '{ticker}'
            AND p.fiscal_year = {fiscal_year}
            AND p.fiscal_quarter = {fiscal_quarter}
            AND fv.consolidation_type = '{consolidation_type}'
            AND m.name IN ('Total do ativo circulante', 'Total do passivo circulante')
        """,
    },
    "endividamento": {
        "description": "Total do passivo dividido pelo total do ativo",
        "sql": """
            SELECT
                ROUND(
                    MAX(CASE WHEN m.name = 'Total do passivo' THEN fv.value END) * 100.0 /
                    NULLIF(MAX(CASE WHEN m.name = 'Total do ativo' THEN fv.value END), 0),
                2) AS endividamento_pct
            FROM financial_values fv
            JOIN metrics m ON m.id = fv.metric_id
            JOIN companies c ON c.id = fv.company_id
            JOIN periods p ON p.id = fv.period_id
            WHERE c.ticker = '{ticker}'
            AND p.fiscal_year = {fiscal_year}
            AND p.fiscal_quarter = {fiscal_quarter}
            AND fv.consolidation_type = '{consolidation_type}'
            AND m.name IN ('Total do passivo', 'Total do ativo')
        """,
    },
}
