-- Realizado x Meta por mês
-- Compara o faturamento realizado com a meta mensal sem duplicar a meta

WITH realizado AS (
    SELECT
        EXTRACT(YEAR FROM p.data_pedido) AS ano,
        EXTRACT(MONTH FROM p.data_pedido) AS mes,
        SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento
    FROM pedidos p
    INNER JOIN itens_pedido ip
        ON p.id_pedido = ip.id_pedido
    WHERE p.status_pedido <> 'Cancelado'
    GROUP BY
        EXTRACT(YEAR FROM p.data_pedido),
        EXTRACT(MONTH FROM p.data_pedido)
),

meta_mensal AS (
    SELECT
        ano,
        mes,
        SUM(meta_faturamento) AS meta_faturamento
    FROM metas
    GROUP BY
        ano,
        mes
)

SELECT
    r.ano,
    r.mes,
    r.faturamento,
    m.meta_faturamento,
    r.faturamento - m.meta_faturamento AS diferenca_meta,
    r.faturamento / NULLIF(m.meta_faturamento, 0) AS atingimento_meta
FROM realizado r
INNER JOIN meta_mensal m
    ON r.ano = m.ano
    AND r.mes = m.mes
ORDER BY
    r.ano,
    r.mes;