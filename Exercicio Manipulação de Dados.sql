show databases;

create database if not exists sistema default character set = utf8;

drop database sistema;

use sistema;

create table departamento (
id_departamento int not null,
nome varchar(100) not null,
telefone char(15),
primary key (id_departamento)
);

select * from departamento;

create table funcionario (
id_funcionario int not null,
nome varchar(100) not null,
id_departamento int not null,
data_cadastro date,
primary key (id_funcionario)
#constraint fk_id_departamento foreign key (id_funcionario) REFERENCES departamento (id_departamento)
#on delete no action
#on update no action
);

select * from departamento;

select * from funcionario;

drop table funcionario;

drop table departamento;

alter table funcionario add foreign key (id_departamento) references departamento (id_departamento);

insert into departamento values (1, 'Comercial', '2222-5555');

insert into departamento (id_departamento, nome, telefone) values (2, 'Marketing', '5555-2525');

insert into departamento values (3, 'Operacional', '5555-2469');
insert into departamento values (4, 'Financeiro', '2465-5555');
insert into departamento values (5, 'Administrativo', '5656-5555');
insert into departamento values (6, 'ToSemIdeia', '5444-5555');
insert into departamento values (7, 'Naosei', '5655-5556');

select * from departamento;

select * from departamento order by nome asc;

select * from departamento order by nome desc;

select * from departamento where telefone is null;

#insert into departamento values (8, 'Qualquer', null);

select * from departamento where telefone is not null;

select * from departamento where id_departamento = 300;

#insert into departamento values (300, 'Isso', null);
#update departamento set telefone = '1111-2222' where id_departamento = 300;

select * from departamento where nome like 'D%';

#insert into departamento values (9, 'Dinamico', null);

select * from departamento where nome like '%Vendas';

insert into departamento values (10, 'Sub-Vendas', null);

select * from departamento where nome like '%de%';

select * from departamento where nome not like '%de%';

select telefone from departamento where id_departamento = 300;

delete from departamento where id_departamento = 400;
