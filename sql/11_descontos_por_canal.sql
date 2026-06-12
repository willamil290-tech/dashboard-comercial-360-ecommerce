-- Descontos por canal de venda
-- Analisa quanto cada canal concedeu de desconto e o impacto percentual sobre a receita bruta

SELECT
    p.canal_venda,
    SUM(ip.quantidade * ip.preco_venda) AS receita_bruta,
    SUM(ip.quantidade * ip.desconto) AS valor_desconto,
    SUM(ip.quantidade * (ip.preco_venda - ip.desconto)) AS faturamento,
    SUM(ip.quantidade * ip.desconto)
        / NULLIF(SUM(ip.quantidade * ip.preco_venda), 0) AS percentual_desconto
FROM pedidos p
INNER JOIN itens_pedido ip
    ON p.id_pedido = ip.id_pedido
WHERE p.status_pedido <> 'Cancelado'
GROUP BY
    p.canal_venda
ORDER BY
    percentual_desconto DESC;
