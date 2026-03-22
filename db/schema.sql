-- Atthena Case — Schema SQL
-- Magazine Luiza ITR 1T22

CREATE TABLE companies (
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(255) NOT NULL,
    ticker VARCHAR(20)
);

CREATE TABLE periods (
    id              SERIAL PRIMARY KEY,
    date_start      DATE NOT NULL,
    date_end        DATE NOT NULL,
    period_type     VARCHAR(20) NOT NULL, -- 'quarterly', 'annual'
    fiscal_year     INT  NOT NULL,
    fiscal_quarter  INT              -- 1, 2, 3, 4 — NULL se annual
);

CREATE TABLE metrics (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(255) NOT NULL,
    statement_type  VARCHAR(50)  NOT NULL, -- 'balance_sheet', 'income_statement', 'cash_flow', 'notes'
    level_type      VARCHAR(20)  NOT NULL, -- 'group', 'line_item'
    unit            VARCHAR(50)  DEFAULT 'BRL_thousands',
    parent_id       INT REFERENCES metrics(id)
    -- LIMITAÇÃO CONHECIDA: o mesmo conceito econômico (ex: Estoques) aparece
    -- em demonstrações diferentes com semânticas diferentes (saldo vs variação).
    -- Hoje são duas linhas separadas. Um canonical_metric_id resolveria isso
    -- mas adiciona complexidade desnecessária para o escopo atual.
);

CREATE TABLE sources (
    id                SERIAL PRIMARY KEY,
    company_id        INT REFERENCES companies(id) NOT NULL,
    document_type     VARCHAR(50)  NOT NULL, -- 'ITR', 'DFP'
    file_name         VARCHAR(255) NOT NULL,
    publication_date  DATE
);

CREATE TABLE source_locations (
    id            SERIAL PRIMARY KEY,
    source_id     INT REFERENCES sources(id) NOT NULL,
    page_number   INT          NOT NULL,
    section_name  VARCHAR(255) NOT NULL
);

CREATE TABLE financial_values (
    id                  SERIAL PRIMARY KEY,
    company_id          INT REFERENCES companies(id)         NOT NULL,
    period_id           INT REFERENCES periods(id)           NOT NULL,
    metric_id           INT REFERENCES metrics(id)           NOT NULL,
    value               NUMERIC(20, 3)                       NOT NULL,
    consolidation_type  VARCHAR(20)                          NOT NULL, -- 'controladora', 'consolidado'
    source_location_id  INT REFERENCES source_locations(id)  NOT NULL
);

-- Índices para queries de série temporal e comparação entre empresas
CREATE INDEX idx_fv_company    ON financial_values(company_id);
CREATE INDEX idx_fv_period     ON financial_values(period_id);
CREATE INDEX idx_fv_metric     ON financial_values(metric_id);
CREATE INDEX idx_fv_consol     ON financial_values(consolidation_type);
CREATE INDEX idx_periods_year  ON periods(fiscal_year, fiscal_quarter);
CREATE INDEX idx_metrics_stmt  ON metrics(statement_type);
