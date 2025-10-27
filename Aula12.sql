INSERT INTO autor (nome)
VALUES
('J. R. R. Tolkien'),
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell'),
('Cecília Meireles'),
('Gabriel García Márquez'),
('Franz Kafka');
 
INSERT INTO livro (titulo, num_pgs, ano_publicacao, id_autor)
VALUES
('O Senhor dos Anéis', 154, 1954, 1),
('Dom Casmurro', 523, 1899, 2),
('A Hora da Estrela', 703, 1977, 3),
('O Hobbit', 319, 1937, 1),
('1984', 328, 1949, 4),
('Romanceiro da Inconfidência', 210, 1953, 5),
('Cem Anos de Solidão', 417, 1967, 6),
('A Metamorfose', 122, 1915, 7),
('Ensaio sobre a Cegueira', 309, 1995, 3); -- Clarice Lispector como placeholder
 
INSERT INTO aluno (nome, curso)
VALUES
('Ana Souza', 'Sistemas de Informação'),
('Bruno Silva', 'Engenharia de Software'),
('Carlos Mendes', 'Biblioteconomia'),
('Fernanda Lima', 'Letras'),
('João Pedro', 'História'),
('Mariana Costa', 'Arquivologia');

 
INSERT INTO emprestimo (data_emprestimo, id_aluno)
VALUES
('2025-08-20', 1),
('2025-08-21', 2),
('2025-08-22', 3), -- Carlos Mendes
('2025-08-23', 4), -- Fernanda Lima
('2025-08-24', 5), -- João Pedro
('2025-08-25', 6); -- Mariana Costa

INSERT INTO emprestimoLivro (id_emprestimo, id_livro)
VALUES
(1, 1),  -- Ana Souza pegou O Senhor dos Anéis
(1, 2),  -- Ana Souza pegou Dom Casmurro
(2, 3),  -- Bruno Silva pegou A Hora da Estrela
(3, 5),  -- Carlos pegou 1984
(3, 6),  -- Carlos pegou Romanceiro da Inconfidência
(4, 7),  -- Fernanda pegou Cem Anos de Solidão
(5, 8),  -- João Pedro pegou A Metamorfose
(6, 9);  -- Mariana pegou Ensaio sobre a Cegueira

-- Passo 2 (nomes dos alunos)

SELECT
	nome
FROM aluno;

-- Passo 3 (calcular média de páginas dos livros emprestados)

SELECT
	a.nome,
	(SELECT AVG(l.num_pgs)
	 FROM emprestimo e
	 	JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
		JOIN livro l ON el.id_livro = l.id_livro
	WHERE e.id_aluno = a.id_aluno) AS media_paginas
FROM aluno a;

-- Passo 4 (subconsultas de minímo e máximo)

SELECT
 	a.nome,
	(
		SELECT AVG(l.num_pgs)
		FROM emprestimo e
		JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
		JOIN livro l ON el.id_livro = l.id_livro
		WHERE e.id_aluno = a.id_aluno) AS media_paginas,
	(
		SELECT MIN(l.num_pgs)
		FROM emprestimo e
		JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
		JOIN livro l ON el.id_livro = l.id_livro
		WHERE e.id_aluno = a.id_aluno) AS menor_paginas,
	(
		SELECT MAX(l.num_pgs)
		FROM emprestimo e
		JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
		JOIN livro l ON el.id_livro = l.id_livro
		WHERE e.id_aluno = a.id_aluno) AS maior_paginas
FROM aluno a;

INSERT INTO autor (nome)
VALUES
('J. R. R. Tolkien'),
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell'),
('Cecília Meireles'),
('Gabriel García Márquez'),
('Franz Kafka');
 
INSERT INTO livro (titulo, num_pgs, ano_publicacao, id_autor)
VALUES
('O Senhor dos Anéis', 154, 1954, 1),
('Dom Casmurro', 523, 1899, 2),
('A Hora da Estrela', 703, 1977, 3),
('O Hobbit', 319, 1937, 1),

('1984', 328, 1949, 4),
('Romanceiro da Inconfidência', 210, 1953, 5),
('Cem Anos de Solidão', 417, 1967, 6),
('A Metamorfose', 122, 1915, 7),
('Ensaio sobre a Cegueira', 309, 1995, 3); -- Clarice Lispector como placeholder
 
INSERT INTO aluno (nome, curso)
VALUES
('Ana Souza', 'Sistemas de Informação'),
('Bruno Silva', 'Engenharia de Software'),
('Carlos Mendes', 'Biblioteconomia'),
('Fernanda Lima', 'Letras'),
('João Pedro', 'História'),
('Mariana Costa', 'Arquivologia');

 
INSERT INTO emprestimo (data_emprestimo, id_aluno)
VALUES
('2025-08-20', 1),
('2025-08-21', 2),
('2025-08-22', 3), -- Carlos Mendes
('2025-08-23', 4), -- Fernanda Lima
('2025-08-24', 5), -- João Pedro
('2025-08-25', 6); -- Mariana Costa

INSERT INTO emprestimoLivro (id_emprestimo, id_livro)
VALUES
(1, 1),  -- Ana Souza pegou O Senhor dos Anéis
(1, 2),  -- Ana Souza pegou Dom Casmurro
(2, 3),  -- Bruno Silva pegou A Hora da Estrela
(3, 5),  -- Carlos pegou 1984
(3, 6),  -- Carlos pegou Romanceiro da Inconfidência
(4, 7),  -- Fernanda pegou Cem Anos de Solidão
(5, 8),  -- João Pedro pegou A Metamorfose
(6, 9);  -- Mariana pegou Ensaio sobre a Cegueira