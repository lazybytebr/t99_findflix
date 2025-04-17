# Comentário no SQL

# 0. Conectar ao banco - linha de comando/console
# .\mysql -uroot -p

# 1. Criar um Banco de Dados
# `` crase
CREATE DATABASE IF NOT EXISTS `t99_filmes`;
CREATE SCHEMA IF NOT EXISTS `t99_filmes`;

# 2. Criar as tabelas
CREATE TABLE IF NOT EXISTS `t99_filmes`.`usuarios`(
	id INT(255) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(40),
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(40) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `t99_filmes`.`filmes` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `sinopse` LONGTEXT NULL,
  `duracao` TIME NULL,
  `titulo` VARCHAR(255) NOT NULL,
  `genero` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `t99_filmes`.`colaboradores` (
  `id` INT(255) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nome_completo` VARCHAR(255) NOT NULL,
  `registro` VARCHAR(20) NOT NULL UNIQUE,
  `data_nasc` DATE NOT NULL,
  `endereco` VARCHAR(255) NULL,
  `funcao` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `rg` VARCHAR(20) NULL  
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `t99_filmes`.`cinemas` (
  `id` INT(255) NOT NULL AUTO_INCREMENT,
  `assentos` VARCHAR(45) NULL,
  `ticket` VARCHAR(45) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `endereco` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB

