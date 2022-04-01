#1 - Criar DB chamada clinica
create database clinica;

use clinica;
#2 - Criar as seguintes tabelas (Ambulatorio, Medicos, Pacientes, Funcionarios, Consultas)

create table ambulatorios(
nroa int,
andar numeric(3) not null,
capacidade smallint,
primary key (nroa)
);

create table medicos(
codm int,
nome varchar(40) not null,
idade smallint not null,
especialidade char(20),
cpf numeric(11) unique,
cidade varchar(30),
nroa int,
primary key (codm),
constraint fk_nroa_ambulatorio foreign key (nroa) references ambulatorios (nroa)
on delete no action
on update no action
);

create table pacientes(
codp int,
nome varchar(40) not null,
idade smallint not null,
cidade varchar(30),
cpf numeric(11) unique,
doenca varchar(40) not null,
primary key (codp)
);

create table funcionarios(
codf int,
nome varchar(40) not null,
idade smallint,
cidade varchar(30),
salario numeric(10),
cpf numeric(11) unique,
cargo varchar(20),
primary key (codf)
);

create table consultas(
codm int,
codp int,
datas date,
hora time,
constraint fk_codm_medicos foreign key (codm) references medicos (codm)
on delete no action
on update no action,
constraint fk_codp_pacientes foreign key (codp) references pacientes (codp)
on delete no action
on update no action
);

#3 - Criar a coluna nroa na tabela Funcionario
alter table funcionarios add column nroa int;

#4 - Criar os indices em Medicos: CPF (unique) e em Pacientes: doença
alter table medicos add unique index idx_cpf (cpf asc) visible;
alter table pacientes add index idx_doenca (doenca asc) visible;

#5 - Remover o indice doença de Paciente
alter table pacientes drop index idx_doenca;

#6 - Remover as colunas cargo e nroa da tabela Funcionario
alter table funcionarios drop column cargo;
alter table funcionarios drop column nroa;

#Populando as tabelas

insert into ambulatorios values (1, 1, 30);
insert into ambulatorios values (2, 1, 50);
insert into ambulatorios values (3, 2, 40);
insert into ambulatorios values (4, 2, 25);
insert into ambulatorios values (5, 2, 55);

insert into medicos values (1, 'João', 40, 'Ortopedia', 10000100000, 'Florianopolis', 1);
insert into medicos values (2, 'Maria', 42, 'Traumatologia', 10000110000, 'Blumenau', 2);
insert into medicos values (3, 'Pedro', 51, 'Pediatra', 11000100000, 'São José', 2);
insert into medicos values (4, 'Carlos', 28, 'Ortopedia', 11000110000, 'Joinville', null);
insert into medicos values (5, 'Marcia', 33, 'Neurologia', 11000111000, 'Biguacu', 3);

insert into pacientes values (1, 'Ana', 20, 'Florianopolis', 20000200000, 'Gripe');
insert into pacientes values (2, 'Paulo', 24, 'Palhoca', 20000220000, 'Fratura');
insert into pacientes values (3, 'Lucia', 30, 'Biguacu', 22000200000, 'Tendinite');
insert into pacientes values (4, 'Carlos', 28, 'Joinville', 11000110000, 'Sarampo');

insert into funcionarios values (1, 'Rita', 32, 'São José', 1200, 20000100000);
insert into funcionarios values (2, 'Maria', 55, 'Palhoca', 1220, 30000110000);
insert into funcionarios values (3, 'Caio', 45, 'Florianopolis', 1100, 41000100000);
insert into funcionarios values (4, 'Carlos', 44, 'Florianopolis', 1200, 51000110000);
insert into funcionarios values (5, 'Paula', 33, 'Florianopolis', 2500, 61000111000);

insert into consultas values (1, 1, '2006-06-12', '14:00');
insert into consultas values (1, 4, '2006-06-13', '10:00');
insert into consultas values (2, 1, '2006-06-13', '9:00');
insert into consultas values (2, 2, '2006-06-13', '11:00');
insert into consultas values (2, 3, '2006-06-14', '14:00');
insert into consultas values (2, 4, '2006-06-14', '17:00');
insert into consultas values (3, 1, '2006-06-19', '18:00');
insert into consultas values (3, 3, '2006-06-12', '10:00');
insert into consultas values (3, 4, '2006-06-19', '13:00');
insert into consultas values (4, 4, '2006-06-20', '13:00');
insert into consultas values (4, 4, '2006-06-22', '19:30');

#Exercicios de alteração de tabelas

#1 O paciente Paulo mudou-se para Ilhota
update pacientes set cidade = 'Ilhota' where codp = 2;

#2 A consulta do médico 1 com o paciente 4  passou para às 12:00 horas do dia 4 de Julho de 2006
update consultas set hora = '12:00', datas = '2006-07-04' where codm = 1 and codp = 4;

#3 A paciente Ana fez aniversário e sua doença agora é cancer
update pacientes set idade = 21, doenca = 'Cancer' where codp = 1;

#4 A consulta do médico Pedro (codf = 3) com o paciente Carlos (codf = 4) passou para uma hora e meia depois
update consultas set hora = '13:30' where codm = 3 and codp = 4;

#5 O funcionário Carlos (codf = 4) deixou a clínica
delete from funcionarios where codf = 4;

#6 As consultas marcadas após as 19 horas foram canceladas
delete from consultas where hora>'19:00';

#7 Os pacientes com câncer ou idade inferior a 10 anos deixaram a clínica
delete from pacientes where idade<10 or doenca = 'Cancer';

#8 Os médicos que residem em Biguacu e Palhoca deixaram a clínica
delete from medicos where cidade = 'Biguacu' or cidade = 'Palhoca';

#Exercicios de consultas em tabelas

#1 - Buscar  o  nome  e  o  CPF  dos  médicos  com  menos  de  40  anos  ou  com  especialidade diferente de traumatologia 
select nome, cpf from medicos where idade<40 or especialidade not like 'Traumatologia';

#2 - Buscar  todos  os  dados  das  consultas  marcadas  no  período  da  tarde  após  o  dia 19/06/2006
select * from consultas where datas>'2006-06-19' and hora between '13:00' and '19:00';

#3 - Buscar o nome e a idade dos pacientes que não residem em Florianópolis
select nome, idade from pacientes where cidade not like 'Florianopolis';

#4 - Buscar  a  hora  das  consultas  marcadas  antes  do  dia  14/06/2006  e  depois  do  dia 20/06/2006
select hora from consultas where datas not between '2006-06-14' and '2006-06-20';

#5 - Buscar o nome e a idade (em meses) dos pacientes
select nome, sum(idade*12) as 'idades em meses' from pacientes group by nome;

#6 - Em quais cidades residem os funcionários?
select cidade from funcionarios group by cidade;

#7 - Qual o menor e o maior salário dos funcionários da Florianópolis?
select max(salario), min(salario) from funcionarios where cidade = 'Florianopolis';

#10 - Qual o horário da última consulta marcada para o dia 13/06/2006?
select max(hora) from consultas where datas = '2006-06-13';

#11 - Qual a média de idade dos médicos e o total de ambulatórios atendidos por eles?
select avg(idade), sum(nroa) as 'total de ambulatorios atendidos' from medicos;

#12 - Buscar o código, o nome e o salário líquido dos funcionários. O salário líquido é obtido pela diferença entre o salário cadastrado menos 20% deste mesmo salário
select codf, nome, sum(salario-(salario*0.20)) as 'salario liquido' from funcionarios group by nome;

#13 - Buscar o nome dos funcionários que terminam com a letra “a”
select nome from funcionarios where nome like '%a';

#14 - Buscar  o  nome  e  CPF  dos  funcionários  que  não  possuam  a  seqüência  “00000”  em seus CPFs
select nome, cpf from funcionarios where cpf not like '%00000';

#15 - Buscar  o  nome  e  a  especialidade  dos  médicos  cuja  segunda  e  a  última  letra  de  seus nomes seja a letra “o”
select nome, especialidade from medicos where nome like '_o%' and nome like '%o';

#16 - Buscar  os  códigos  e  nomes  dos  pacientes  com  mais  de  25  anos  que  estão  com tendinite, fratura, gripe e sarampo
select codp, nome from pacientes where idade>25 and doenca in ('Tendinite', 'Fratura', 'Gripe', 'Sarampo');

#1 - nome e CPF dos médicos que também são pacientes do hospital
select m.nome, m.cpf from medicos m, pacientes p where m.nome = p.nome; 

#2 - pares (código, nome) de funcionários e de médicos que residem na mesma cidade
select m.nome as 'nome médicos', m.codm as 'código dos médicos', f.nome as 'nome funcionarios', f.codf as 'codigos funcionarios' from medicos m, funcionarios f where m.cidade = f.cidade;

#3 - código e nome dos pacientes com consulta marcada para horários após às 14 horas
select p.nome, p.codp from pacientes p, consultas c where p.codp = c.codp and hora>'14:00';

#4 - número e andar dos ambulatórios utilizados por médicos ortopedistas
select a.nroa, a.andar from ambulatorios a, medicos m where m.especialidade = 'Ortopedia';

#5 - nome e CPF dos pacientes que têm consultas marcadas entre os dias 14 e 16 de junho de 2006
select p.nome, p.cpf from pacientes p, consultas c where c.datas between '2006-06-14' and '2006-06-16' group by p.nome;

#6 - nome e idade dos médicos que têm consulta com a paciente Ana
select m.nome, m.idade from medicos m, consultas c where c.codp = '1' and c.codm = m.codm order by m.nome;









