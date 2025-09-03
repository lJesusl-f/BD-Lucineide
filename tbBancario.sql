-- Eliminar as tabelas na ordem correta (dependências primeiro)
DROP TABLE IF EXISTS transacoes;
DROP TABLE IF EXISTS contas;
DROP TABLE IF EXISTS clientes;

-- Tabela: clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15)
);

-- Inserção de dados na tabela clientes
INSERT INTO clientes (nome, cpf, endereco, telefone) VALUES
('João Silva', '12345678900', 'Rua A, 123', '11999990000'),
('Maria Oliveira', '98765432100', 'Rua B, 456', '11988887777');

-- Tabela: contas
CREATE TABLE contas (
    id_conta SERIAL PRIMARY KEY,
    numero_conta VARCHAR(10) UNIQUE NOT NULL,
    saldo DECIMAL(10,2) DEFAULT 0,
    id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

-- Inserção de dados na tabela contas
INSERT INTO contas (numero_conta, saldo, id_cliente) VALUES
('000123', 1500.00, 1),
('000456', 2300.00, 2);

-- Tabela: transacoes
CREATE TABLE transacoes (
    id_transacao SERIAL PRIMARY KEY,
    id_conta INT REFERENCES contas(id_conta) ON DELETE CASCADE,
    tipo VARCHAR(15) CHECK (tipo IN ('Depósito', 'Saque', 'Transferência')),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    destino_transferencia INT REFERENCES contas(id_conta)
);

-- Inserção de dados na tabela transacoes
INSERT INTO transacoes (id_conta, tipo, valor) VALUES
(1, 'Depósito', 500.00),
(2, 'Saque', 200.00);

INSERT INTO transacoes (id_conta, tipo, valor, destino_transferencia) VALUES
(1, 'Transferência', 300.00, 2);

--Exercicico solicitado
INSERT INTO clientes (nome, cpf, endereco, telefone) VALUES
('Ayrton Senna', '38769432100', 'Monaco', '11980087577')

INSERT INTO contas (numero_conta, saldo, id_cliente) VALUES
('101010', 10000.00, 3);

UPDATE contas
SET saldo = saldo + 100
where id_conta = 3;

UPDATE contas
SET saldo = saldo + 100
where id_conta = 1;

SELECT clientes.nome, contas.saldo
FROM clientes
INNER JOIN contas on clientes.id_cliente = contas.id_conta;


SELECT * from contas;