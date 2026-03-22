-- Atthena Case — Seed SQL
-- Dados reais do ITR Magazine Luiza 1T22
-- Valores em milhares de reais (BRL_thousands)

-- ============================================================
-- COMPANIES
-- ============================================================
INSERT INTO companies (id, name, ticker) VALUES
(1, 'Magazine Luiza S.A.', 'MGLU3');

-- ============================================================
-- PERIODS
-- ============================================================
INSERT INTO periods (id, date_start, date_end, period_type, fiscal_year, fiscal_quarter) VALUES
(1, '2022-01-01', '2022-03-31', 'quarterly', 2022, 1),
(2, '2021-01-01', '2021-12-31', 'annual',    2021, NULL),
(3, '2021-01-01', '2021-03-31', 'quarterly', 2021, 1);

-- ============================================================
-- SOURCES
-- ============================================================
INSERT INTO sources (id, company_id, document_type, file_name, publication_date) VALUES
(1, 1, 'ITR', 'MGLU_DF_POR_1T22.pdf', '2022-05-13');

-- ============================================================
-- SOURCE LOCATIONS
-- ============================================================
INSERT INTO source_locations (id, source_id, page_number, section_name) VALUES
(1,  1, 5,  'Balanço Patrimonial — Ativo'),
(2,  1, 6,  'Balanço Patrimonial — Passivo e Patrimônio Líquido'),
(3,  1, 7,  'Demonstração dos Resultados'),
(4,  1, 10, 'Demonstração dos Fluxos de Caixa'),
(5,  1, 30, 'Nota 19 — Empréstimos e Financiamentos');

-- ============================================================
-- METRICS — Balanço Patrimonial Ativo (p.5)
-- ============================================================
INSERT INTO metrics (id, name, statement_type, level_type, unit, parent_id) VALUES
-- Grupos principais
(1,  'Ativo Circulante',                                    'balance_sheet', 'group',     'BRL_thousands', NULL),
(2,  'Ativo Não Circulante',                                'balance_sheet', 'group',     'BRL_thousands', NULL),
-- Ativo Circulante
(3,  'Caixa e equivalentes de caixa',                      'balance_sheet', 'line_item', 'BRL_thousands', 1),
(4,  'Títulos e valores mobiliários',                       'balance_sheet', 'line_item', 'BRL_thousands', 1),
(5,  'Contas a receber',                                    'balance_sheet', 'line_item', 'BRL_thousands', 1),
(6,  'Estoques',                                            'balance_sheet', 'line_item', 'BRL_thousands', 1),
(7,  'Contas a receber de partes relacionadas',             'balance_sheet', 'line_item', 'BRL_thousands', 1),
(8,  'Tributos a recuperar',                                'balance_sheet', 'line_item', 'BRL_thousands', 1),
(9,  'Imposto de renda e contribuição social a recuperar',  'balance_sheet', 'line_item', 'BRL_thousands', 1),
(10, 'Outros ativos circulantes',                           'balance_sheet', 'line_item', 'BRL_thousands', 1),
(11, 'Total do ativo circulante',                           'balance_sheet', 'group',     'BRL_thousands', 1),
-- Ativo Não Circulante
(12, 'Contas a receber não circulante',                     'balance_sheet', 'line_item', 'BRL_thousands', 2),
(13, 'Tributos a recuperar não circulante',                 'balance_sheet', 'line_item', 'BRL_thousands', 2),
(14, 'Imposto de renda e contribuição social diferidos',    'balance_sheet', 'line_item', 'BRL_thousands', 2),
(15, 'Depósitos judiciais',                                 'balance_sheet', 'line_item', 'BRL_thousands', 2),
(16, 'Outros ativos não circulantes',                       'balance_sheet', 'line_item', 'BRL_thousands', 2),
(17, 'Investimentos em controladas',                        'balance_sheet', 'line_item', 'BRL_thousands', 2),
(18, 'Investimentos em controladas em conjunto',            'balance_sheet', 'line_item', 'BRL_thousands', 2),
(19, 'Direito de uso de arrendamento',                      'balance_sheet', 'line_item', 'BRL_thousands', 2),
(20, 'Imobilizado',                                         'balance_sheet', 'line_item', 'BRL_thousands', 2),
(21, 'Intangível',                                          'balance_sheet', 'line_item', 'BRL_thousands', 2),
(22, 'Total do ativo não circulante',                       'balance_sheet', 'group',     'BRL_thousands', 2),
(23, 'Total do ativo',                                      'balance_sheet', 'group',     'BRL_thousands', NULL);

-- ============================================================
-- METRICS — Balanço Patrimonial Passivo + PL (p.6)
-- ============================================================
INSERT INTO metrics (id, name, statement_type, level_type, unit, parent_id) VALUES
-- Passivo Circulante
(24, 'Passivo Circulante',                                          'balance_sheet', 'group',     'BRL_thousands', NULL),
(25, 'Fornecedores',                                                'balance_sheet', 'line_item', 'BRL_thousands', 24),
(26, 'Parceiros e outros depósitos',                                'balance_sheet', 'line_item', 'BRL_thousands', 24),
(27, 'Empréstimos e financiamentos circulante',                     'balance_sheet', 'line_item', 'BRL_thousands', 24),
(28, 'Salários, férias e encargos sociais',                         'balance_sheet', 'line_item', 'BRL_thousands', 24),
(29, 'Tributos a recolher',                                         'balance_sheet', 'line_item', 'BRL_thousands', 24),
(30, 'Contas a pagar a partes relacionadas',                        'balance_sheet', 'line_item', 'BRL_thousands', 24),
(31, 'Arrendamento mercantil circulante',                           'balance_sheet', 'line_item', 'BRL_thousands', 24),
(32, 'Receita diferida circulante',                                 'balance_sheet', 'line_item', 'BRL_thousands', 24),
(33, 'Dividendos a pagar',                                          'balance_sheet', 'line_item', 'BRL_thousands', 24),
(34, 'Outras contas a pagar circulante',                            'balance_sheet', 'line_item', 'BRL_thousands', 24),
(35, 'Total do passivo circulante',                                 'balance_sheet', 'group',     'BRL_thousands', 24),
-- Passivo Não Circulante
(36, 'Passivo Não Circulante',                                      'balance_sheet', 'group',     'BRL_thousands', NULL),
(37, 'Empréstimos e financiamentos não circulante',                 'balance_sheet', 'line_item', 'BRL_thousands', 36),
(38, 'Tributos a recolher não circulante',                          'balance_sheet', 'line_item', 'BRL_thousands', 36),
(39, 'Arrendamento mercantil não circulante',                       'balance_sheet', 'line_item', 'BRL_thousands', 36),
(40, 'Imposto de renda diferido passivo',                           'balance_sheet', 'line_item', 'BRL_thousands', 36),
(41, 'Provisão para riscos tributários, cíveis e trabalhistas',     'balance_sheet', 'line_item', 'BRL_thousands', 36),
(42, 'Receita diferida não circulante',                             'balance_sheet', 'line_item', 'BRL_thousands', 36),
(43, 'Outras contas a pagar não circulante',                        'balance_sheet', 'line_item', 'BRL_thousands', 36),
(44, 'Total do passivo não circulante',                             'balance_sheet', 'group',     'BRL_thousands', 36),
(45, 'Total do passivo',                                            'balance_sheet', 'group',     'BRL_thousands', NULL),
-- Patrimônio Líquido
(46, 'Patrimônio Líquido',                                          'balance_sheet', 'group',     'BRL_thousands', NULL),
(47, 'Capital social',                                              'balance_sheet', 'line_item', 'BRL_thousands', 46),
(48, 'Reserva de capital',                                          'balance_sheet', 'line_item', 'BRL_thousands', 46),
(49, 'Ações em tesouraria',                                         'balance_sheet', 'line_item', 'BRL_thousands', 46),
(50, 'Reserva legal',                                               'balance_sheet', 'line_item', 'BRL_thousands', 46),
(51, 'Reserva de lucros',                                           'balance_sheet', 'line_item', 'BRL_thousands', 46),
(52, 'Ajuste de avaliação patrimonial',                             'balance_sheet', 'line_item', 'BRL_thousands', 46),
(53, 'Prejuízo líquido do período',                                 'balance_sheet', 'line_item', 'BRL_thousands', 46),
(54, 'Total do patrimônio líquido',                                 'balance_sheet', 'group',     'BRL_thousands', 46),
(55, 'Total do Passivo e Patrimônio Líquido',                       'balance_sheet', 'group',     'BRL_thousands', NULL);

-- ============================================================
-- METRICS — DRE (p.7)
-- ============================================================
INSERT INTO metrics (id, name, statement_type, level_type, unit, parent_id) VALUES
(56, 'Receita líquida de vendas',                                           'income_statement', 'line_item', 'BRL_thousands', NULL),
(57, 'Custo das mercadorias revendidas e das prestações de serviços',       'income_statement', 'line_item', 'BRL_thousands', NULL),
(58, 'Lucro bruto',                                                         'income_statement', 'group',     'BRL_thousands', NULL),
(59, 'Despesas com vendas',                                                 'income_statement', 'line_item', 'BRL_thousands', NULL),
(60, 'Despesas gerais e administrativas',                                   'income_statement', 'line_item', 'BRL_thousands', NULL),
(61, 'Perdas por redução ao valor recuperável de créditos',                 'income_statement', 'line_item', 'BRL_thousands', NULL),
(62, 'Depreciação e amortização',                                           'income_statement', 'line_item', 'BRL_thousands', NULL),
(63, 'Resultado de equivalência patrimonial',                               'income_statement', 'line_item', 'BRL_thousands', NULL),
(64, 'Outras receitas operacionais líquidas',                               'income_statement', 'line_item', 'BRL_thousands', NULL),
(65, 'Lucro operacional antes do resultado financeiro',                     'income_statement', 'group',     'BRL_thousands', NULL),
(66, 'Receitas financeiras',                                                'income_statement', 'line_item', 'BRL_thousands', NULL),
(67, 'Despesas financeiras',                                                'income_statement', 'line_item', 'BRL_thousands', NULL),
(68, 'Resultado financeiro',                                                'income_statement', 'group',     'BRL_thousands', NULL),
(69, 'Lucro operacional antes do imposto de renda',                         'income_statement', 'group',     'BRL_thousands', NULL),
(70, 'Imposto de renda e contribuição social correntes e diferidos',        'income_statement', 'line_item', 'BRL_thousands', NULL),
(71, 'Lucro líquido do período',                                            'income_statement', 'group',     'BRL_thousands', NULL),
(72, 'Lucro básico por ação',                                               'income_statement', 'line_item', 'BRL_per_share',  NULL),
(73, 'Lucro diluído por ação',                                              'income_statement', 'line_item', 'BRL_per_share',  NULL);

-- ============================================================
-- METRICS — DFC (p.10)
-- ============================================================
INSERT INTO metrics (id, name, statement_type, level_type, unit, parent_id) VALUES
(74, 'Fluxo de caixa das atividades operacionais',      'cash_flow', 'group',     'BRL_thousands', NULL),
(75, 'Lucro líquido do período',                        'cash_flow', 'line_item', 'BRL_thousands', 74),
(76, 'Depreciação e amortização',                       'cash_flow', 'line_item', 'BRL_thousands', 74),
(77, 'Estoques',                                        'cash_flow', 'line_item', 'BRL_thousands', 74),
(78, 'Contas a receber',                                'cash_flow', 'line_item', 'BRL_thousands', 74),
(79, 'Fornecedores',                                    'cash_flow', 'line_item', 'BRL_thousands', 74),
(80, 'Fluxo de caixa aplicado nas atividades operacionais', 'cash_flow', 'group', 'BRL_thousands', 74),
(81, 'Fluxo de caixa das atividades de investimento',   'cash_flow', 'group',     'BRL_thousands', NULL),
(82, 'Aquisição de imobilizado',                        'cash_flow', 'line_item', 'BRL_thousands', 81),
(83, 'Aquisição de ativo intangível',                   'cash_flow', 'line_item', 'BRL_thousands', 81),
(84, 'Fluxo de caixa aplicado nas atividades de investimento', 'cash_flow', 'group', 'BRL_thousands', 81),
(85, 'Fluxo de caixa das atividades de financiamento',  'cash_flow', 'group',     'BRL_thousands', NULL),
(86, 'Captação de empréstimos e financiamentos',        'cash_flow', 'line_item', 'BRL_thousands', 85),
(87, 'Pagamento de empréstimos e financiamentos',       'cash_flow', 'line_item', 'BRL_thousands', 85),
(88, 'Fluxo de caixa aplicado nas atividades de financiamento', 'cash_flow', 'group', 'BRL_thousands', 85),
(89, 'Aumento (redução) do saldo de caixa',             'cash_flow', 'group',     'BRL_thousands', NULL),
(90, 'Caixa no início do período',                      'cash_flow', 'line_item', 'BRL_thousands', NULL),
(91, 'Caixa no fim do período',                         'cash_flow', 'line_item', 'BRL_thousands', NULL);

-- ============================================================
-- FINANCIAL VALUES — Balanço Ativo (p.5)
-- controladora: periods 1 (1T22) e 2 (31/12/2021)
-- consolidado:  periods 1 (1T22) e 2 (31/12/2021)
-- ============================================================
INSERT INTO financial_values (company_id, period_id, metric_id, value, consolidation_type, source_location_id) VALUES
-- Caixa e equivalentes de caixa
(1, 1, 3,  579533.0,   'controladora', 1),
(1, 2, 3,  1458754.0,  'controladora', 1),
(1, 1, 3,  1407204.0,  'consolidado',  1),
(1, 2, 3,  2566218.0,  'consolidado',  1),
-- Títulos e valores mobiliários
(1, 1, 4,  584427.0,   'controladora', 1),
(1, 2, 4,  1556211.0,  'controladora', 1),
(1, 1, 4,  584427.0,   'consolidado',  1),
(1, 2, 4,  1556371.0,  'consolidado',  1),
-- Contas a receber
(1, 1, 5,  2762578.0,  'controladora', 1),
(1, 2, 5,  3928531.0,  'controladora', 1),
(1, 1, 5,  4801071.0,  'consolidado',  1),
(1, 2, 5,  5650759.0,  'consolidado',  1),
-- Estoques
(1, 1, 6,  6870322.0,  'controladora', 1),
(1, 2, 6,  7873544.0,  'controladora', 1),
(1, 1, 6,  8077255.0,  'consolidado',  1),
(1, 2, 6,  9112214.0,  'consolidado',  1),
-- Contas a receber de partes relacionadas
(1, 1, 7,  3461072.0,  'controladora', 1),
(1, 2, 7,  4201742.0,  'controladora', 1),
(1, 1, 7,  2887052.0,  'consolidado',  1),
(1, 2, 7,  3707284.0,  'consolidado',  1),
-- Tributos a recuperar
(1, 1, 8,  1154812.0,  'controladora', 1),
(1, 2, 8,  1151721.0,  'controladora', 1),
(1, 1, 8,  1316808.0,  'consolidado',  1),
(1, 2, 8,  1279257.0,  'consolidado',  1),
-- IR e CSLL a recuperar
(1, 1, 9,  216693.0,   'controladora', 1),
(1, 2, 9,  205312.0,   'controladora', 1),
(1, 1, 9,  250086.0,   'consolidado',  1),
(1, 2, 9,  234886.0,   'consolidado',  1),
-- Outros ativos circulantes
(1, 1, 10, 133574.0,   'controladora', 1),
(1, 2, 10, 136516.0,   'controladora', 1),
(1, 1, 10, 267369.0,   'consolidado',  1),
(1, 2, 10, 402821.0,   'consolidado',  1),
-- Total ativo circulante
(1, 1, 11, 15763011.0, 'controladora', 1),
(1, 2, 11, 20512331.0, 'controladora', 1),
(1, 1, 11, 19591272.0, 'consolidado',  1),
(1, 2, 11, 24509810.0, 'consolidado',  1),
-- Ativo não circulante
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
-- Total ativo não circulante
(1, 1, 22, 14325811.0, 'controladora', 1),
(1, 2, 22, 13750408.0, 'controladora', 1),
(1, 1, 22, 14169950.0, 'consolidado',  1),
(1, 2, 22, 13874806.0, 'consolidado',  1),
-- Total do ativo
(1, 1, 23, 30088822.0, 'controladora', 1),
(1, 2, 23, 34262739.0, 'controladora', 1),
(1, 1, 23, 33761222.0, 'consolidado',  1),
(1, 2, 23, 38384616.0, 'consolidado',  1);

-- ============================================================
-- FINANCIAL VALUES — Balanço Passivo + PL (p.6)
-- ============================================================
INSERT INTO financial_values (company_id, period_id, metric_id, value, consolidation_type, source_location_id) VALUES
-- Fornecedores
(1, 1, 25, 5473332.0,  'controladora', 2),
(1, 2, 25, 9108542.0,  'controladora', 2),
(1, 1, 25, 6248478.0,  'consolidado',  2),
(1, 2, 25, 10098944.0, 'consolidado',  2),
-- Parceiros e outros depósitos
(1, 1, 26, 0.0,        'controladora', 2),
(1, 2, 26, 0.0,        'controladora', 2),
(1, 1, 26, 1488933.0,  'consolidado',  2),
(1, 2, 26, 1418897.0,  'consolidado',  2),
-- Empréstimos circulante
(1, 1, 27, 145013.0,   'controladora', 2),
(1, 2, 27, 44100.0,    'controladora', 2),
(1, 1, 27, 494447.0,   'consolidado',  2),
(1, 2, 27, 407968.0,   'consolidado',  2),
-- Salários e encargos
(1, 1, 28, 225632.0,   'controladora', 2),
(1, 2, 28, 237270.0,   'controladora', 2),
(1, 1, 28, 376392.0,   'consolidado',  2),
(1, 2, 28, 370176.0,   'consolidado',  2),
-- Tributos a recolher
(1, 1, 29, 105505.0,   'controladora', 2),
(1, 2, 29, 146332.0,   'controladora', 2),
(1, 1, 29, 198615.0,   'consolidado',  2),
(1, 2, 29, 239595.0,   'consolidado',  2),
-- Arrendamento circulante
(1, 1, 31, 418373.0,   'controladora', 2),
(1, 2, 31, 415329.0,   'controladora', 2),
(1, 1, 31, 439675.0,   'consolidado',  2),
(1, 2, 31, 433834.0,   'consolidado',  2),
-- Total passivo circulante
(1, 1, 35, 7628821.0,  'controladora', 2),
(1, 2, 35, 11763513.0, 'controladora', 2),
(1, 1, 35, 10882823.0, 'consolidado',  2),
(1, 2, 35, 15257189.0, 'consolidado',  2),
-- Empréstimos não circulante
(1, 1, 37, 6411540.0,  'controladora', 2),
(1, 2, 37, 6368605.0,  'controladora', 2),
(1, 1, 37, 6417077.0,  'consolidado',  2),
(1, 2, 37, 6384904.0,  'consolidado',  2),
-- Arrendamento não circulante
(1, 1, 39, 3049424.0,  'controladora', 2),
(1, 2, 39, 2996959.0,  'controladora', 2),
(1, 1, 39, 3069353.0,  'consolidado',  2),
(1, 2, 39, 3020844.0,  'consolidado',  2),
-- Provisão para riscos
(1, 1, 41, 739503.0,   'controladora', 2),
(1, 2, 41, 717977.0,   'controladora', 2),
(1, 1, 41, 1111483.0,  'consolidado',  2),
(1, 2, 41, 1154109.0,  'consolidado',  2),
-- Total passivo não circulante
(1, 1, 44, 11341757.0, 'controladora', 2),
(1, 2, 44, 11237995.0, 'controladora', 2),
(1, 1, 44, 11760155.0, 'consolidado',  2),
(1, 2, 44, 11866196.0, 'consolidado',  2),
-- Total passivo
(1, 1, 45, 18970578.0, 'controladora', 2),
(1, 2, 45, 23001508.0, 'controladora', 2),
(1, 1, 45, 22642978.0, 'consolidado',  2),
(1, 2, 45, 27123385.0, 'consolidado',  2),
-- Patrimônio Líquido
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
-- Total PL
(1, 1, 54, 11118244.0,  'controladora', 2),
(1, 2, 54, 11261231.0,  'controladora', 2),
(1, 1, 54, 11118244.0,  'consolidado',  2),
(1, 2, 54, 11261231.0,  'consolidado',  2),
-- Total Passivo + PL
(1, 1, 55, 30088822.0,  'controladora', 2),
(1, 2, 55, 34262739.0,  'controladora', 2),
(1, 1, 55, 33761222.0,  'consolidado',  2),
(1, 2, 55, 38384616.0,  'consolidado',  2);

-- ============================================================
-- FINANCIAL VALUES — DRE (p.7)
-- periods: 1 = 1T22, 3 = 1T21
-- ============================================================
INSERT INTO financial_values (company_id, period_id, metric_id, value, consolidation_type, source_location_id) VALUES
-- Receita líquida
(1, 1, 56, 7136590.0,  'controladora', 3),
(1, 3, 56, 7529680.0,  'controladora', 3),
(1, 1, 56, 8762176.0,  'consolidado',  3),
(1, 3, 56, 8252813.0,  'consolidado',  3),
-- CMV
(1, 1, 57, -5290173.0, 'controladora', 3),
(1, 3, 57, -5690187.0, 'controladora', 3),
(1, 1, 57, -6330426.0, 'consolidado',  3),
(1, 3, 57, -6182711.0, 'consolidado',  3),
-- Lucro bruto
(1, 1, 58, 1846417.0,  'controladora', 3),
(1, 3, 58, 1839493.0,  'controladora', 3),
(1, 1, 58, 2431750.0,  'consolidado',  3),
(1, 3, 58, 2070102.0,  'consolidado',  3),
-- Despesas com vendas
(1, 1, 59, -1332924.0, 'controladora', 3),
(1, 3, 59, -1308121.0, 'controladora', 3),
(1, 1, 59, -1589233.0, 'consolidado',  3),
(1, 3, 59, -1420206.0, 'consolidado',  3),
-- G&A
(1, 1, 60, -214963.0,  'controladora', 3),
(1, 3, 60, -173658.0,  'controladora', 3),
(1, 1, 60, -352387.0,  'consolidado',  3),
(1, 3, 60, -225556.0,  'consolidado',  3),
-- Depreciação e amortização
(1, 1, 62, -210098.0,  'controladora', 3),
(1, 3, 62, -148646.0,  'controladora', 3),
(1, 1, 62, -265059.0,  'consolidado',  3),
(1, 3, 62, -178326.0,  'consolidado',  3),
-- Resultado financeiro
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
-- Lucro antes IR
(1, 1, 69, -354484.0,  'controladora', 3),
(1, 3, 69, 334545.0,   'controladora', 3),
(1, 1, 69, -347662.0,  'consolidado',  3),
(1, 3, 69, 346935.0,   'consolidado',  3),
-- IR e CSLL
(1, 1, 70, 193185.0,   'controladora', 3),
(1, 3, 70, -75905.0,   'controladora', 3),
(1, 1, 70, 186363.0,   'consolidado',  3),
(1, 3, 70, -88295.0,   'consolidado',  3),
-- Lucro líquido
(1, 1, 71, -161299.0,  'controladora', 3),
(1, 3, 71, 258640.0,   'controladora', 3),
(1, 1, 71, -161299.0,  'consolidado',  3),
(1, 3, 71, 258640.0,   'consolidado',  3),
-- LPA
(1, 1, 72, -0.024,     'consolidado',  3),
(1, 3, 72, 0.040,      'consolidado',  3);

-- ============================================================
-- FINANCIAL VALUES — DFC (p.10)
-- ============================================================
INSERT INTO financial_values (company_id, period_id, metric_id, value, consolidation_type, source_location_id) VALUES
-- Lucro líquido (DFC)
(1, 1, 75, -161299.0,  'controladora', 4),
(1, 3, 75, 258640.0,   'controladora', 4),
(1, 1, 75, -161299.0,  'consolidado',  4),
(1, 3, 75, 258640.0,   'consolidado',  4),
-- Depreciação (DFC)
(1, 1, 76, 210098.0,   'controladora', 4),
(1, 3, 76, 148646.0,   'controladora', 4),
(1, 1, 76, 265059.0,   'consolidado',  4),
(1, 3, 76, 178326.0,   'consolidado',  4),
-- Estoques (DFC)
(1, 1, 77, 985019.0,   'controladora', 4),
(1, 3, 77, -915767.0,  'controladora', 4),
(1, 1, 77, 1016610.0,  'consolidado',  4),
(1, 3, 77, -900484.0,  'consolidado',  4),
-- Contas a receber (DFC)
(1, 1, 78, 1114199.0,  'controladora', 4),
(1, 3, 78, 1153148.0,  'controladora', 4),
(1, 1, 78, 782942.0,   'consolidado',  4),
(1, 3, 78, 1012246.0,  'consolidado',  4),
-- Fornecedores (DFC)
(1, 1, 79, -3635210.0, 'controladora', 4),
(1, 3, 79, -1097401.0, 'controladora', 4),
(1, 1, 79, -3850466.0, 'consolidado',  4),
(1, 3, 79, -1431015.0, 'consolidado',  4),
-- Fluxo operacional total
(1, 1, 80, 28526.0,    'controladora', 4),
(1, 3, 80, -122941.0,  'controladora', 4),
(1, 1, 80, -231503.0,  'consolidado',  4),
(1, 3, 80, -487177.0,  'consolidado',  4),
-- Aquisição imobilizado
(1, 1, 82, -87969.0,   'controladora', 4),
(1, 3, 82, -92408.0,   'controladora', 4),
(1, 1, 82, -99978.0,   'consolidado',  4),
(1, 3, 82, -94686.0,   'consolidado',  4),
-- Aquisição intangível
(1, 1, 83, -58901.0,   'controladora', 4),
(1, 3, 83, -58234.0,   'controladora', 4),
(1, 1, 83, -74587.0,   'consolidado',  4),
(1, 3, 83, -65945.0,   'consolidado',  4),
-- Fluxo investimento total
(1, 1, 84, -695993.0,  'controladora', 4),
(1, 3, 84, -396729.0,  'controladora', 4),
(1, 1, 84, -672851.0,  'consolidado',  4),
(1, 3, 84, -197712.0,  'consolidado',  4),
-- Captação empréstimos
(1, 1, 86, 0.0,        'controladora', 4),
(1, 3, 86, 800000.0,   'controladora', 4),
(1, 1, 86, 0.0,        'consolidado',  4),
(1, 3, 86, 800000.0,   'consolidado',  4),
-- Pagamento empréstimos
(1, 1, 87, -2200.0,    'controladora', 4),
(1, 3, 87, -805402.0,  'controladora', 4),
(1, 1, 87, -30651.0,   'consolidado',  4),
(1, 3, 87, -805402.0,  'consolidado',  4),
-- Fluxo financiamento total
(1, 1, 88, -211754.0,  'controladora', 4),
(1, 3, 88, -353337.0,  'controladora', 4),
(1, 1, 88, -254660.0,  'consolidado',  4),
(1, 3, 88, -356618.0,  'consolidado',  4),
-- Variação caixa
(1, 1, 89, -879221.0,  'controladora', 4),
(1, 3, 89, -873007.0,  'controladora', 4),
(1, 1, 89, -1159014.0, 'consolidado',  4),
(1, 3, 89, -1041507.0, 'consolidado',  4),
-- Caixa início
(1, 1, 90, 1458754.0,  'controladora', 4),
(1, 3, 90, 1281569.0,  'controladora', 4),
(1, 1, 90, 2566218.0,  'consolidado',  4),
(1, 3, 90, 1681376.0,  'consolidado',  4),
-- Caixa fim
(1, 1, 91, 579533.0,   'controladora', 4),
(1, 3, 91, 408562.0,   'controladora', 4),
(1, 1, 91, 1407204.0,  'consolidado',  4),
(1, 3, 91, 639869.0,   'consolidado',  4);
