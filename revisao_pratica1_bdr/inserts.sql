--Insert das Lojas
INSERT INTO loja (id_loja, nome, cidade) VALUES
(1, '1000STORE', 'São Paulo'),
(2, 'FatecGames', 'Rio de Janeiro'),
(3, 'Grandes Jogos', 'Belo Horizonte');

INSERT INTO cliente (id_cliente, nome, email, cidade) VALUES
(1, 'Ayrton Senna', 'Ayrton.Senna@email.com', 'São Paulo'),
(2, 'Ryan', 'granderyan@email.com', 'Rio de Janeiro'),
(3, 'Nicolas', 'nick@email.com', 'Belo Horizonte');

INSERT INTO jogo (id_jogo, titulo, ano_lancamento, genero) VALUES
(1, 'The Legend of Nick: Breath of the Arley', '2017-03-03', 'Aventura'),
(2, 'Ryan of War', '2018-04-20', 'Ação'),
(3, 'Ayrton Valley', '2016-02-26', 'Simulação');

INSERT INTO compra (id_compra, data_compra, id_cliente, id_loja) VALUES
(1, '2025-09-01', 1, 1),  
(2, '2025-09-03', 2, 2);  

-- Compra de jogos
INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(1, 1, 1),  
(1, 3, 2);  


INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(2, 2, 1),  
(2, 3, 1);  
