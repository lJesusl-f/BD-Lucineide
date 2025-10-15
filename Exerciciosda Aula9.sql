--
-- COMANDOS PARA LIMPEZA (DROP TABLES)
--
-- Remove emprestimo primeiro por causa da dependência do livro
DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS livro;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS autor;

---
--
-- DEFINIÇÃO DAS TABELAS (DDL) COM id_livro CORRIGIDO
--
CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT,
    id_autor INT REFERENCES autor(id_autor)
);

CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso VARCHAR(100) NOT NULL
);

-- Tabela Empréstimo CORRIGIDA com a coluna id_livro
CREATE TABLE emprestimo (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    id_aluno INT REFERENCES aluno(id_aluno) NOT NULL,
    id_livro INT REFERENCES livro(id_livro) NOT NULL -- <<-- Esta coluna é NOT NULL
);

---
--
-- INSERÇÃO DE DADOS (DML)
--

-- 1. Autores
INSERT INTO autor (nome) VALUES 
('J. R. R. Tolkien'), 
('Machado de Assis'), 
('Clarice Lispector');

-- 2. Livros (id_livro: 1, 2, 3, 4)
INSERT INTO livro (titulo, ano_publicacao, id_autor) VALUES 
('O Senhor dos Anéis', 1954, 1), 
('Dom Casmurro', 1899, 2), 
('A Hora da Estrela', 1977, 3), 
('O Hobbit', 1937, 1);

-- 3. Alunos
INSERT INTO aluno (nome, curso) VALUES 
('Ana Souza', 'Sistemas de Informação'), -- id_aluno = 1
('Bruno Silva', 'Engenharia de Software');-- id_aluno = 2

-- 4. Empréstimos (INSERÇÃO CORRIGIDA, fornecendo id_livro)
INSERT INTO emprestimo (data_emprestimo, id_aluno, id_livro) VALUES 
('2025-08-20', 1, 2), -- Ana Souza (1) emprestou Dom Casmurro (2)
('2025-08-21', 2, 1); -- Bruno Silva (2) emprestou O Senhor dos Anéis (1)

--Escreva uma query que retorne titulo do evento e nome do tipo_evento (INNER JOIN). (Adaptada para a tabela que a senhora disponibilizou no PDF)
--Escreva uma query que retorne titulo do livro e nome do autor (INNER JOIN).
SELECT
    l.titulo AS "Título do Livro",
    a.nome AS "Nome do Autor"
FROM
    livro l
INNER JOIN
    autor a ON l.id_autor = a.id_autor;

-- Escreva uma query que retorne titulo do livro, autor e emprestimo (INNER JOIN) (Adaptada para o banco que a senhora disponibilizou no PDF)
-- Escreva uma query que retorne titulo do evento, cidade e sigla_estado
SELECT
    l.titulo AS "Título do Livro",
    a.nome AS "Nome do Autor",
    e.data_emprestimo AS "Data do Empréstimo"
FROM
    livro l
INNER JOIN
    autor a ON l.id_autor = a.id_autor
INNER JOIN
    emprestimo e ON l.id_livro = e.id_livro;

-- : Reescreva a Consulta B usando RIGHT JOIN (invertendo a ordem das tabelas) e verifique que o resultado é equivalente. Anote as diferenças de leitura/legibilidade.

SELECT
    l.titulo AS "Título do Livro",
    a.nome AS "Nome do Autor",
    e.data_emprestimo AS "Data do Empréstimo"
FROM
    emprestimo e                                   -- 1. Começa pela última tabela da junção INNER
RIGHT JOIN
    livro l ON e.id_livro = l.id_livro             -- 2. RIGHT JOIN Livro (equivalente a Livro JOIN Emprestimo)
RIGHT JOIN
    autor a ON l.id_autor = a.id_autor;            -- 3. RIGHT JOIN Autor (equivalente a Livro JOIN Autor)

-- Embora o RIGHT JOIN invertido produza o mesmo resultado que o INNER JOIN neste caso (porque o INNER JOIN garante que todos os lados têm correspondência), o uso do INNER JOIN é preferido por ser mais idiomático e claro para consultas onde a correspondência de dados é obrigatória em todas as tabelas.

-- Crie uma query que mostre cada livro de cada autor (Adaptada para o banco que a senhora disponibilizou no PDF)
--Crie uma query que mostre para cada cidade a quantidade de eventos (usar JOIN + GROUP BY)

SELECT
    a.nome AS "Nome do Autor",
    COUNT(l.id_livro) AS "Quantidade de Livros"
FROM
    autor a
LEFT JOIN
    livro l ON a.id_autor = l.id_autor
GROUP BY
    a.nome
ORDER BY
    "Quantidade de Livros" DESC, a.nome;