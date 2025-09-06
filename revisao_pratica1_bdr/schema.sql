-- Primeiro, drop das tabelas dependentes (que têm chaves estrangeiras)
DROP TABLE IF EXISTS compra_jogo;
DROP TABLE IF EXISTS compra;

-- Depois, drop das tabelas principais
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS loja;
DROP TABLE IF EXISTS jogo;



CREATE TABLE IF NOT EXISTS loja (
id_loja INT PRIMARY KEY NOT NULL,
nome VARCHAR(100),
cidade VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS jogo (
id_jogo INT PRIMARY KEY NOT NULL,
titulo VARCHAR(100),
ano_lancamento DATE,
genero VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS cliente (
id_cliente INT PRIMARY KEY NOT NULL,
nome VARCHAR(100),
email VARCHAR(100) UNIQUE,
cidade VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS compra (
id_compra INT PRIMARY KEY NOT NULL,
data_compra DATE,
id_cliente INT REFERENCES cliente(id_cliente),
id_loja INT REFERENCES loja(id_loja)
);

CREATE TABLE IF NOT EXISTS compra_jogo (
id_compra INT REFERENCES compra(id_compra),
id_jogo INT REFERENCES jogo(id_jogo),
quantidade INT NOT NULL
);
