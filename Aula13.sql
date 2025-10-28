-- E2:
-- Subconsulta: Quais IDs de aluno já pegaram um livro do autor 1?
SELECT DISTINCT
	e.id_aluno
FROM emprestimo e

JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
JOIN livro l ON el.id_livro = l.id_livro

WHERE l.id_autor = 1;

-- E3:
-- Seleciona os dados dos alunos cujo ID está na lista (1, 2)
SELECT *
FROM aluno
	WHERE id_aluno IN (
  -- Início da Subconsulta
  SELECT DISTINCT
  	e.id_aluno
  FROM emprestimo e
  
  JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
  JOIN livro l ON el.id_livro = l.id_livro
  
  WHERE l.id_autor = 1
  -- Fim da Subconsulta
);

-- E4:
SELECT *
FROM aluno a
WHERE EXISTS (
  -- Início da Subconsulta Correlacionada
  SELECT 1
  FROM emprestimo e
  
  JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
  JOIN livro l ON el.id_livro = l.id_livro
  
  	WHERE l.id_autor = 1 AND e.id_aluno = a.id_aluno
  -- Fim da Subconsulta
);

-- E5:
EXPLAIN ANALYZE
SELECT *
FROM aluno
WHERE id_aluno IN (
  	SELECT DISTINCT
	  	e.id_aluno
  	FROM emprestimo e
	  
  	JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
  	JOIN livro l ON el.id_livro = l.id_livro
	  
  	WHERE l.id_autor = 1
);

EXPLAIN ANALYZE
SELECT *
FROM aluno a
WHERE EXISTS (
  SELECT 1
  FROM emprestimo e
  JOIN emprestimoLivro el ON e.id_emprestimo = el.id_emprestimo
  JOIN livro l ON el.id_livro = l.id_livro
  WHERE l.id_autor = 1
    AND e.id_aluno = a.id_aluno
);



-- Inserts adicionais

-- Bruno pega um livro do Tolkien
INSERT INTO emprestimo (data_emprestimo, id_aluno) VALUES ('2025-08-25', 2);

INSERT INTO emprestimoLivro (id_emprestimo, id_livro) VALUES (5, 2);

-- Daniel pega um livro que NÃO é do Tolkien
INSERT INTO emprestimo (data_emprestimo, id_aluno) VALUES ('2025-08-26', 4);

INSERT INTO emprestimoLivro (id_emprestimo, id_livro) VALUES (6, 3); -- Livro 3 = Dom Casmurro



Houve uma diferença de 0.036 milissegundos para o EXISTS. Dado que foi com uma quantia de dados pequena,
não há diferença entre um exemplo e outro. Mas, o otimizador postgreSQL é tão eficiente que ambas as formas são rápidas e eficientes,
com pouca divergência entre eles.
Mas, num banco com milhares/milhões de dados, o tipo com EXISTS tende a ganhar do IN, já que um termina a procura no primeiro resultado encontrado,
enquanto o outro necessita de montar a lista antes.