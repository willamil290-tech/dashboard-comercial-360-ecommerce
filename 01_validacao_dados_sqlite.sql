-- Contagem de registros por tabela
SELECT 'clientes' AS tabela, COUNT(*) AS total_registros FROM clientes
UNION ALL
SELECT 'produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'itens_pedido', COUNT(*) FROM itens_pedido
UNION ALL
SELECT 'metas', COUNT(*) FROM metas;

-- Verificar pedidos sem cliente correspondente
SELECT p.*
FROM pedidos p
LEFT JOIN clientes c
    ON p.id_cliente = c.id_cliente
WHERE c.id_cliente IS NULL;

-- Verificar itens sem produto correspondente
SELECT i.*
FROM itens_pedido i
LEFT JOIN produtos pr
    ON i.id_produto = pr.id_produto
WHERE pr.id_produto IS NULL;

-- Verificar itens sem pedido correspondente
SELECT i.*
FROM itens_pedido i
LEFT JOIN pedidos p
    ON i.id_pedido = p.id_pedido
WHERE p.id_pedido IS NULL;

-- Verificar descontos maiores que o preço de venda
SELECT *
FROM itens_pedido
WHERE desconto > preco_venda;