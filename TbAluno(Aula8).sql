DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS alunos;
DROP TABLE IF EXISTS cursos;


-- Tabelas
CREATE TABLE cursos (
  id_curso SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
);

CREATE TABLE alunos (
  id_aluno SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  idade INT,
  id_curso INT REFERENCES cursos(id_curso)
);

CREATE TABLE notas (
  id_nota SERIAL PRIMARY KEY,
  disciplina VARCHAR(100) NOT NULL,
  nota FLOAT,
  id_aluno INT REFERENCES alunos(id_aluno)
);

-- Inserções
INSERT INTO cursos (nome) VALUES ('Engenharia');
INSERT INTO cursos (nome) VALUES ('Análise de Sistemas'), ('Computação'), ('Matemática');

INSERT INTO alunos (nome, idade, id_curso) VALUES
  ('João Silva', 22, 1),
  ('Marina Lima', 16, 3),
  ('Maria Souza', 20, 3),
  ('Carlos Lima', 25, 4),
  ('Roberto Carlos', NULL, NULL),
  ('Lucas Pereira', 18, 3);

INSERT INTO notas (id_nota, id_aluno, disciplina, nota) VALUES
  (101, 1, 'Matemática', 8.5),
  (102, 2, 'História', 9.0);

UPDATE alunos SET idade = 16 WHERE nome = 'João Silva';


UPDATE alunos SET idade = 17, id_curso = 1 WHERE nome = 'Marina Lima';

--INNER JOIN
SELECT alunos.nome, cursos.nome
FROM alunos
INNER JOIN cursos ON alunos.id_aluno = cursos.id_curso

--LEFT JOIN
SELECT alunos.nome, cursos.nome
FROM alunos
LEFT JOIN cursos ON alunos.id_aluno = cursos.id_curso
