-- Realizado x Meta por mês
-- Compara o faturamento realizado com a meta mensal

SELECT
    EXTRACT(YEAR FROM p.data_pedido) AS ano,
    EXTRACT(MONTH FROM p.data_pedido) AS mes,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(m.meta_faturamento) AS meta_faturamento,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) - SUM(m.meta_faturamento) AS diferenca_meta,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto))
        / NULLIF(SUM(m.meta_faturamento), 0) AS atingimento_meta
FROM pedidos p
INNER JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
INNER JOIN metas m
    ON EXTRACT(YEAR FROM p.data_pedido) = m.ano
    AND EXTRACT(MONTH FROM p.data_pedido) = m.mes
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    EXTRACT(YEAR FROM p.data_pedido),
    EXTRACT(MONTH FROM p.data_pedido)
ORDER BY
    ano,
    mes;
