-- 1. Vendas detalhadas
SELECT
    p.id_pedido,
    p.data_pedido,
    c.id_cliente,
    c.nome_cliente,
    c.estado,
    c.regiao,
    pr.id_produto,
    pr.nome_produto,
    pr.categoria,
    pr.subcategoria,
    i.quantidade,
    i.preco_venda,
    i.desconto,
    pr.custo_unitario,
    i.quantidade * i.preco_venda AS receita_bruta,
    i.quantidade * i.desconto AS valor_desconto,
    i.quantidade * (i.preco_venda - i.desconto) AS receita_liquida,
    i.quantidade * pr.custo_unitario AS custo_total,
    i.quantidade * (i.preco_venda - i.desconto - pr.custo_unitario) AS lucro
FROM itens_pedido i
LEFT JOIN pedidos p
    ON i.id_pedido = p.id_pedido
LEFT JOIN clientes c
    ON p.id_cliente = c.id_cliente
LEFT JOIN produtos pr
    ON i.id_produto = pr.id_produto
WHERE p.status_pedido = 'Concluído';

-- 2. Faturamento por mês
SELECT
    CAST(strftime('%Y', p.data_pedido) AS INTEGER) AS ano,
    CAST(strftime('%m', p.data_pedido) AS INTEGER) AS mes,
    ROUND(SUM(i.quantidade * (i.preco_venda - i.desconto)), 2) AS faturamento
FROM itens_pedido i
LEFT JOIN pedidos p
    ON i.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Concluído'
GROUP BY
    CAST(strftime('%Y', p.data_pedido) AS INTEGER),
    CAST(strftime('%m', p.data_pedido) AS INTEGER)
ORDER BY ano, mes;

-- 3. Ranking de produtos
SELECT
    pr.nome_produto,
    pr.categoria,
    SUM(i.quantidade) AS quantidade_vendida,
    ROUND(SUM(i.quantidade * (i.preco_venda - i.desconto)), 2) AS faturamento
FROM itens_pedido i
LEFT JOIN produtos pr
    ON i.id_produto = pr.id_produto
LEFT JOIN pedidos p
    ON i.id_pedido = p.id_pedido
WHERE p.status_pedido = 'Concluído'
GROUP BY
    pr.nome_produto,
    pr.categoria
ORDER BY faturamento DESC;

-- 4. Clientes sem compra
SELECT
    c.id_cliente,
    c.nome_cliente,
    c.estado,
    c.regiao
FROM clientes c
LEFT JOIN pedidos p
    ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- 5. Venda acumulada por mês usando CTE e window function
WITH vendas_mensais AS (
    SELECT
        CAST(strftime('%Y', p.data_pedido) AS INTEGER) AS ano,
        CAST(strftime('%m', p.data_pedido) AS INTEGER) AS mes,
        ROUND(SUM(i.quantidade * (i.preco_venda - i.desconto)), 2) AS faturamento
    FROM itens_pedido i
    LEFT JOIN pedidos p
        ON i.id_pedido = p.id_pedido
    WHERE p.status_pedido = 'Concluído'
    GROUP BY
        CAST(strftime('%Y', p.data_pedido) AS INTEGER),
        CAST(strftime('%m', p.data_pedido) AS INTEGER)
)
SELECT
    ano,
    mes,
    faturamento,
    ROUND(
        SUM(faturamento) OVER (
            PARTITION BY ano
            ORDER BY mes
        ), 2
    ) AS faturamento_acumulado
FROM vendas_mensais
ORDER BY ano, mes;
