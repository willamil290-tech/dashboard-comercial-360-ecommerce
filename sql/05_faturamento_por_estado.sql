-- Faturamento por estado
-- Considera apenas pedidos válidos, excluindo pedidos cancelados

SELECT
    c.estado,
    COUNT(DISTINCT p.id_pedido) AS pedidos,
    COUNT(DISTINCT c.id_cliente) AS clientes_ativos,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(ip.quantidade * pr.custo_unitario) AS custo_total,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto))
        - SUM(ip.quantidade * pr.custo_unitario) AS lucro_bruto,
    (
        SUM(ip.quantidade * (ip.preco_venda - ip.desconto))
        - SUM(ip.quantidade * pr.custo_unitario)
    ) / NULLIF(SUM(ip.quantidade * (ip.preco_venda - ip.desconto)), 0) AS margem_bruta
FROM pedidos p
INNER JOIN clientes c
    ON p.id_cliente = c.id_cliente
INNER JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
INNER JOIN produtos pr
    ON ip.id_produto = pr.id_produto
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    c.estado
ORDER BY
    faturamento DESC;
