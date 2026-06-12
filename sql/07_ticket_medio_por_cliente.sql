-- Ticket médio por cliente
-- Considera apenas pedidos válidos, excluindo pedidos cancelados

SELECT
    c.id_cliente,
    c.nome_cliente,
    c.estado,
    COUNT(DISTINCT p.id_pedido) AS pedidos,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto))
        / NULLIF(COUNT(DISTINCT p.id_pedido), 0) AS ticket_medio
FROM pedidos p
INNER JOIN clientes c
    ON p.id_cliente = c.id_cliente
INNER JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    c.id_cliente,
    c.nome_cliente,
    c.estado
ORDER BY
    ticket_medio DESC;
