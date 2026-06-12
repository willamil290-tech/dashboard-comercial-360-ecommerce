-- Top 10 produtos por faturamento
-- Considera apenas pedidos válidos, excluindo pedidos cancelados

SELECT
    pr.id_produto,
    pr.nome_produto,
    pr.categoria,
    SUM(ip.quantidade) AS quantidade_vendida,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(ip.quantidade * pr.custo_unitario) AS custo_total,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) 
        - SUM(ip.quantidade * pr.custo_unitario) AS lucro_bruto
FROM itens_pedido ip
INNER JOIN pedidos p
    ON ip.id_pedido = p.id_pedido
INNER JOIN produtos pr
    ON ip.id_produto = pr.id_produto
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    pr.id_produto,
    pr.nome_produto,
    pr.categoria
ORDER BY
    faturamento DESC
LIMIT 10;