-- Atthena Case — Schema SQL
-- Magazine Luiza ITR 1T22
-- Valores em milhares de reais (BRL_milhares)

CREATE TABLE empresas (
    id     SERIAL PRIMARY KEY,
    nome   VARCHAR(255) NOT NULL,
    ticker VARCHAR(20)
);

CREATE TABLE periodos (
    id                SERIAL PRIMARY KEY,
    data_inicio       DATE         NOT NULL,
    data_fim          DATE         NOT NULL,
    tipo_periodo      VARCHAR(20)  NOT NULL, -- 'trimestral', 'anual'
    ano_fiscal        INT          NOT NULL,
    trimestre_fiscal  INT                    -- 1, 2, 3, 4 — null se anual
);

CREATE TABLE metricas (
    id                 SERIAL PRIMARY KEY,
    nome               VARCHAR(255) NOT NULL,
    tipo_demonstracao  VARCHAR(50)  NOT NULL, -- 'balanco', 'dre', 'dfc', 'notas'
    tipo_nivel         VARCHAR(20)  NOT NULL, -- 'grupo', 'linha'
    unidade            VARCHAR(50)  DEFAULT 'BRL_milhares',
    pai_id             INT REFERENCES metricas(id)
    -- LIMITAÇÃO CONHECIDA 1: o mesmo conceito econômico (ex: Estoques) aparece
    -- em demonstrações diferentes com semânticas diferentes (saldo vs variação).
    -- Hoje são duas linhas separadas. Um canonical_metrica_id resolveria isso
    -- mas adiciona complexidade desnecessária para o escopo atual.
);

CREATE TABLE fontes (
    id                SERIAL PRIMARY KEY,
    empresa_id        INT REFERENCES empresas(id) NOT NULL,
    tipo_documento    VARCHAR(50)  NOT NULL, -- 'ITR', 'DFP'
    nome_arquivo      VARCHAR(255) NOT NULL,
    data_publicacao   DATE
);

CREATE TABLE localizacoes_fonte (
    id              SERIAL PRIMARY KEY,
    fonte_id        INT REFERENCES fontes(id) NOT NULL,
    numero_pagina   INT          NOT NULL,
    nome_secao      VARCHAR(255) NOT NULL
    -- LIMITAÇÃO CONHECIDA 2: localizacoes_fonte está amarrado a um único documento.
    -- Se a mesma empresa tiver dois PDFs diferentes (ex: reapresentação),
    -- não há distinção entre eles. Resolvível adicionando versao ou hash
    -- do arquivo em fontes quando necessário.
);

CREATE TABLE valores_financeiros (
    id                    SERIAL PRIMARY KEY,
    empresa_id            INT REFERENCES empresas(id)           NOT NULL,
    periodo_id            INT REFERENCES periodos(id)           NOT NULL,
    metrica_id            INT REFERENCES metricas(id)           NOT NULL,
    valor                 NUMERIC(20, 3)                        NOT NULL,
    tipo_consolidacao     VARCHAR(20)                           NOT NULL, -- 'controladora', 'consolidado'
    localizacao_fonte_id  INT REFERENCES localizacoes_fonte(id) NOT NULL
);

-- Nota 19 — parte estruturada (números)
-- Dois registros por modalidade: um para cada período (31/03/2022 e 31/12/2021)
CREATE TABLE instrumentos_divida (
    id                    SERIAL PRIMARY KEY,
    empresa_id            INT REFERENCES empresas(id)           NOT NULL,
    periodo_id            INT REFERENCES periodos(id)           NOT NULL,
    localizacao_fonte_id  INT REFERENCES localizacoes_fonte(id) NOT NULL,
    modalidade            VARCHAR(255) NOT NULL,
    encargo               VARCHAR(255),
    tipo_garantia         VARCHAR(100),
    data_vencimento       DATE,
    valor_controladora    NUMERIC(20, 3),
    valor_consolidado     NUMERIC(20, 3)
);

-- Nota 19 — parte narrativa (texto explicativo das letras a, b, c, d)
CREATE TABLE notas_explicativas (
    id                    SERIAL PRIMARY KEY,
    empresa_id            INT REFERENCES empresas(id)           NOT NULL,
    periodo_id            INT REFERENCES periodos(id)           NOT NULL,
    localizacao_fonte_id  INT REFERENCES localizacoes_fonte(id) NOT NULL,
    numero_nota           VARCHAR(20)  NOT NULL,
    titulo                VARCHAR(255) NOT NULL,
    conteudo              TEXT         NOT NULL
);

-- Índices para queries de série temporal e comparação entre empresas
CREATE INDEX idx_vf_empresa    ON valores_financeiros(empresa_id);
CREATE INDEX idx_vf_periodo    ON valores_financeiros(periodo_id);
CREATE INDEX idx_vf_metrica    ON valores_financeiros(metrica_id);
CREATE INDEX idx_vf_consol     ON valores_financeiros(tipo_consolidacao);
CREATE INDEX idx_periodos_ano  ON periodos(ano_fiscal, trimestre_fiscal);
CREATE INDEX idx_metricas_demo ON metricas(tipo_demonstracao);
CREATE INDEX idx_divida_emp    ON instrumentos_divida(empresa_id, periodo_id);
CREATE INDEX idx_notas_emp     ON notas_explicativas(empresa_id, numero_nota);
