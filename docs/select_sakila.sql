# Comando de busca do SQL (traz todos os dados da tabela)
SELECT * FROM sakila.film;

# Cláusulas do SQL - LIMIT limite - ORDER BY ordenar por - WHERE onde
# LIMIT(inicio, qtadade) - limita a busca retorna X registros
SELECT 	film_id, 
		title, 
		description, 
        rating 
			FROM sakila.film 
				LIMIT 0, 5;

# ORDER BY tipo - permite ordenar a busca de outra forma
# ASC - Crescente 1-10 A-Z  e DESC Decrescente 10-1 Z-A
SELECT  ROW_NUMBER() OVER() AS `#`, 
	actor_id AS ID, first_name AS Nome, 
    last_name AS Sobrenome 
		FROM sakila.actor 
			ORDER BY first_name DESC
				LIMIT 0, 10;

# WHERE condições - cláusula de filtro do SQL
# PK actor_id = 10 - busca o cadastro da tabela onde a coluna id é a 10 do banco - único item
# LIKE - parecido - caracteres curingas %
# AND - adicionar outra comparação onde as duas tem que ser verdadeiras
# OR - ou - uma condição ou a outra
# IN - EM - nos itens listados no ( "item", "item" )
# NOT IN - busca o que não está listado no ( )
# BETWEEN - intervalo - filmes lançados entre 2009 a 2020 - WHERE coluna BETWEEN > 2009
SELECT * 
	FROM sakila.actor
		WHERE first_name LIKE "j%" AND
			first_name LIKE "%e" OR
				first_name LIKE "e%";

SELECT * FROM sakila.film 
	WHERE rating NOT IN ("R", "G");

SELECT * FROM sakila.film 
	WHERE length BETWEEN 90 AND 120;
    
SELECT * FROM sakila.film 
	WHERE length > 90;    

