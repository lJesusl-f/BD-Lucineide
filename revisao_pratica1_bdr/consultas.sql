--consulta aos clientes
SELECT * from cliente;

--Jogos dps de 27 de fevereiro 2016
SELECT * from jogo WHERE ano_lancamento > '2016-02-27';

--Jogos comprados no total
SELECT SUM(quantidade) AS total_jogos_comprados
FROM compra_jogo;