USE movies;
-- add sql queries under the appropriate comment

-- exercise 1
SELECT film.title, film.release_year
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = 27
ORDER BY film.title;
-- exercise 2
SELECT film.title, film.release_year
FROM film
JOIN film_category ON film.film_id = film_category.film_id
WHERE film_category.category_id = 14
ORDER BY film.title;
-- exercise 3
SELECT film.title, film.release_year
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Travel'
ORDER BY film.title;
-- exercise 4
SELECT film.title, film.release_year
From film
JOIN film_actor on film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = 'ELVIS' AND actor.last_name = 'MARX'
ORDER BY film.title;
-- exercise 5
SELECT category.name AS category_name, COUNT(film_category.film_id) AS film_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.category_id, category.name
ORDER BY film_count DESC;

-- exercise 6
CREATE OR REPLACE VIEW film_title_year AS
SELECT film.title, film.release_year
FROM film
ORDER BY film.title;


SELECT * FROM film_title_year
ORDER BY title;
-- don't forget to answer question 7 in the read me file
