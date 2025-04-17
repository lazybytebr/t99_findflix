# SELECT Consulta ou busca
# Cláusula WHERE filtros nas Consultas ( IN, BETWEEN, AND, OR, >, < )
# null - não é erro só quer dizer nada corresponde à Consulta feita

# 1.Liste todos os filmes que têm classificação "PG" E (AND) duração superior a 120 minutos.

SELECT title, release_year 
	FROM sakila.film
		WHERE rating = "PG" AND length > 120;

# 2.Encontre todos os atores que tenham o sobrenome "WILLIAMS" OU(OR) "DAVIS".

SELECT *
	FROM sakila.actor
		WHERE last_name IN ("WILLIAMS", "DAVIS");
 
 SELECT *
	FROM sakila.actor
		WHERE last_name = "WILLIAMS" OR last_name =  "DAVIS";

SELECT *
	FROM sakila.actor
		WHERE last_name LIKE "WILLIAMS" OR last_name LIKE  "DAVIS";        
        
# 3.Liste os títulos dos filmes lançados entre(BETWEEN) 2005 e 2007.

SELECT *
	FROM sakila.film
		WHERE release_year BETWEEN 2005 AND 2007;
        
SELECT *
	FROM sakila.film
		WHERE release_year > 2005 AND release_year < 2007;

# 4.Liste os títulos dos filmes que tenham duração menor que 90 minutos.

SELECT *
	FROM sakila.film 
		WHERE length < 90;

# 5.Liste os filmes que estão disponíveis na loja 1
# BANCO de DADOS RELACIONAL
DESCRIBE sakila.inventory;

SELECT *
	FROM sakila.inventory
		WHERE store_id = 1;

# JOIN - são os comandos para buscar dados através do relacionamento
# INNER JOIN - busca tudo das tabelas que estela relacionados

SELECT title, length, store_id, filmes.film_id
	FROM sakila.inventory AS estoque
		INNER JOIN sakila.film AS filmes ON estoque.film_id = filmes.film_id
			WHERE estoque.store_id = 1;
        
# LEFT JOIN - busca tudo da tabela esquerda (primeira) e as correspondência
SELECT title, length, store_id, filmes.film_id
	FROM sakila.inventory AS estoque
		LEFT JOIN sakila.film AS filmes ON estoque.film_id = filmes.film_id
			WHERE estoque.store_id = 1;

# RIGHT JOIN - busca tudo da tabela direita (segunda) e as correspondência       
SELECT title, length, store_id, filmes.film_id
	FROM sakila.inventory AS estoque
		RIGHT JOIN sakila.film AS filmes ON estoque.film_id = filmes.film_id
			WHERE estoque.store_id = 1;	

# 6.Liste os títulos dos filmes que tenham duração entre 85 e 110 minutos.

SELECT *
	FROM sakila.film 
		WHERE length > 85 AND length < 110 ;
        
SELECT *
	FROM sakila.film 
			WHERE lenght BETWEEN 85 AND 110;

# 7. Liste os filmes que estão com idioma original 6 ( original_language)

SELECT *
	FROM sakila.film 
			WHERE original_language_id = 6;

