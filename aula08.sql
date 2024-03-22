create DATABASE bd_aula08;
\c bd_aula08
create table tbl_fornecedor (cod_fornecedor serial primary key, nome text not null, status integer, cidade text);
create table tbl_peca (cod_peca serial primary key, nome text not null, cor text, preco numeric, cidade text);
create table tbl_estoque (cod_compra serial primary key, cod_fornecedor integer references tbl_fornecedor(cod_fornecedor),cod_peca integer references tbl_peca(cod_peca),quantidade integer);
						
insert into tbl_fornecedor(nome,status,cidade) 
values ('A',30,'LONDRES'),('B',20,'PARIS'),('C',10,'PARIS'),('D',10,'LONDRES');

INSERT INTO tbl_peca(nome, cor, preco, cidade) values
('PLACA','AZUL',5,'LONDRES'),('MESA','VERMELHA',10,'PARIS'),('CADERNO','PRETA',14,'ROMA'),
('TESOURA','VERMELHA',12,'LONDRES');

INSERT INTO tbl_estoque(cod_fornecedor, cod_peca, quantidade) values
(1,1,30),(2,1,30),(3,2,10),(3,3,50);



--1 Listar o nome e a cidade dos fornecedores com mais de 10 peças.Contar só as peças de código 1.
SELECT nome, cidade FROM tbl_fornecedor WHERE cod_fornecedor IN ( SELECT cod_fornecedor FROM tbl_estoque WHERE quantidade >10 AND cod_peca=1);

--2  Encontre o nome das peças com preço superior a 10 que estão disponíveis em estoque:
SELECT nome FROM tbl_peca WHERE cod_peca IN (SELECT cod_peca FROM tbl_estoque WHERE cod_peca IS NOT NULL AND preco > 10);

--3 Selecione o nome das peças que não estão em estoque:
SELECT p.nome FROM tbl_peca p LEFT JOIN tbl_estoque e ON p.cod_peca = e.cod_peca WHERE e.cod_peca IS NULL ;
SELECT nome FROM tbl_peca WHERE cod_peca NOT IN (SELECT cod_peca FROM tbl_estoque);

--4 Encontre o nome das peças que estão em estoque com uma quantidade maior que 20:
SELECT nome FROM tbl_peca WHERE cod_peca IN (select cod_peca FROM tbl_estoque WHERE quantidade > 20);

--5 Listar todas as pecas exceto a PLACA, ordenado por nome
SELECT * FROM tbl_peca EXCEPT SELECT * FROM tbl_peca WHERE nome ='PLACA' order by nome;

--6 Listar o nome e a cor das peças do fornecedor C, ordenado pelo nome da peça
SELECT p.nome, p.cor FROM tbl_peca p INNER JOIN tbl_estoque e ON p.cod_peca = e.cod_peca WHERE e.cod_fornecedor = (SELECT cod_fornecedor FROM tbl_fornecedor WHERE nome = 'C') ORDER BY p.nome;

--7 Listar o nome e a cor de todas as pecas de Londres
SELECT p.nome, p.cor FROM tbl_peca p WHERE cidade = 'LONDRES';
SELECT nome, cor FROM tbl_peca INTERSECT SELECT nome, cor FROM tbl_peca WHERE cidade = 'LONDRES';

--8 Encontre o nome das peças que estão disponíveis em estoque em Londres e não estão disponíveis em estoque em Paris:
SELECT DISTINCT(nome) FROM tbl_peca p INNER JOIN tbl_estoque e ON p.cod_peca = e.cod_peca WHERE p.cidade = 'LONDRES' AND NOT p.cidade = 'PARIS'; 


--9 Quais os codigos das peças que possuem maior estoque do que a peça de codigo 2?
SELECT DISTINCT(cod_peca) FROM tbl_estoque WHERE quantidade > (SELECT quantidade FROM tbl_estoque WHERE cod_peca = 2) ORDER BY cod_peca;
SELECT DISTINCT(cod_peca) FROM tbl_estoque WHERE quantidade > ALL (SELECT quantidade FROM tbl_estoque WHERE cod_peca = 2) ORDER BY cod_peca;