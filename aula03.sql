-- criar banco de dados bd_aula03

Create DATABASE bd_aula03;

-- criar tabelas do MER 

Create TABLE tbl_cliente(codigo_cliente INTEGER PRIMARY KEY, Nome char NOT NULL,Cidade char,Endereco char);
Create TABLE tbl_titulo(codigo_titulo INTEGER PRIMARY KEY, Titulo char NOT NULL,descricao char,categoria char);
Create TABLE tbl_emprestimo(numero_emprestimo INTEGER PRIMARY KEY, codigo_cliente INTEGER ,codigo_livro INTEGER);
Create TABLE tbl_livros(cod_livro INTEGER PRIMARY KEY, status char,codigo_titulo INTEGER);

-- criar domains

Create DOMAIN chk_categoria text check (value in('DRAMA','COMEDIA'));
Create DOMAIN chk_status text check (value in('DISPONIVEL','ALUGADO'));

-- adicionar domain a tabela

ALTER TABLE tbl_livros alter status type chk_STATUS;
ALTER TABLE tbl_livros ALTER COLUMN status SET DEFAULT 'DISPONIVEL';
ALTER TABLE tbl_titulo alter categoria type chk_categoria;

-- adicionar chaves estrangeiras

ALTER TABLE tbl_emprestimo ADD CONSTRAINT fk_codigo_cliente FOREIGN KEY(codigo_cliente) REFERENCES tbl_cliente(codigo_cliente);
ALTER TABLE tbl_livros ADD CONSTRAINT fk_codigo_titulo FOREIGN KEY(codigo_titulo) REFERENCES tbl_titulo(codigo_titulo);
ALTER TABLE tbl_emprestimo ADD CONSTRAINT fk_codigo_livro FOREIGN KEY(codigo_livro) REFERENCES tbl_livros(cod_livro);