# LOWER() função do SQL que deixa o texto em caixa baixa
# UPPER() função do SQL que deixa o texto em caixa alta
# CONCAT() função que permite juntar campos
# RAND() cria números aleatórios
# FLOOR() arredonda para menos
# + - * / () operadores matemáticos
SELECT 	customer_id,
		LOWER( CONCAT( first_name, "." , last_name ) ) as nome_usuario, 
		LOWER(email),
		MD5( FLOOR( 1 + ( RAND() * 1000 ) ) ) as senha
	FROM sakila.customer
		ORDER BY last_name ASC
			LIMIT 0, 100;
            
-- Operações básicas de um sistema CRUD (manter registros usuarios)
-- Create - INSERT - cadastrar 
-- Read - SELECT - pesquisar
-- Update - UPDATE - alterar/atualizar
-- Delete - DELETE - apagar 
-- Respeitar as Constraints ou restrições do Banco de Dados

INSERT INTO filmes_t99.usuarios (
	email,
    senha    
) VALUES (
	"maycon.aguerra@senacsp.edu.br",
    "1234"
); 

-- O comando INSERT permite inserir dados gerados por uma 
-- pesquisa SELECT     
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










            