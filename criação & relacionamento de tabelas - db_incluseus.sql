/* Esse banco de dados esta sendo dividido em 4 partes:
1º Criação de tabelas;
2º Relacionamentos;
3º Inserção de dados;
4º Consultas. 
Os nomes das entidades, atributos e relacionamentos seguiram o padrão  do Dicionario de dados */

create database db_incluseUs;

Use db_incluseUs;

#Criação de tabelas

create table tbl_usuario (
	ID_usuario smallint auto_increment,
    nome varchar(70) not null,
    data_nasc date not null,
    cpf char(14) unique not null,
    genero enum('mulher','homem','outros', 'não especificar') not null,
    ID_login_usuario smallint,
    ID_end_usuario smallint,
   constraint PK_ID_usuario primary key (ID_usuario)
);

create table tbl_tel_usuario( 
	ID_tel_usuario smallint auto_increment,
    ID_usuario smallint,
    telefone varchar(11) not null,
   constraint PK_ID_tel_usuario primary key (ID_tel_usuario, ID_usuario)
);


create table tbl_adv(
	ID_adv smallint auto_increment,
    genero enum('mulher','homem', 'outros', 'não especificar') not null,
    nome varchar(70) not null,
    data_nasc date not null,
    sobre text,
    cpf varchar(14) not null unique,
    OAB char(8),
    ID_end_adv smallint,
    ID_login_adv smallint,
   constraint PK_ID_adv primary key (ID_adv)
);

create table tbl_tel_adv(
	ID_tel_adv smallint auto_increment,
    ID_adv smallint,
    telefone varchar(11) not null,
   constraint PK_ID_tel_adv primary key (ID_tel_adv, ID_adv)
);

create table tbl_caso (
	ID_caso smallint auto_increment,
    titulo_caso varchar(50) not null,
    descricao_caso text not null,
    data_caso date not null,
    situacao boolean not null,
    nota smallint not null,
    ID_categ_direito smallint,
	ID_usuario smallint,
	ID_end_caso smallint,
   constraint PK_ID_caso primary key (ID_caso)
);


create table tbl_end_usuario(
	ID_end_usuario smallint auto_increment,
    rua varchar(50) not null,
    numero varchar(5) not null,
    complemento varchar(20),
    ID_cidade smallint,
	ID_estado smallint,
   constraint PK_ID_end_usuario primary key (ID_end_usuario)
);

create table tbl_end_caso (
	ID_end_caso smallint  auto_increment,
    rua varchar(50) not null,
    numero varchar(5) not null,
    complemento varchar(20),
    ID_cidade smallint,
	ID_estado smallint,
   constraint PK_ID_end_caso primary key (ID_end_caso)
);

create table tbl_end_adv (
	ID_end_adv smallint  auto_increment,
    rua varchar(50) not null,
    numero varchar(5) not null,
    complemento varchar(20),
    ID_cidade smallint,
	ID_estado smallint,
   constraint PK_ID_end_adv primary key (ID_end_adv)
);

create table tbl_categ_direito (
	ID_categ_direito smallint auto_increment,
    nome varchar(50) not null,
    descrição text not null,
   constraint PK_ID_categ_direito primary key (ID_categ_direito)
);



create table tbl_avaliacao_adv(
	ID_avaliacao smallint auto_increment,
    nota  int(1) not null,
    comentario text,
    ID_caso smallint,
    ID_adv smallint,
    ID_usuario smallint,
   constraint PK_ID_avaliacao primary key (ID_avaliacao)
);

create table tbl_match_judicial (
	ID_caso smallint,
    ID_adv smallint,
    ID_usuario smallint,
    data_match datetime,
   constraint PK_match_judicial primary key (ID_caso, ID_adv, ID_usuario)
);

create table tbl_match_aconselhamento (
	ID_caso smallint,
    ID_adv smallint,
    ID_usuario smallint,
    data_match datetime,
   constraint PK_match_aconselhamento primary key (ID_caso, ID_adv, ID_usuario)
);

create table tbl_login_usuario (
	ID_login_usuario smallint auto_increment,
    email varchar(70) unique not null,
    senha varchar(32) not null,
   constraint PK_ID_login_usuario primary key (ID_login_usuario)
);

create table tbl_login_adv (
	ID_login_adv smallint auto_increment,
    email varchar(70) unique not null,
    senha varchar(32) not null,
   constraint PK_ID_login_usuario primary key (ID_login_adv)
);

create table tbl_cidade(
	ID_cidade smallint auto_increment,
    nome varchar(50) not null,
	uf varchar(6),
    ID_estado smallint,
   constraint PK_ID_cidade primary key (ID_cidade)
);

create table tbl_estado(
	ID_estado smallint auto_increment,
    uf varchar(4) not null,
   constraint PK_ID_estado primary key (ID_estado)
);

#Relacionar tabelas 

alter table tbl_cidade add 
constraint FK_ID_estado foreign key (ID_estado)
references tbl_estado (ID_estado) on delete cascade on update cascade;
    
alter table tbl_usuario add
constraint FK_ID_login_usuario foreign key (ID_login_usuario)
references tbl_login_usuario (ID_login_usuario) on delete cascade on update cascade;

alter table tbl_usuario add
constraint FK_ID_end_usuario foreign key (ID_end_usuario)
references tbl_end_usuario  (ID_end_usuario) on delete cascade on update cascade;

alter table tbl_end_usuario add
constraint FK_ID_cidade_usuario foreign key (ID_cidade)
references tbl_cidade (ID_cidade) on delete cascade on update cascade;

alter table tbl_end_usuario add
constraint FK_ID_estado_usuario foreign key (ID_estado)
references tbl_estado (ID_estado) on delete cascade on update cascade;

alter table tbl_tel_usuario add
constraint FK_ID_usuario foreign key (ID_usuario)
references tbl_usuario (ID_usuario) on delete cascade on update cascade;


alter table tbl_adv add
constraint FK_ID_login_adv foreign key (ID_login_adv)
references tbl_login_adv (ID_login_adv) on delete cascade on update cascade;


alter table tbl_tel_adv add
constraint FK_ID_adv foreign key (ID_adv)
references tbl_adv (ID_adv) on delete cascade on update cascade;


alter table tbl_adv add
constraint FK_ID_end_adv foreign key (ID_end_adv)
references tbl_end_adv (ID_end_adv) on delete cascade on update cascade;

alter table tbl_end_adv add
constraint FK_ID_cidade_adv foreign key(ID_cidade)
references tbl_cidade (ID_cidade) on delete cascade on update cascade;

alter table tbl_end_adv add
constraint FK_ID_estado_adv foreign key(ID_estado)
references tbl_estado (ID_estado) on delete cascade on update cascade;


alter table tbl_caso add
constraint FK_ID_categ_direito_caso foreign key (ID_categ_direito)
references tbl_categ_direito (ID_categ_direito) on delete cascade on update cascade;

alter table tbl_caso add
constraint FK_ID_usuario_caso foreign key (id_usuario)
references tbl_usuario (ID_usuario) on delete cascade on update cascade;

alter table tbl_caso add
constraint FK_ID_end_caso foreign key (ID_end_caso)
references tbl_end_caso (ID_end_caso) on delete cascade on update cascade;

alter table tbl_end_caso add
constraint FK_ID_cidade_caso foreign key (ID_cidade)
references tbl_cidade (ID_cidade) on delete cascade on update cascade;

alter table tbl_end_caso add
constraint FK_ID_estado_caso foreign key (ID_estado)
references tbl_estado (ID_estado) on delete cascade on update cascade;

alter table tbl_avaliacao_adv add
constraint FK_ID_caso_avalicao foreign key (ID_caso)
references tbl_caso (ID_caso) on delete cascade on update cascade;

alter table tbl_avaliacao_adv add
constraint FK_ID_adv_avalicao foreign key (ID_adv)
references tbl_adv (ID_adv) on delete cascade on update cascade;

alter table tbl_avaliacao_adv add
constraint FK_ID_usuario_avalicao foreign key (ID_usuario)
references tbl_usuario (ID_usuario) on delete cascade on update cascade;

alter table tbl_match_aconselhamento add
constraint FK_ID_caso_aconselhamento foreign key (ID_caso)
references tbl_caso (ID_caso) on delete cascade on update cascade;

alter table tbl_match_aconselhamento add
constraint FK_ID_usuario_aconselhamento foreign key (ID_usuario)
references tbl_usuario (ID_usuario) on delete cascade on update cascade;

alter table tbl_match_aconselhamento add
constraint FK_ID_adv_aconselhamento foreign key (ID_adv)
references tbl_adv (ID_adv) on delete cascade on update cascade;

alter table tbl_match_judicial add
constraint FK_ID_caso_judicial foreign key (ID_caso)
references tbl_caso (ID_caso) on delete cascade on update cascade;

alter table tbl_match_judicial add
constraint FK_ID_usuario_judicial foreign key (ID_usuario)
references tbl_usuario (ID_usuario) on delete cascade on update cascade;

alter table tbl_match_judicial add
constraint FK_ID_adv_judicial foreign key (ID_adv)
references tbl_adv (ID_adv) on delete cascade on update cascade;



