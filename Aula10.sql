-- Remover tabelas existentes, caso existam
DROP TABLE IF EXISTS emprestimo_livro;
DROP TABLE IF EXISTS aluno;
DROP TABLE IF EXISTS livro;
DROP TABLE IF EXISTS autor;

-- Tabela Autor
CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela Livro
CREATE TABLE livro (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    ano_publicacao INT,
    id_autor INT REFERENCES autor(id_autor)
);

-- Tabela Aluno
CREATE TABLE aluno (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso VARCHAR(100) NOT NULL
);

-- Inserir Autores
INSERT INTO autor (nome) 
VALUES 
    ('J. R. R. Tolkien'),
    ('Machado de Assis'),
    ('Clarice Lispector');

-- Inserir Livros
INSERT INTO livro (titulo, ano_publicacao, id_autor) 
VALUES 
    ('O Senhor dos Anéis', 1954, 1),
    ('Dom Casmurro', 1899, 2),
    ('A Hora da Estrela', 1977, 3),
    ('Um Livro legal', 1977, 3),
    ('Um Livro muitolegal', 1954, 1),
    ('O Hobbit', 1937, 1);

-- Inserir Alunos (agora com IDs válidos para a tabela de empréstimos)
INSERT INTO aluno (nome, curso) 
VALUES 
    ('Ana Souza', 'Literatura'),
    ('Bruno Silva', 'História');

-- Tabela de Empréstimo de Livros (associativa)
CREATE TABLE emprestimo_livro (
    id_emprestimo SERIAL PRIMARY KEY,
    id_livro INT REFERENCES livro(id_livro),
    id_aluno INT REFERENCES aluno(id_aluno)
);

-- Inserir Empréstimos de Livros
INSERT INTO emprestimo_livro (id_emprestimo, id_livro, id_aluno) 
VALUES 
    (1, 1, 1),  -- Ana Souza pegou "O Senhor dos Anéis"
    (2, 2, 1),  -- Ana Souza pegou "Dom Casmurro"
    (3, 3, 2);  -- Bruno Silva pegou "A Hora da Estrela"

--1
--Listar quantos livros cada autor possui, retorna a quantidade de livros totais.
SELECT 
    a.nome AS autor, 
    COUNT(l.id_livro) AS quantidade_de_livros
FROM 
    autor a
LEFT JOIN 
    livro l ON a.id_autor = l.id_autor
GROUP BY 
    a.id_autor;

--2Mostrar a média de páginas dos livros por editora, retorna exatamente oque diz
SELECT 
    AVG(quantidade_de_livros) AS media_de_livros_por_autor
FROM (
    SELECT 
        COUNT(l.id_livro) AS quantidade_de_livros
    FROM 
        autor a
    LEFT JOIN 
        livro l ON a.id_autor = l.id_autor
    GROUP BY 
        a.id_autor
) AS livros_por_autor;

--3 Mostra a quantidade de alunos por curso (Consulta adaptada: Listar o total de campanhas por reservatório)
--Retornaa quantidade de alunos por curso
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

--5 Mostrar aurotes com mmais de 3 livros (Consulta adaptada:Mostrar a média de valores de cada parâmetro em séries temporais)
-- Retora o total de livros com o autor
SELECT 
    a.nome AS autor,
    COUNT(l.id_livro) AS total_livros
FROM 
    autor a
LEFT JOIN 
    livro l ON a.id_autor = l.id_autor
GROUP BY 
    a.nome
HAVING 
    COUNT(l.id_livro) > 2
ORDER BY 
    total_livros DESC;
