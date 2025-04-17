-- Banco de Dados Filmes T99
-- Execute para criar o banco inicial.

-- ---------------------------------
-- Criação do Banco de Filmes
-- ---------------------------------
DROP DATABASE IF EXISTS filmes_t99; -- apaga o banco se existir

CREATE DATABASE IF NOT EXISTS filmes_t99; -- cria o banco se não existe

-- ---------------------------------------
-- tabela de Usuários do sistema
-- ---------------------------------------
CREATE TABLE IF NOT EXISTS `filmes_t99`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(74) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  `nome_usuario` VARCHAR(45) NULL,
  `valido` INT(1) NOT NULL DEFAULT 0,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_alteracao` DATETIME NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- ----------------------------------------
-- Tabela de Dados Pessoais dos Usuários
-- ----------------------------------------
CREATE TABLE IF NOT EXISTS `filmes_t99`.`dados_pessoais` (
  `id_dado_pessoal` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `nome` VARCHAR(255) NOT NULL,
  `sobrenome` VARCHAR(255) NOT NULL,
  `rg` VARCHAR(45) NULL,
  `cpf` VARCHAR(11) NOT NULL UNIQUE COMMENT 'Guardar sem máscara, apenas números',
  `data_nascimento` DATE NOT NULL,
  `nacionalidade` VARCHAR(3) NOT NULL,
  `data_cadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_alteracao` DATETIME NULL,
  `usuarios_id_usuario` INT NOT NULL UNIQUE,
  FOREIGN KEY ( usuarios_id_usuario ) REFERENCES filmes_t99.usuarios(id_usuario)
) ENGINE = InnoDB;

-- ------------------------------------
-- inserir os dados na tabela usuarios
-- ------------------------------------
INSERT INTO `filmes_t99`.`usuarios` (`id_usuario`, `email`, `senha`, `nome_usuario`, `valido`, `data_cadastro`, `data_alteracao`) VALUES (1, 'maycon.aguerra@sp.senac.br', '81dc9bdb52d04dc20036dbd8313ed055', 'maycon.aguerra', 1, '2025-03-25 08:18:15', NULL);
INSERT INTO `filmes_t99`.`usuarios` (`id_usuario`, `email`, `senha`, `nome_usuario`, `valido`, `data_cadastro`, `data_alteracao`) VALUES (2, 'marta.rocha@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'marta.rocha', 0, DEFAULT, NULL);

INSERT INTO filmes_t99.usuarios (
	email, #1
    senha, #2
    nome_usuario #3
) 
SELECT 	LOWER(email),#1
		MD5( FLOOR( 1 + ( RAND() * 1000 ) ) ) as senha,#2
		LOWER( CONCAT( first_name, "." , last_name ) ) as nome_usuario #3
	FROM sakila.customer
		ORDER BY last_name ASC
			LIMIT 0, 100;   

-- ---------------------------------
-- Inserir na Tabela Dados Pessoais
-- ---------------------------------
INSERT INTO filmes_t99.dados_pessoais (
	usuarios_id_usuario, # FK - Foreign Key - Chave Estrangeira
    rg,
    cpf,
    data_nascimento,
    nacionalidade,
    nome,
    sobrenome
) VALUES (
	24,
	FLOOR( RAND() * 10000 + 1 ),
    FLOOR( RAND() * 10000 + 1 ),
    "1978-11-22",
    "br",
    ( SELECT first_name FROM sakila.customer ORDER BY RAND()  LIMIT 1 ),
    ( SELECT last_name FROM sakila.customer ORDER BY RAND() LIMIT 1 )
);

-- Unindo pesquisas SELECT
-- UNION só funciona se as tabelas tiverem as mesmas colunas
-- Buscar dados para comparação ( traz o das duas tabelas )
SELECT u.data_cadastro FROM filmes_t99.usuarios as u
UNION
SELECT d.data_cadastro FROM filmes_t99.dados_pessoais as d;

# SELECT first_name as Nome, last_name as Sobrenome 
#	FROM sakila.customer
#		ORDER BY RAND() -- pega aleatoriamente
#			LIMIT 0,100;



