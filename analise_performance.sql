-- ============================================================
-- PROJETO 1: Dashboard de Performance Comercial
-- Autor: Humberto Mendes dos Santos
-- Contexto: Análise de vendas, KPIs e forecast para apoiar
--           o planejamento comercial
-- ============================================================

-- ------------------------------------------------------------
-- 1. VISÃO GERAL: Faturamento e Margem por Mês
-- ------------------------------------------------------------
SELECT
    ano,
    mes,
    mes_nome,
    ROUND(SUM(faturamento), 2)         AS faturamento_total,
    ROUND(SUM(margem_valor), 2)        AS margem_total,
    ROUND(AVG(margem_pct), 1)          AS margem_media_pct,
    COUNT(*)                           AS total_pedidos
FROM vendas
GROUP BY ano, mes, mes_nome
ORDER BY ano, mes;

-- ------------------------------------------------------------
-- 2. PERFORMANCE POR VENDEDOR: Meta vs. Realizado
-- ------------------------------------------------------------
SELECT
    vendedor,
    mes,
    mes_nome,
    ROUND(SUM(faturamento), 2)                         AS realizado,
    MAX(meta_mensal_vendedor)                          AS meta,
    ROUND(SUM(faturamento) / MAX(meta_mensal_vendedor) * 100, 1) AS atingimento_pct,
    CASE
        WHEN SUM(faturamento) >= MAX(meta_mensal_vendedor) THEN 'Atingiu Meta'
        WHEN SUM(faturamento) >= MAX(meta_mensal_vendedor) * 0.8 THEN 'Próximo da Meta'
        ELSE 'Abaixo da Meta'
    END AS status_meta
FROM vendas
GROUP BY vendedor, mes, mes_nome
ORDER BY mes, atingimento_pct DESC;

-- ------------------------------------------------------------
-- 3. RANKING DE PRODUTOS: Faturamento e Margem
-- ------------------------------------------------------------
SELECT
    segmento,
    produto,
    SUM(quantidade)                    AS qtd_vendida,
    ROUND(SUM(faturamento), 2)         AS faturamento_total,
    ROUND(AVG(margem_pct), 1)          AS margem_media_pct,
    ROUND(SUM(margem_valor), 2)        AS margem_total
FROM vendas
GROUP BY segmento, produto
ORDER BY faturamento_total DESC;

-- ------------------------------------------------------------
-- 4. PERFORMANCE POR REGIÃO
-- ------------------------------------------------------------
SELECT
    regiao,
    segmento,
    ROUND(SUM(faturamento), 2)         AS faturamento,
    ROUND(SUM(margem_valor), 2)        AS margem,
    COUNT(DISTINCT vendedor)           AS qtd_vendedores,
    COUNT(*)                           AS total_pedidos
FROM vendas
GROUP BY regiao, segmento
ORDER BY regiao, faturamento DESC;

-- ------------------------------------------------------------
-- 5. FORECAST SIMPLES: Média móvel últimos 3 meses
-- ------------------------------------------------------------
WITH mensal AS (
    SELECT
        ano,
        mes,
        ROUND(SUM(faturamento), 2) AS faturamento_mes
    FROM vendas
    GROUP BY ano, mes
)
SELECT
    ano,
    mes,
    faturamento_mes,
    ROUND(AVG(faturamento_mes) OVER (
        ORDER BY ano, mes
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS media_movel_3m,
    ROUND(faturamento_mes - LAG(faturamento_mes) OVER (ORDER BY ano, mes), 2) AS variacao_mes_anterior
FROM mensal
ORDER BY ano, mes;

-- ------------------------------------------------------------
-- 6. TOP 3 VENDEDORES DO ANO
-- ------------------------------------------------------------
SELECT
    vendedor,
    ROUND(SUM(faturamento), 2) AS faturamento_total,
    ROUND(SUM(margem_valor), 2) AS margem_total,
    COUNT(*) AS total_pedidos,
    RANK() OVER (ORDER BY SUM(faturamento) DESC) AS ranking
FROM vendas
GROUP BY vendedor
ORDER BY ranking
LIMIT 3;
