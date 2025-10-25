-- Dropar tabelas no banco biblioteca
DROP TABLE IF EXISTS emprestimo_livro CASCADE;
DROP TABLE IF EXISTS emprestimo CASCADE;
DROP TABLE IF EXISTS livro CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS autor CASCADE;;

-- ====================================
-- Tabela Autor
-- ====================================
CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- ====================================
-- Tabela Livro
-- ====================================
CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT,
    id_autor INT REFERENCES autor(id_autor)
);

-- ====================================
-- Tabela Aluno
-- ====================================
CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso VARCHAR(100) NOT NULL
);

-- ====================================
-- Tabela Empréstimo
-- ====================================
CREATE TABLE emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    id_aluno INT REFERENCES aluno(id_aluno)
);

-- ====================================
-- Tabela Emprestimo_Livro (associativa)
-- ====================================
CREATE TABLE emprestimo_livro (
    id_emprestimo INT REFERENCES emprestimo(id_emprestimo),
    id_livro INT REFERENCES livro(id_livro),
    PRIMARY KEY (id_emprestimo, id_livro)
);

-- ====================================
-- Inserir Autores
-- ====================================
INSERT INTO autor (nome) VALUES 
    ('J. R. R. Tolkien'),
    ('Machado de Assis'),
    ('Clarice Lispector');

-- ====================================
-- Inserir Livros
-- ====================================
INSERT INTO livro (titulo, ano_publicacao, id_autor) VALUES 
    ('O Senhor dos Anéis', 1954, 1),
    ('Dom Casmurro', 1899, 2),
    ('A Hora da Estrela', 1977, 3),
    ('O Hobbit', 1937, 1);

-- ====================================
-- Inserir Alunos
-- ====================================
INSERT INTO aluno (nome, curso) VALUES 
    ('Ana Souza', 'Sistemas de Informação'),
    ('Bruno Silva', 'Engenharia de Software');

-- ====================================
-- Inserir Empréstimos
-- ====================================
INSERT INTO emprestimo (data_emprestimo, id_aluno) VALUES 
    ('2025-08-20', 1),
    ('2025-08-21', 2);

-- ====================================
-- Inserir Empréstimos de Livros (associativa)
-- ====================================
INSERT INTO emprestimo_livro (id_emprestimo, id_livro) VALUES 
    (1, 1),  -- Ana Souza pegou O Senhor dos Anéis
    (1, 2),  -- Ana Souza pegou Dom Casmurro
    (2, 3);  -- Bruno Silva pegou A Hora da Estrela

--1 Mostrar livros de cada autor 
-- Retorna cada livro de cada autor
SELECT l.titulo, l.ano_publicacao, a.nome AS autor
FROM livro l
JOIN autor a ON l.id_autor = a.id_autor;

--2
--Retorna a media de paginas por livro
ALTER TABLE livro
ADD COLUMN num_paginas INT;
UPDATE livro SET num_paginas = 1200 WHERE id_livro = 1; -- O Senhor dos Anéis
UPDATE livro SET num_paginas = 300 WHERE id_livro = 2;  -- Dom Casmurro
UPDATE livro SET num_paginas = 150 WHERE id_livro = 3;  -- A Hora da Estrela
UPDATE livro SET num_paginas = 400 WHERE id_livro = 4;  -- O Hobbit
SELECT 
    a.nome AS autor,
    AVG(l.num_paginas) AS media_paginas
FROM autor a
JOIN livro l ON a.id_autor = l.id_autor
GROUP BY a.nome;

-- 3 Mostra a quantidade de alunos por curso (Consulta adaptada: Listar o total de campanhas por reservatório)
-- Retorna quantidade de alunos por curso
SELECT 
    curso, 
    COUNT(id_aluno) AS total_de_alunos
FROM 
    aluno
GROUP BY 
    curso;

--4 Média de livros por ano (Consulta adaptada: Mostrar a média de valores de cada parâmetro em séries temporais)
-- Retorna a media dos livros por ano
SELECT 
    a.nome AS autor,
    ROUND(COUNT(l.id_livro)::NUMERIC / COUNT(DISTINCT l.ano_publicacao), 2) AS media_livros_por_ano
FROM 
    autor a
LEFT JOIN 
    livro l ON a.id_autor = l.id_autor
WHERE 
    l.ano_publicacao IS NOT NULL
GROUP BY 
    a.nome
ORDER BY 
    a.nome;

-- 5 Listar autores com mais de um livro (Consulta adaptada:Mostrar a média de valores de parâmetros por reservatório)
--Retorna autores com mais de um livro
SELECT 
    a.nome AS autor,
    COUNT(l.id_livro) AS total_livros
FROM autor a
JOIN livro l ON a.id_autor = l.id_autor
GROUP BY a.nome
HAVING COUNT(l.id_livro) > 1;
