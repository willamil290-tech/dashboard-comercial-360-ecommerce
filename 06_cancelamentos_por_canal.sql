-- Pedidos cancelados por canal de venda
-- Analisa volume total, pedidos válidos, pedidos cancelados e taxa de cancelamento

SELECT
    p.canal_venda,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    COUNT(DISTINCT CASE 
        WHEN p.status_pedido <> 'Cancelado' THEN p.id_pedido 
    END) AS pedidos_validos,
    COUNT(DISTINCT CASE 
        WHEN p.status_pedido = 'Cancelado' THEN p.id_pedido 
    END) AS pedidos_cancelados,
    COUNT(DISTINCT CASE 
        WHEN p.status_pedido = 'Cancelado' THEN p.id_pedido 
    END) * 1.0 / NULLIF(COUNT(DISTINCT p.id_pedido), 0) AS percentual_cancelados
FROM pedidos p
GROUP BY
    p.canal_venda
ORDER BY
    percentual_cancelados DESC;