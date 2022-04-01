CREATE DATABASE clinica2;

use clinica2;

CREATE TABLE ambulatorios (
id_ambulatorio int not null,
andar decimal(3) not null,
capacidade smallint,
PRIMARY KEY(id_ambulatorio)
);

select * from ambulatorios;

use clinica2;

CREATE TABLE medicos (
id_medico int not null,
nome_medico varchar(80) not null,
idade_medico smallint not null,
especialidade_medico char(20) null,
cpf_medico decimal(11) unique not null,
cidade_medico varchar(40) null,
id_ambulatorio int not null,
PRIMARY KEY (id_medico),
constraint fk_id_medico foreign key (id_ambulatorio) REFERENCES ambulatorio (id_ambulatorio)
on delete no action
on update no action
);

CREATE TABLE pacientes (
id_paciente int not null,
nome_paciente varchar(80) not null,
idade_paciente smallint not null,
cidade_paciente varchar(40) null,
cpf_paciente decimal(11) unique not null,
diagnostico_paciente varchar(40) not null,
primary key (id_paciente),
unique index idx_cpf(cpf_paciente asc) visible
);

create table funcionario(
id_funcionario int not null,
nome_funcionario varchar(80) not null,
idade_funcionario smallint not null,
cpf_funcionario decimal(11) not null,
cidade_funcionario varchar(40) null,
salario_funcionario decimal(10) not null,
cargo_funcionario varchar(40) not null,
id_ambulatorio int not null,
unique index idx_cpf1(cpf_funcionario asc) visible,
constraint fk_id_funcionario foreign key(id_ambulatorio) references ambulatorios(id_ambulatorio)
on delete no action
on update no action
);

create table consultas(
id_consulta int not null,
id_ambulatorio int not null,
id_paciente int not null,
data_consulta date null,
hora_consulta time null,
primary key (id_consulta),
index fk_id_ambulatorio_id (id_ambulatorio asc) visible,
index fk_id_paciente_idx (id_paciente asc) visible,
constraint fk_id_ambulatorio2 foreign key (id_ambulatorio) references ambulatorios (id_ambulatorio)
on delete no action
on update no action,
constraint fk_id_paciente foreign key (id_paciente) references pacientes (id_paciente)
on delete no action
on update no action
);