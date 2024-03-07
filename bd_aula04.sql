-- criar bd_aula04
Create DATABASE bd_aula04;

--tabelas para o exercicios
create domain chk_categoria text check (value='DRAMA' or value='COMEDIA');
create domain chk_status text check (value='DISPONIVEL' or value='ALUGADO');
create table tbl_cliente (codigo_cliente integer PRIMARY KEY, nome text not null, cidade text, endereco text);
create table tbl_titulo (codigo_titulo integer primary key, titulo text not null, descricao text, categoria chk_categoria);
create table tbl_livros (cod_livro integer PRIMARY KEY, codigo_titulo integer REFERENCES tbl_titulo(codigo_titulo), status chk_status DEFAULT 'DISPONIVEL');
create table tbl_emprestimo (numero_emprestimo integer PRIMARY KEY, codigo_cliente integer REFERENCES tbl_cliente(codigo_cliente), codigo_livro integer REFERENCES tbl_livros(cod_livro));

-- Inserir dados na tabela tbl_cliente
INSERT INTO tbl_cliente VALUES(1,'Joao Silva', 'Sao Paulo', 'Rua A,123');
INSERT INTO tbl_cliente VALUES(2,'Maria Santos', 'Rio de Janeiro', 'Av.B,456');
INSERT INTO tbl_cliente VALUES(3,'Pedro Almeida', 'Belo Horizonte', 'Rua C,789');
INSERT INTO tbl_cliente VALUES(4,'Ana Oliveira', 'Salvador', 'Av.D,1011');
INSERT INTO tbl_cliente VALUES(5,'Carlos Lima', 'Brasilia', 'Rua E,1213');

-- Inserir dados na tabela tbl_titulo
INSERT INTO tbl_titulo VALUES(1,'Aventuras Urbanas', 'Uma historia emocionante', 'DRAMA');
INSERT INTO tbl_titulo VALUES(2,'Misterios Antigos', 'Enigmas por resolver', 'COMEDIA');
INSERT INTO tbl_titulo VALUES(3,'Amor nas Estrelas', 'Um romance intergalactico', 'DRAMA');
INSERT INTO tbl_titulo VALUES(4,'Codigo Enigmatico', 'Segredos ocultos', 'COMEDIA');
INSERT INTO tbl_titulo VALUES(5,'Historias Perdidas', 'Contos esquecidos', 'DRAMA');

-- Inserir dados na tabela tbl_livros
INSERT INTO tbl_livros VALUES(1, 1, 'DISPONIVEL');
INSERT INTO tbl_livros VALUES(2, 1, 'ALUGADO');
INSERT INTO tbl_livros VALUES(3, 2, 'DISPONIVEL');
INSERT INTO tbl_livros VALUES(4, 3, 'ALUGADO');
INSERT INTO tbl_livros VALUES(5, 4, 'DISPONIVEL');

-- Inserir dados na tabela tbl_emprestimo
INSERT INTO tbl_emprestimo VALUES(1,1,2);
INSERT INTO tbl_emprestimo VALUES(2,2,4);
INSERT INTO tbl_emprestimo VALUES(3,3,1);
INSERT INTO tbl_emprestimo VALUES(4,4,5);
INSERT INTO tbl_emprestimo VALUES(5,5,3);

--selecionar todos os clientes
SELECT * FROM tbl_cliente;

--Selecionar os clientes que moram em São Paulo
SELECT * FROM tbl_cliente WHERE cidade = 'Sao Paulo';

--Selecionar os clientes onde o código é maior que 3
SELECT * FROM tbl_cliente WHERE codigo_cliente > 3;

--Selecionar todos os títulos
SELECT * FROM tbl_titulo;

--crie uma tabela chamada tbl_cliente2 com uma coluna integer chamada código
Create TABLE tbl_cliente2(codigo INTEGER);

--Copie todos dos códigos da tbl_cliente para essa nova tabela usando o SQL Insert.
INSERT INTO tbl_cliente2 SELECT codigo_cliente FROM tbl_cliente;

--Atualize todos os livros alugados para disponivel
UPDATE tbl_livros SET status = 'DISPONIVEL' WHERE status = 'ALUGADO';

--Delete todos as linhas da tabela tbl_cliente2 onde o código for maior que 3

DELETE FROM tbl_cliente2 WHERE codigo > 3;

