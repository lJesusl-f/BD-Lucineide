-- Remover tabelas dependentes primeiro
DROP TABLE IF EXISTS alerta;
DROP TABLE IF EXISTS relato;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS telefone;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS localizacao;
DROP TABLE IF EXISTS estado;
DROP TABLE IF EXISTS tipo_evento;


-- Tabela de Tipos de Evento
CREATE TABLE tipo_evento ( id_tipo_evento SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL, descricao TEXT ); 

-- Tabela de Estados 
CREATE TABLE estado ( sigla_estado CHAR(2) PRIMARY KEY, nome_estado VARCHAR(100) NOT NULL );

-- Tabela de Localização 
CREATE TABLE localizacao ( id_localizacao SERIAL PRIMARY KEY, latitude NUMERIC(9,6) NOT NULL, longitude NUMERIC(9,6) NOT NULL, cidade VARCHAR(100) NOT NULL, sigla_estado CHAR(2) NOT NULL REFERENCES estado(sigla_estado) );  

-- Tabela de Usuários 
CREATE TABLE usuario ( id_usuario SERIAL PRIMARY KEY, nome VARCHAR(150) NOT NULL, email VARCHAR(150) UNIQUE NOT NULL, senha_hash VARCHAR(255) NOT NULL ); 

-- Tabela de Telefones do Usuário 
CREATE TABLE telefone ( id_telefone SERIAL PRIMARY KEY, numero VARCHAR(20) NOT NULL, id_usuario INT NOT NULL REFERENCES usuario(id_usuario) );

-- Tabela de Eventos 
CREATE TABLE evento ( id_evento SERIAL PRIMARY KEY, titulo VARCHAR(150) NOT NULL, descricao TEXT, data_hora TIMESTAMP NOT NULL, status VARCHAR(30) CHECK (status IN ('Ativo','Em Monitoramento','Resolvido')), id_tipo_evento INT NOT NULL REFERENCES tipo_evento(id_tipo_evento), id_localizacao INT NOT NULL REFERENCES localizacao(id_localizacao) );

-- Tabela de Relatos 
CREATE TABLE relato ( id_relato SERIAL PRIMARY KEY, texto TEXT NOT NULL, data_hora TIMESTAMP NOT NULL, id_evento INT NOT NULL REFERENCES evento(id_evento), id_usuario INT NOT NULL REFERENCES usuario(id_usuario) );   

-- Tabela de Alertas 
CREATE TABLE alerta ( id_alerta SERIAL PRIMARY KEY, mensagem TEXT NOT NULL, data_hora TIMESTAMP NOT NULL, nivel VARCHAR(20) CHECK (nivel IN ('Baixo','Médio','Alto','Crítico')), id_evento INT NOT NULL REFERENCES evento(id_evento) ); 

-- Inserindo Tipos de Evento
INSERT INTO tipo_evento (nome, descricao) VALUES
('Incêndio', 'Incêndio florestal ou urbano'),
('Enchente', 'Acúmulo de água em áreas urbanas ou rurais'),
('Deslizamento', 'Deslizamento de terra em áreas de risco');

-- Inserindo Estados
INSERT INTO estado (sigla_estado, nome_estado) VALUES
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais');

-- Inserindo Localizações
INSERT INTO localizacao (latitude, longitude, cidade, sigla_estado) VALUES
(-23.550520, -46.633308, 'São Paulo', 'SP'),
(-22.906847, -43.172896, 'Rio de Janeiro', 'RJ'),
(-19.916681, -43.934493, 'Belo Horizonte', 'MG');

-- Inserindo Usuários
INSERT INTO usuario (nome, email, senha_hash) VALUES
('João da Silva', 'joao.silva@example.com', 'hash1'),
('Maria Oliveira', 'maria.oliveira@example.com', 'hash2'),
('Carlos Souza', 'carlos.souza@example.com', 'hash3');

-- Inserindo Telefones
INSERT INTO telefone (numero, id_usuario) VALUES
('(11) 91234-5678', 1),
('(21) 92345-6789', 2),
('(31) 93456-7890', 3);

-- Inserindo Eventos
INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Incêndio na Zona Norte', 'Grande incêndio em área residencial', '2025-08-25 14:30:00', 'Ativo', 1, 1),
('Enchente no Centro', 'Chuvas intensas causam alagamento', '2025-08-24 10:00:00', 'Em Monitoramento', 2, 2),
('Deslizamento em encosta', 'Deslizamento após chuvas', '2025-08-20 08:15:00', 'Resolvido', 3, 3);

-- Inserindo Relatos
INSERT INTO relato (texto, data_hora, id_evento, id_usuario) VALUES
('Vi fumaça saindo das casas', '2025-08-25 15:00:00', 1, 1),
('A água está subindo rapidamente', '2025-08-24 10:30:00', 2, 2),
('Ouvi um estrondo antes do deslizamento', '2025-08-20 08:30:00', 3, 3);

-- Inserindo Alertas
INSERT INTO alerta (mensagem, data_hora, nivel, id_evento) VALUES
('Evacuar imediatamente', '2025-08-25 15:10:00', 'Crítico', 1),
('Evitar trânsito na região central', '2025-08-24 11:00:00', 'Médio', 2),
('Área isolada, risco de novos deslizamentos', '2025-08-20 09:00:00', 'Alto', 3);

-- CONSULTAS SIMPLES

-- 1. Consultar todos os usuários cadastrados
SELECT id_usuario, nome, email FROM usuario;

-- 2. Consultar todos os eventos com seus títulos e status
SELECT id_evento, titulo, status FROM evento;


-- CONSULTAS FILTRADAS COM WHERE

-- 3. Buscar usuários com e-mail do domínio "example.com"
SELECT nome, email
FROM usuario
WHERE email LIKE '%@example.com';

-- 4. Buscar eventos que estão com status "Ativo"
SELECT titulo, data_hora, status
FROM evento
WHERE status = 'Ativo';

-- INSERIR 2 EVENTOS QUE DEPENDEM DE OUTRAS TABELAS VIA CHAVE ESTRANGEIRA

INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Fumaça em bairro industrial', 'Moradores relatam fumaça vinda de fábrica', '2025-08-26 08:00:00', 'Em Monitoramento', 1, 1),
('Alagamento em avenida principal', 'Chuvas fortes causam alagamento na região central', '2025-08-26 09:30:00', 'Ativo', 2, 2);


-- CONSULTA QUE ORDENA EVENTOS POR DATA E HORA (do mais antigo para o mais recente)

SELECT id_evento, titulo, data_hora
FROM evento
ORDER BY data_hora ASC;


-- CONSULTA QUE RETORNA OS 3 EVENTOS MAIS RECENTES

SELECT id_evento, titulo, data_hora
FROM evento
ORDER BY data_hora DESC
LIMIT 3;

-- Contar clientes (adaptado para o meu banco)

select count (*) id_usuario from usuario

-- Contar saldo (adaptado para o meu banco)

select SUM(latitude) from localizacao

-- Média do saque (adaptado para o meu banco)

select AVG(longitude) from localizacao

-- Group by e having (adaptado para o meu banco)

SELECT evento.titulo, SUM(relato_count) AS total_relatos
FROM (SELECT id_evento, COUNT(*) AS relato_count
FROM relato
GROUP BY id_evento) AS evento_relatos
JOIN evento ON evento.id_evento = evento_relatos.id_evento
GROUP BY evento.titulo
HAVING SUM(relato_count) > 0;
