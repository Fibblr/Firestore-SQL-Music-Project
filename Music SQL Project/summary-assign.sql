USE movies;
-- add sql queries under the appropriate comment

-- exercise 1
SELECT COUNT(*)
FROM film
WHERE language_id = 2;
-- exercise 2
SELECT DISTINCT MIN(release_year)
FROM film
ORDER BY MIN(release_year);

-- exercise 3
SELECT MAX(length)
FROM film
WHERE rating = 'G';

-- exercise 4
SELECT release_year, COUNT(release_year)
FROM film
GROUP BY release_year
ORDER BY release_year;

-- exercise 5
SELECT length, COUNT(*)
FROM film
GROUP BY length
HAVING COUNT(*) > 10
ORDER BY COUNT(*) DESC;

-- exercise 6
SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id = 123
)
ORDER BY title ASC;


