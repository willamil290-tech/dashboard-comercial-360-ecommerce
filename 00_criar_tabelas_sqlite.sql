CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome_cliente TEXT,
    genero TEXT,
    data_nascimento DATE,
    cidade TEXT,
    estado TEXT,
    regiao TEXT,
    data_cadastro DATE
);

CREATE TABLE produtos (
    id_produto INTEGER PRIMARY KEY,
    nome_produto TEXT,
    categoria TEXT,
    subcategoria TEXT,
    marca TEXT,
    preco_unitario REAL,
    custo_unitario REAL
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    data_pedido DATE,
    status_pedido TEXT,
    canal_venda TEXT,
    forma_pagamento TEXT
);

CREATE TABLE itens_pedido (
    id_item INTEGER PRIMARY KEY,
    id_pedido INTEGER,
    id_produto INTEGER,
    quantidade INTEGER,
    preco_venda REAL,
    desconto REAL
);

CREATE TABLE metas (
    ano INTEGER,
    mes INTEGER,
    meta_faturamento REAL,
    meta_lucro REAL
);