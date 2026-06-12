-- Descontos por categoria
-- Analisa receita bruta, valor de desconto, faturamento e percentual de desconto

SELECT
    pr.categoria,
    SUM(ip.quantidade * ip.preco_venda) AS receita_bruta,
    SUM(ip.quantidade * ip.desconto) AS valor_desconto,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(ip.quantidade * ip.desconto)
        / NULLIF(SUM(ip.quantidade * ip.preco_venda), 0) AS percentual_desconto
FROM itens_pedido ip
INNER JOIN pedidos p
    ON ip.id_pedido = p.id_pedido
INNER JOIN produtos pr
    ON ip.id_produto = pr.id_produto
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    pr.categoria
ORDER BY
    percentual_desconto DESC;