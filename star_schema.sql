-- ============================================================
-- STAR SCHEMA — Dashboard de Performance Comercial
-- Autor: Humberto Mendes dos Santos
-- ============================================================

-- ------------------------------------------------------------
-- TABELAS DIMENSÃO
-- ------------------------------------------------------------

-- Dimensão Vendedor
CREATE TABLE dVendedor (
    id_vendedor   SERIAL PRIMARY KEY,
    vendedor      VARCHAR(100) NOT NULL
);

INSERT INTO dVendedor (vendedor)
SELECT DISTINCT vendedor
FROM vendas
ORDER BY vendedor;

-- Dimensão Produto
CREATE TABLE dProduto (
    id_produto  SERIAL PRIMARY KEY,
    produto     VARCHAR(100) NOT NULL,
    segmento    VARCHAR(50)  NOT NULL
);

INSERT INTO dProduto (produto, segmento)
SELECT DISTINCT produto, segmento
FROM vendas
ORDER BY segmento, produto;

-- Dimensão Região
CREATE TABLE dRegiao (
    id_regiao  SERIAL PRIMARY KEY,
    regiao     VARCHAR(50) NOT NULL
);

INSERT INTO dRegiao (regiao)
SELECT DISTINCT regiao
FROM vendas
ORDER BY regiao;

-- Dimensão Calendário
CREATE TABLE dCalendario (
    id_data   DATE PRIMARY KEY,
    ano       INT  NOT NULL,
    mes       INT  NOT NULL,
    mes_nome  VARCHAR(20) NOT NULL
);

INSERT INTO dCalendario (id_data, ano, mes, mes_nome)
SELECT DISTINCT data, ano, mes, mes_nome
FROM vendas
ORDER BY data;

-- ------------------------------------------------------------
-- TABELA FATO
-- ------------------------------------------------------------

CREATE TABLE fVendas (
    id_venda      SERIAL PRIMARY KEY,
    id_data       DATE         NOT NULL,
    id_vendedor   INT          NOT NULL,
    id_produto    INT          NOT NULL,
    id_regiao     INT          NOT NULL,
    quantidade            INT            NOT NULL,
    preco_unitario        NUMERIC(15,2)  NOT NULL,
    faturamento           NUMERIC(15,2)  NOT NULL,
    margem_pct            NUMERIC(5,2)   NOT NULL,
    margem_valor          NUMERIC(15,2)  NOT NULL,
    meta_mensal_vendedor  NUMERIC(15,2)  NOT NULL,

    FOREIGN KEY (id_data)     REFERENCES dCalendario(id_data),
    FOREIGN KEY (id_vendedor) REFERENCES dVendedor(id_vendedor),
    FOREIGN KEY (id_produto)  REFERENCES dProduto(id_produto),
    FOREIGN KEY (id_regiao)   REFERENCES dRegiao(id_regiao)
);

INSERT INTO fVendas (
    id_data, id_vendedor, id_produto, id_regiao,
    quantidade, preco_unitario, faturamento,
    margem_pct, margem_valor, meta_mensal_vendedor
)
SELECT
    v.data,
    dv.id_vendedor,
    dp.id_produto,
    dr.id_regiao,
    v.quantidade,
    v.preco_unitario,
    v.faturamento,
    v.margem_pct,
    v.margem_valor,
    v.meta_mensal_vendedor
FROM vendas v
JOIN dVendedor  dv ON dv.vendedor = v.vendedor
JOIN dProduto   dp ON dp.produto  = v.produto  AND dp.segmento = v.segmento
JOIN dRegiao    dr ON dr.regiao   = v.regiao;
