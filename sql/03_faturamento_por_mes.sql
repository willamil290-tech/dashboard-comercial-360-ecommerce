-- Faturamento por mês
-- Considera apenas pedidos válidos, excluindo pedidos cancelados

SELECT
    EXTRACT(YEAR FROM p.data_pedido) AS ano,
    EXTRACT(MONTH FROM p.data_pedido) AS mes,
    SUM(ip.quantidade * ip.preco_venda) AS receita_bruta,
    SUM(ip.quantidade * ip.desconto) AS valor_desconto,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento
FROM pedidos p
INNER JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    EXTRACT(YEAR FROM p.data_pedido),
    EXTRACT(MONTH FROM p.data_pedido)
ORDER BY
    ano,
    mes;
