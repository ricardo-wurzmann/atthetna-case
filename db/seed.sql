-- Atthena Case — Seed SQL
-- Dados reais do ITR Magazine Luiza 1T22
-- Valores em milhares de reais (BRL_milhares)

-- ============================================================
-- EMPRESAS
-- ============================================================
INSERT INTO empresas (id, nome, ticker) VALUES
(1, 'Magazine Luiza S.A.', 'MGLU3');

-- ============================================================
-- PERIODOS
-- ============================================================
INSERT INTO periodos (id, data_inicio, data_fim, tipo_periodo, ano_fiscal, trimestre_fiscal) VALUES
(1, '2022-01-01', '2022-03-31', 'trimestral', 2022, 1),
(2, '2021-01-01', '2021-12-31', 'anual',      2021, NULL),
(3, '2021-01-01', '2021-03-31', 'trimestral', 2021, 1);

-- ============================================================
-- FONTES
-- ============================================================
INSERT INTO fontes (id, empresa_id, tipo_documento, nome_arquivo, data_publicacao) VALUES
(1, 1, 'ITR', 'MGLU_DF_POR_1T22.pdf', '2022-05-13');

-- ============================================================
-- LOCALIZACOES_FONTE
-- ============================================================
INSERT INTO localizacoes_fonte (id, fonte_id, numero_pagina, nome_secao) VALUES
(1, 1, 5,  'Balanço Patrimonial — Ativo'),
(2, 1, 6,  'Balanço Patrimonial — Passivo e Patrimônio Líquido'),
(3, 1, 7,  'Demonstração dos Resultados'),
(4, 1, 10, 'Demonstração dos Fluxos de Caixa'),
(5, 1, 30, 'Nota 19 — Empréstimos e Financiamentos');

-- ============================================================
-- METRICAS — Balanço Patrimonial Ativo (p.5)
-- ============================================================
INSERT INTO metricas (id, nome, tipo_demonstracao, tipo_nivel, unidade, pai_id) VALUES
(1,  'Ativo Circulante',                                    'balanco', 'grupo', 'BRL_milhares', NULL),
(2,  'Ativo Não Circulante',                                'balanco', 'grupo', 'BRL_milhares', NULL),
(3,  'Caixa e equivalentes de caixa',                       'balanco', 'linha', 'BRL_milhares', 1),
(4,  'Títulos e valores mobiliários',                        'balanco', 'linha', 'BRL_milhares', 1),
(5,  'Contas a receber',                                    'balanco', 'linha', 'BRL_milhares', 1),
(6,  'Estoques',                                            'balanco', 'linha', 'BRL_milhares', 1),
(7,  'Contas a receber de partes relacionadas',             'balanco', 'linha', 'BRL_milhares', 1),
(8,  'Tributos a recuperar',                                'balanco', 'linha', 'BRL_milhares', 1),
(9,  'Imposto de renda e contribuição social a recuperar',  'balanco', 'linha', 'BRL_milhares', 1),
(10, 'Outros ativos circulantes',                           'balanco', 'linha', 'BRL_milhares', 1),
(11, 'Total do ativo circulante',                           'balanco', 'grupo', 'BRL_milhares', 1),
(12, 'Contas a receber não circulante',                     'balanco', 'linha', 'BRL_milhares', 2),
(13, 'Tributos a recuperar não circulante',                 'balanco', 'linha', 'BRL_milhares', 2),
(14, 'Imposto de renda e contribuição social diferidos',    'balanco', 'linha', 'BRL_milhares', 2),
(15, 'Depósitos judiciais',                                 'balanco', 'linha', 'BRL_milhares', 2),
(16, 'Outros ativos não circulantes',                       'balanco', 'linha', 'BRL_milhares', 2),
(17, 'Investimentos em controladas',                        'balanco', 'linha', 'BRL_milhares', 2),
(18, 'Investimentos em controladas em conjunto',            'balanco', 'linha', 'BRL_milhares', 2),
(19, 'Direito de uso de arrendamento',                      'balanco', 'linha', 'BRL_milhares', 2),
(20, 'Imobilizado',                                         'balanco', 'linha', 'BRL_milhares', 2),
(21, 'Intangível',                                          'balanco', 'linha', 'BRL_milhares', 2),
(22, 'Total do ativo não circulante',                       'balanco', 'grupo', 'BRL_milhares', 2),
(23, 'Total do ativo',                                      'balanco', 'grupo', 'BRL_milhares', NULL);

-- ============================================================
-- METRICAS — Balanço Patrimonial Passivo + PL (p.6)
-- ============================================================
INSERT INTO metricas (id, nome, tipo_demonstracao, tipo_nivel, unidade, pai_id) VALUES
(24, 'Passivo Circulante',                                          'balanco', 'grupo', 'BRL_milhares', NULL),
(25, 'Fornecedores',                                                'balanco', 'linha', 'BRL_milhares', 24),
(26, 'Parceiros e outros depósitos',                                'balanco', 'linha', 'BRL_milhares', 24),
(27, 'Empréstimos e financiamentos circulante',                     'balanco', 'linha', 'BRL_milhares', 24),
(28, 'Salários, férias e encargos sociais',                         'balanco', 'linha', 'BRL_milhares', 24),
(29, 'Tributos a recolher',                                         'balanco', 'linha', 'BRL_milhares', 24),
(30, 'Contas a pagar a partes relacionadas',                        'balanco', 'linha', 'BRL_milhares', 24),
(31, 'Arrendamento mercantil circulante',                           'balanco', 'linha', 'BRL_milhares', 24),
(32, 'Receita diferida circulante',                                 'balanco', 'linha', 'BRL_milhares', 24),
(33, 'Dividendos a pagar',                                          'balanco', 'linha', 'BRL_milhares', 24),
(34, 'Outras contas a pagar circulante',                            'balanco', 'linha', 'BRL_milhares', 24),
(35, 'Total do passivo circulante',                                 'balanco', 'grupo', 'BRL_milhares', 24),
(36, 'Passivo Não Circulante',                                      'balanco', 'grupo', 'BRL_milhares', NULL),
(37, 'Empréstimos e financiamentos não circulante',                 'balanco', 'linha', 'BRL_milhares', 36),
(38, 'Tributos a recolher não circulante',                          'balanco', 'linha', 'BRL_milhares', 36),
(39, 'Arrendamento mercantil não circulante',                       'balanco', 'linha', 'BRL_milhares', 36),
(40, 'Imposto de renda diferido passivo',                           'balanco', 'linha', 'BRL_milhares', 36),
(41, 'Provisão para riscos tributários, cíveis e trabalhistas',     'balanco', 'linha', 'BRL_milhares', 36),
(42, 'Receita diferida não circulante',                             'balanco', 'linha', 'BRL_milhares', 36),
(43, 'Outras contas a pagar não circulante',                        'balanco', 'linha', 'BRL_milhares', 36),
(44, 'Total do passivo não circulante',                             'balanco', 'grupo', 'BRL_milhares', 36),
(45, 'Total do passivo',                                            'balanco', 'grupo', 'BRL_milhares', NULL),
(46, 'Patrimônio Líquido',                                          'balanco', 'grupo', 'BRL_milhares', NULL),
(47, 'Capital social',                                              'balanco', 'linha', 'BRL_milhares', 46),
(48, 'Reserva de capital',                                          'balanco', 'linha', 'BRL_milhares', 46),
(49, 'Ações em tesouraria',                                         'balanco', 'linha', 'BRL_milhares', 46),
(50, 'Reserva legal',                                               'balanco', 'linha', 'BRL_milhares', 46),
(51, 'Reserva de lucros',                                           'balanco', 'linha', 'BRL_milhares', 46),
(52, 'Ajuste de avaliação patrimonial',                             'balanco', 'linha', 'BRL_milhares', 46),
(53, 'Prejuízo líquido do período',                                 'balanco', 'linha', 'BRL_milhares', 46),
(54, 'Total do patrimônio líquido',                                 'balanco', 'grupo', 'BRL_milhares', 46),
(55, 'Total do Passivo e Patrimônio Líquido',                       'balanco', 'grupo', 'BRL_milhares', NULL);

-- ============================================================
-- METRICAS — DRE (p.7)
-- ============================================================
INSERT INTO metricas (id, nome, tipo_demonstracao, tipo_nivel, unidade, pai_id) VALUES
(56, 'Receita líquida de vendas',                                           'dre', 'linha', 'BRL_milhares',   NULL),
(57, 'Custo das mercadorias revendidas e das prestações de serviços',       'dre', 'linha', 'BRL_milhares',   NULL),
(58, 'Lucro bruto',                                                         'dre', 'grupo', 'BRL_milhares',   NULL),
(59, 'Despesas com vendas',                                                 'dre', 'linha', 'BRL_milhares',   NULL),
(60, 'Despesas gerais e administrativas',                                   'dre', 'linha', 'BRL_milhares',   NULL),
(61, 'Perdas por redução ao valor recuperável de créditos',                 'dre', 'linha', 'BRL_milhares',   NULL),
(62, 'Depreciação e amortização',                                           'dre', 'linha', 'BRL_milhares',   NULL),
(63, 'Resultado de equivalência patrimonial',                               'dre', 'linha', 'BRL_milhares',   NULL),
(64, 'Outras receitas operacionais líquidas',                               'dre', 'linha', 'BRL_milhares',   NULL),
(65, 'Lucro operacional antes do resultado financeiro',                     'dre', 'grupo', 'BRL_milhares',   NULL),
(66, 'Receitas financeiras',                                                'dre', 'linha', 'BRL_milhares',   NULL),
(67, 'Despesas financeiras',                                                'dre', 'linha', 'BRL_milhares',   NULL),
(68, 'Resultado financeiro',                                                'dre', 'grupo', 'BRL_milhares',   NULL),
(69, 'Lucro operacional antes do imposto de renda',                         'dre', 'grupo', 'BRL_milhares',   NULL),
(70, 'Imposto de renda e contribuição social correntes e diferidos',        'dre', 'linha', 'BRL_milhares',   NULL),
(71, 'Lucro líquido do período',                                            'dre', 'grupo', 'BRL_milhares',   NULL),
(72, 'Lucro básico por ação',                                               'dre', 'linha', 'BRL_por_acao',   NULL),
(73, 'Lucro diluído por ação',                                              'dre', 'linha', 'BRL_por_acao',   NULL);

-- ============================================================
-- METRICAS — DFC (p.10)
-- ============================================================
INSERT INTO metricas (id, nome, tipo_demonstracao, tipo_nivel, unidade, pai_id) VALUES
(74, 'Fluxo de caixa das atividades operacionais',          'dfc', 'grupo', 'BRL_milhares', NULL),
(75, 'Lucro líquido do período',                            'dfc', 'linha', 'BRL_milhares', 74),
(76, 'Depreciação e amortização',                           'dfc', 'linha', 'BRL_milhares', 74),
(77, 'Estoques',                                            'dfc', 'linha', 'BRL_milhares', 74),
(78, 'Contas a receber',                                    'dfc', 'linha', 'BRL_milhares', 74),
(79, 'Fornecedores',                                        'dfc', 'linha', 'BRL_milhares', 74),
(80, 'Fluxo de caixa aplicado nas atividades operacionais', 'dfc', 'grupo', 'BRL_milhares', 74),
(81, 'Fluxo de caixa das atividades de investimento',       'dfc', 'grupo', 'BRL_milhares', NULL),
(82, 'Aquisição de imobilizado',                            'dfc', 'linha', 'BRL_milhares', 81),
(83, 'Aquisição de ativo intangível',                       'dfc', 'linha', 'BRL_milhares', 81),
(84, 'Fluxo de caixa aplicado nas atividades de investimento', 'dfc', 'grupo', 'BRL_milhares', 81),
(85, 'Fluxo de caixa das atividades de financiamento',      'dfc', 'grupo', 'BRL_milhares', NULL),
(86, 'Captação de empréstimos e financiamentos',            'dfc', 'linha', 'BRL_milhares', 85),
(87, 'Pagamento de empréstimos e financiamentos',           'dfc', 'linha', 'BRL_milhares', 85),
(88, 'Fluxo de caixa aplicado nas atividades de financiamento', 'dfc', 'grupo', 'BRL_milhares', 85),
(89, 'Aumento (redução) do saldo de caixa',                 'dfc', 'grupo', 'BRL_milhares', NULL),
(90, 'Caixa no início do período',                          'dfc', 'linha', 'BRL_milhares', NULL),
(91, 'Caixa no fim do período',                             'dfc', 'linha', 'BRL_milhares', NULL);

-- ============================================================
-- VALORES_FINANCEIROS — Balanço Ativo (p.5)
-- ============================================================
INSERT INTO valores_financeiros (empresa_id, periodo_id, metrica_id, valor, tipo_consolidacao, localizacao_fonte_id) VALUES
(1, 1, 3,  579533.0,   'controladora', 1),
(1, 2, 3,  1458754.0,  'controladora', 1),
(1, 1, 3,  1407204.0,  'consolidado',  1),
(1, 2, 3,  2566218.0,  'consolidado',  1),
(1, 1, 4,  584427.0,   'controladora', 1),
(1, 2, 4,  1556211.0,  'controladora', 1),
(1, 1, 4,  584427.0,   'consolidado',  1),
(1, 2, 4,  1556371.0,  'consolidado',  1),
(1, 1, 5,  2762578.0,  'controladora', 1),
(1, 2, 5,  3928531.0,  'controladora', 1),
(1, 1, 5,  4801071.0,  'consolidado',  1),
(1, 2, 5,  5650759.0,  'consolidado',  1),
(1, 1, 6,  6870322.0,  'controladora', 1),
(1, 2, 6,  7873544.0,  'controladora', 1),
(1, 1, 6,  8077255.0,  'consolidado',  1),
(1, 2, 6,  9112214.0,  'consolidado',  1),
(1, 1, 7,  3461072.0,  'controladora', 1),
(1, 2, 7,  4201742.0,  'controladora', 1),
(1, 1, 7,  2887052.0,  'consolidado',  1),
(1, 2, 7,  3707284.0,  'consolidado',  1),
(1, 1, 8,  1154812.0,  'controladora', 1),
(1, 2, 8,  1151721.0,  'controladora', 1),
(1, 1, 8,  1316808.0,  'consolidado',  1),
(1, 2, 8,  1279257.0,  'consolidado',  1),
(1, 1, 9,  216693.0,   'controladora', 1),
(1, 2, 9,  205312.0,   'controladora', 1),
(1, 1, 9,  250086.0,   'consolidado',  1),
(1, 2, 9,  234886.0,   'consolidado',  1),
(1, 1, 10, 133574.0,   'controladora', 1),
(1, 2, 10, 136516.0,   'controladora', 1),
(1, 1, 10, 267369.0,   'consolidado',  1),
(1, 2, 10, 402821.0,   'consolidado',  1),
(1, 1, 11, 15763011.0, 'controladora', 1),
(1, 2, 11, 20512331.0, 'controladora', 1),
(1, 1, 11, 19591272.0, 'consolidado',  1),
(1, 2, 11, 24509810.0, 'consolidado',  1),
(1, 1, 13, 1585315.0,  'controladora', 1),
(1, 2, 13, 1408706.0,  'controladora', 1),
(1, 1, 13, 1679734.0,  'consolidado',  1),
(1, 2, 13, 1551556.0,  'consolidado',  1),
(1, 1, 14, 1067417.0,  'controladora', 1),
(1, 2, 14, 874232.0,   'controladora', 1),
(1, 1, 14, 1114080.0,  'consolidado',  1),
(1, 2, 14, 915111.0,   'consolidado',  1),
(1, 1, 15, 974660.0,   'controladora', 1),
(1, 2, 15, 935329.0,   'controladora', 1),
(1, 1, 15, 1277107.0,  'consolidado',  1),
(1, 2, 15, 1189894.0,  'consolidado',  1),
(1, 1, 17, 4282890.0,  'controladora', 1),
(1, 2, 17, 4099575.0,  'controladora', 1),
(1, 1, 18, 377532.0,   'controladora', 1),
(1, 2, 18, 407780.0,   'controladora', 1),
(1, 1, 18, 377532.0,   'consolidado',  1),
(1, 2, 18, 407780.0,   'consolidado',  1),
(1, 1, 19, 3359747.0,  'controladora', 1),
(1, 2, 19, 3324747.0,  'controladora', 1),
(1, 1, 19, 3396711.0,  'consolidado',  1),
(1, 2, 19, 3362998.0,  'consolidado',  1),
(1, 1, 20, 1814204.0,  'controladora', 1),
(1, 2, 20, 1777788.0,  'controladora', 1),
(1, 1, 20, 1982862.0,  'consolidado',  1),
(1, 2, 20, 1938713.0,  'consolidado',  1),
(1, 1, 21, 758805.0,   'controladora', 1),
(1, 2, 21, 728998.0,   'controladora', 1),
(1, 1, 21, 4327448.0,  'consolidado',  1),
(1, 2, 21, 4306587.0,  'consolidado',  1),
(1, 1, 22, 14325811.0, 'controladora', 1),
(1, 2, 22, 13750408.0, 'controladora', 1),
(1, 1, 22, 14169950.0, 'consolidado',  1),
(1, 2, 22, 13874806.0, 'consolidado',  1),
(1, 1, 23, 30088822.0, 'controladora', 1),
(1, 2, 23, 34262739.0, 'controladora', 1),
(1, 1, 23, 33761222.0, 'consolidado',  1),
(1, 2, 23, 38384616.0, 'consolidado',  1);

-- ============================================================
-- VALORES_FINANCEIROS — Balanço Passivo + PL (p.6)
-- ============================================================
INSERT INTO valores_financeiros (empresa_id, periodo_id, metrica_id, valor, tipo_consolidacao, localizacao_fonte_id) VALUES
(1, 1, 25, 5473332.0,  'controladora', 2),
(1, 2, 25, 9108542.0,  'controladora', 2),
(1, 1, 25, 6248478.0,  'consolidado',  2),
(1, 2, 25, 10098944.0, 'consolidado',  2),
(1, 1, 26, 0.0,        'controladora', 2),
(1, 2, 26, 0.0,        'controladora', 2),
(1, 1, 26, 1488933.0,  'consolidado',  2),
(1, 2, 26, 1418897.0,  'consolidado',  2),
(1, 1, 27, 145013.0,   'controladora', 2),
(1, 2, 27, 44100.0,    'controladora', 2),
(1, 1, 27, 494447.0,   'consolidado',  2),
(1, 2, 27, 407968.0,   'consolidado',  2),
(1, 1, 28, 225632.0,   'controladora', 2),
(1, 2, 28, 237270.0,   'controladora', 2),
(1, 1, 28, 376392.0,   'consolidado',  2),
(1, 2, 28, 370176.0,   'consolidado',  2),
(1, 1, 29, 105505.0,   'controladora', 2),
(1, 2, 29, 146332.0,   'controladora', 2),
(1, 1, 29, 198615.0,   'consolidado',  2),
(1, 2, 29, 239595.0,   'consolidado',  2),
(1, 1, 31, 418373.0,   'controladora', 2),
(1, 2, 31, 415329.0,   'controladora', 2),
(1, 1, 31, 439675.0,   'consolidado',  2),
(1, 2, 31, 433834.0,   'consolidado',  2),
(1, 1, 35, 7628821.0,  'controladora', 2),
(1, 2, 35, 11763513.0, 'controladora', 2),
(1, 1, 35, 10882823.0, 'consolidado',  2),
(1, 2, 35, 15257189.0, 'consolidado',  2),
(1, 1, 37, 6411540.0,  'controladora', 2),
(1, 2, 37, 6368605.0,  'controladora', 2),
(1, 1, 37, 6417077.0,  'consolidado',  2),
(1, 2, 37, 6384904.0,  'consolidado',  2),
(1, 1, 39, 3049424.0,  'controladora', 2),
(1, 2, 39, 2996959.0,  'controladora', 2),
(1, 1, 39, 3069353.0,  'consolidado',  2),
(1, 2, 39, 3020844.0,  'consolidado',  2),
(1, 1, 41, 739503.0,   'controladora', 2),
(1, 2, 41, 717977.0,   'controladora', 2),
(1, 1, 41, 1111483.0,  'consolidado',  2),
(1, 2, 41, 1154109.0,  'consolidado',  2),
(1, 1, 44, 11341757.0, 'controladora', 2),
(1, 2, 44, 11237995.0, 'controladora', 2),
(1, 1, 44, 11760155.0, 'consolidado',  2),
(1, 2, 44, 11866196.0, 'consolidado',  2),
(1, 1, 45, 18970578.0, 'controladora', 2),
(1, 2, 45, 23001508.0, 'controladora', 2),
(1, 1, 45, 22642978.0, 'consolidado',  2),
(1, 2, 45, 27123385.0, 'consolidado',  2),
(1, 1, 47, 12352498.0,  'controladora', 2),
(1, 2, 47, 12352498.0,  'controladora', 2),
(1, 1, 48, -1619483.0,  'controladora', 2),
(1, 2, 48, -1637055.0,  'controladora', 2),
(1, 1, 49, -1448170.0,  'controladora', 2),
(1, 2, 49, -1449159.0,  'controladora', 2),
(1, 1, 50, 137442.0,    'controladora', 2),
(1, 2, 50, 137442.0,    'controladora', 2),
(1, 1, 51, 1856665.0,   'controladora', 2),
(1, 2, 51, 1856665.0,   'controladora', 2),
(1, 1, 53, -161299.0,   'controladora', 2),
(1, 2, 53, 0.0,         'controladora', 2),
(1, 1, 54, 11118244.0,  'controladora', 2),
(1, 2, 54, 11261231.0,  'controladora', 2),
(1, 1, 54, 11118244.0,  'consolidado',  2),
(1, 2, 54, 11261231.0,  'consolidado',  2),
(1, 1, 55, 30088822.0,  'controladora', 2),
(1, 2, 55, 34262739.0,  'controladora', 2),
(1, 1, 55, 33761222.0,  'consolidado',  2),
(1, 2, 55, 38384616.0,  'consolidado',  2);

-- ============================================================
-- VALORES_FINANCEIROS — DRE (p.7)
-- periodos: 1 = 1T22, 3 = 1T21
-- ============================================================
INSERT INTO valores_financeiros (empresa_id, periodo_id, metrica_id, valor, tipo_consolidacao, localizacao_fonte_id) VALUES
(1, 1, 56, 7136590.0,  'controladora', 3),
(1, 3, 56, 7529680.0,  'controladora', 3),
(1, 1, 56, 8762176.0,  'consolidado',  3),
(1, 3, 56, 8252813.0,  'consolidado',  3),
(1, 1, 57, -5290173.0, 'controladora', 3),
(1, 3, 57, -5690187.0, 'controladora', 3),
(1, 1, 57, -6330426.0, 'consolidado',  3),
(1, 3, 57, -6182711.0, 'consolidado',  3),
(1, 1, 58, 1846417.0,  'controladora', 3),
(1, 3, 58, 1839493.0,  'controladora', 3),
(1, 1, 58, 2431750.0,  'consolidado',  3),
(1, 3, 58, 2070102.0,  'consolidado',  3),
(1, 1, 59, -1332924.0, 'controladora', 3),
(1, 3, 59, -1308121.0, 'controladora', 3),
(1, 1, 59, -1589233.0, 'consolidado',  3),
(1, 3, 59, -1420206.0, 'consolidado',  3),
(1, 1, 60, -214963.0,  'controladora', 3),
(1, 3, 60, -173658.0,  'controladora', 3),
(1, 1, 60, -352387.0,  'consolidado',  3),
(1, 3, 60, -225556.0,  'consolidado',  3),
(1, 1, 62, -210098.0,  'controladora', 3),
(1, 3, 62, -148646.0,  'controladora', 3),
(1, 1, 62, -265059.0,  'consolidado',  3),
(1, 3, 62, -178326.0,  'consolidado',  3),
(1, 1, 66, 181464.0,   'controladora', 3),
(1, 3, 66, 31077.0,    'controladora', 3),
(1, 1, 66, 204694.0,   'consolidado',  3),
(1, 3, 66, 33591.0,    'consolidado',  3),
(1, 1, 67, -533965.0,  'controladora', 3),
(1, 3, 67, -181738.0,  'controladora', 3),
(1, 1, 67, -626804.0,  'consolidado',  3),
(1, 3, 67, -203919.0,  'consolidado',  3),
(1, 1, 68, -352501.0,  'controladora', 3),
(1, 3, 68, -150661.0,  'controladora', 3),
(1, 1, 68, -422110.0,  'consolidado',  3),
(1, 3, 68, -170328.0,  'consolidado',  3),
(1, 1, 69, -354484.0,  'controladora', 3),
(1, 3, 69, 334545.0,   'controladora', 3),
(1, 1, 69, -347662.0,  'consolidado',  3),
(1, 3, 69, 346935.0,   'consolidado',  3),
(1, 1, 70, 193185.0,   'controladora', 3),
(1, 3, 70, -75905.0,   'controladora', 3),
(1, 1, 70, 186363.0,   'consolidado',  3),
(1, 3, 70, -88295.0,   'consolidado',  3),
(1, 1, 71, -161299.0,  'controladora', 3),
(1, 3, 71, 258640.0,   'controladora', 3),
(1, 1, 71, -161299.0,  'consolidado',  3),
(1, 3, 71, 258640.0,   'consolidado',  3),
(1, 1, 72, -0.024,     'consolidado',  3),
(1, 3, 72, 0.040,      'consolidado',  3);

-- ============================================================
-- VALORES_FINANCEIROS — DFC (p.10)
-- ============================================================
INSERT INTO valores_financeiros (empresa_id, periodo_id, metrica_id, valor, tipo_consolidacao, localizacao_fonte_id) VALUES
(1, 1, 75, -161299.0,  'controladora', 4),
(1, 3, 75, 258640.0,   'controladora', 4),
(1, 1, 75, -161299.0,  'consolidado',  4),
(1, 3, 75, 258640.0,   'consolidado',  4),
(1, 1, 76, 210098.0,   'controladora', 4),
(1, 3, 76, 148646.0,   'controladora', 4),
(1, 1, 76, 265059.0,   'consolidado',  4),
(1, 3, 76, 178326.0,   'consolidado',  4),
(1, 1, 77, 985019.0,   'controladora', 4),
(1, 3, 77, -915767.0,  'controladora', 4),
(1, 1, 77, 1016610.0,  'consolidado',  4),
(1, 3, 77, -900484.0,  'consolidado',  4),
(1, 1, 78, 1114199.0,  'controladora', 4),
(1, 3, 78, 1153148.0,  'controladora', 4),
(1, 1, 78, 782942.0,   'consolidado',  4),
(1, 3, 78, 1012246.0,  'consolidado',  4),
(1, 1, 79, -3635210.0, 'controladora', 4),
(1, 3, 79, -1097401.0, 'controladora', 4),
(1, 1, 79, -3850466.0, 'consolidado',  4),
(1, 3, 79, -1431015.0, 'consolidado',  4),
(1, 1, 80, 28526.0,    'controladora', 4),
(1, 3, 80, -122941.0,  'controladora', 4),
(1, 1, 80, -231503.0,  'consolidado',  4),
(1, 3, 80, -487177.0,  'consolidado',  4),
(1, 1, 82, -87969.0,   'controladora', 4),
(1, 3, 82, -92408.0,   'controladora', 4),
(1, 1, 82, -99978.0,   'consolidado',  4),
(1, 3, 82, -94686.0,   'consolidado',  4),
(1, 1, 83, -58901.0,   'controladora', 4),
(1, 3, 83, -58234.0,   'controladora', 4),
(1, 1, 83, -74587.0,   'consolidado',  4),
(1, 3, 83, -65945.0,   'consolidado',  4),
(1, 1, 84, -695993.0,  'controladora', 4),
(1, 3, 84, -396729.0,  'controladora', 4),
(1, 1, 84, -672851.0,  'consolidado',  4),
(1, 3, 84, -197712.0,  'consolidado',  4),
(1, 1, 86, 0.0,        'controladora', 4),
(1, 3, 86, 800000.0,   'controladora', 4),
(1, 1, 86, 0.0,        'consolidado',  4),
(1, 3, 86, 800000.0,   'consolidado',  4),
(1, 1, 87, -2200.0,    'controladora', 4),
(1, 3, 87, -805402.0,  'controladora', 4),
(1, 1, 87, -30651.0,   'consolidado',  4),
(1, 3, 87, -805402.0,  'consolidado',  4),
(1, 1, 88, -211754.0,  'controladora', 4),
(1, 3, 88, -353337.0,  'controladora', 4),
(1, 1, 88, -254660.0,  'consolidado',  4),
(1, 3, 88, -356618.0,  'consolidado',  4),
(1, 1, 89, -879221.0,  'controladora', 4),
(1, 3, 89, -873007.0,  'controladora', 4),
(1, 1, 89, -1159014.0, 'consolidado',  4),
(1, 3, 89, -1041507.0, 'consolidado',  4),
(1, 1, 90, 1458754.0,  'controladora', 4),
(1, 3, 90, 1281569.0,  'controladora', 4),
(1, 1, 90, 2566218.0,  'consolidado',  4),
(1, 3, 90, 1681376.0,  'consolidado',  4),
(1, 1, 91, 579533.0,   'controladora', 4),
(1, 3, 91, 408562.0,   'controladora', 4),
(1, 1, 91, 1407204.0,  'consolidado',  4),
(1, 3, 91, 639869.0,   'consolidado',  4);

-- ============================================================
-- INSTRUMENTOS_DIVIDA — Nota 19 (p.30)
-- Dois registros por modalidade: periodo 1 = 1T22, periodo 2 = 31/12/2021
-- ============================================================
INSERT INTO instrumentos_divida (empresa_id, periodo_id, localizacao_fonte_id, modalidade, encargo, tipo_garantia, data_vencimento, valor_controladora, valor_consolidado) VALUES
-- Notas promissórias
(1, 1, 5, 'Notas promissórias',              '100% CDI + 1,25% a.a.', 'Clean',           '2024-04-29', 1610911.0, 1610911.0),
(1, 2, 5, 'Notas promissórias',              '100% CDI + 1,25% a.a.', 'Clean',           '2024-04-29', 1567971.0, 1567971.0),
-- Debêntures - oferta restrita
(1, 1, 5, 'Debêntures - oferta restrita',    '100% CDI + 1,25% a.a.', 'Clean',           '2026-12-23', 4939814.0, 4939814.0),
(1, 2, 5, 'Debêntures - oferta restrita',    '100% CDI + 1,25% a.a.', 'Clean',           '2026-12-23', 4837054.0, 4837054.0),
-- Capital de giro (KaBuM)
(1, 1, 5, 'Capital de giro',                 'CDI + 1,8% a 4,9% a.a.','Aval',            '2025-10-01',       0.0,  352445.0),
(1, 2, 5, 'Capital de giro',                 'CDI + 1,8% a 4,9% a.a.','Aval',            '2025-10-01',       0.0,  356167.0),
-- FINEP
(1, 1, 5, 'Financiamento de Inovação FINEP', '4% a.a.',               'Fiança bancária', '2022-12-01',    5500.0,    5130.0),
(1, 2, 5, 'Financiamento de Inovação FINEP', '4% a.a.',               'Fiança bancária', '2022-12-01',    7351.0,    7063.0),
-- Outros
(1, 1, 5, 'Outros',                          '113,5% do CDI a.a.',    'Clean',           '2025-10-01',     328.0,    3224.0),
(1, 2, 5, 'Outros',                          '113,5% do CDI a.a.',    'Clean',           '2025-10-01',     329.0,   24617.0);

-- ============================================================
-- NOTAS_EXPLICATIVAS — Nota 19 texto (p.30)
-- ============================================================
INSERT INTO notas_explicativas (empresa_id, periodo_id, localizacao_fonte_id, numero_nota, titulo, conteudo) VALUES
(1, 1, 5, '19a', 'Notas promissórias — 5ª emissão',
'Em 30 de abril de 2021, a Companhia realizou a 5ª emissão de notas promissórias, sendo 1.500 notas com valor nominal de R$ 1.000.000 cada, com vencimento único em 29 de abril de 2024 ao custo de 100% de CDI + 1,25% a.a. Os valores captados têm sido utilizados para otimização do fluxo de caixa no curso e gestão ordinária dos negócios da Companhia. Foram liquidadas em junho de 2021 a 4ª emissão de notas promissórias comerciais.'),

(1, 1, 5, '19b', 'Debêntures — 9ª, 10ª e 11ª emissões',
'A Companhia realizou em 15 de janeiro de 2021 a captação de R$ 800 milhões via distribuição pública com esforços restritos da 9ª Emissão de Debêntures, com remuneração de CDI + 1,25% a.a. e vencimento único em 15 de janeiro de 2024. Em 14 de outubro e 23 de dezembro de 2021, a Companhia em sua estratégia de alongamento de dívida fez sua 10ª e 11ª emissões de debêntures simples, não conversíveis em ações, para distribuição pública com esforços restritos. Foram emitidas 4.000.000 quotas com valor nominal de R$ 1.000 cada, com vencimento final em 15 de outubro e 23 de dezembro de 2026 ao custo de 100% de CDI + 1,25% a.a.'),

(1, 1, 5, '19c', 'Capital de giro — KaBuM',
'Referem-se aos contratos firmados pela controlada KaBuM, com a finalidade de capital de giro.'),

(1, 1, 5, '19d', 'Financiamento de Inovação — FINEP',
'Refere-se a contrato de financiamento junto à Financiadora de Estudos e Projetos - FINEP, com o objetivo de investir em projetos de pesquisa e desenvolvimento de inovações tecnológicas.');
