# Dicionário de Dados

## clientes

- `id_cliente`: identificador único do cliente.
- `nome_cliente`: nome fictício do cliente.
- `genero`: gênero informado.
- `data_nascimento`: data de nascimento.
- `cidade`: cidade.
- `estado`: UF.
- `regiao`: região do Brasil.
- `data_cadastro`: data de cadastro do cliente.

## produtos

- `id_produto`: identificador único do produto.
- `nome_produto`: nome fictício do produto.
- `categoria`: categoria comercial.
- `subcategoria`: subcategoria comercial.
- `marca`: marca fictícia.
- `preco_unitario`: preço de tabela.
- `custo_unitario`: custo unitário.

## pedidos

- `id_pedido`: identificador único do pedido.
- `id_cliente`: cliente responsável pelo pedido.
- `data_pedido`: data do pedido.
- `status_pedido`: status do pedido.
- `canal_venda`: canal onde o pedido foi feito.
- `forma_pagamento`: forma de pagamento.

## itens_pedido

- `id_item`: identificador único do item.
- `id_pedido`: pedido relacionado.
- `id_produto`: produto vendido.
- `quantidade`: quantidade vendida.
- `preco_venda`: preço de venda por unidade.
- `desconto`: desconto por unidade.

## metas

- `ano`: ano da meta.
- `mes`: mês da meta.
- `meta_faturamento`: meta de faturamento mensal.
- `meta_lucro`: meta de lucro mensal.