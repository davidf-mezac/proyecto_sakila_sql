-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT title 
FROM film 
WHERE rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
SELECT first_name, last_name 
FROM actor 
WHERE actor_id >= 30 AND actor_id <= 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT title 
FROM film 
WHERE language_id = original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
SELECT title, length 
FROM film 
ORDER BY length ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
SELECT first_name, last_name 
FROM actor 
WHERE last_name LIKE '%Allen%';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(*) AS total_peliculas 
FROM film 
GROUP BY rating;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
SELECT title 
FROM film 
WHERE rating = 'PG-13' OR length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE(replacement_cost), STDDEV(replacement_cost) 
FROM film;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX(length) AS maximo, MIN(length) AS minimo 
FROM film;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT amount 
FROM payment 
ORDER BY payment_date DESC 
OFFSET 2 LIMIT 1;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
SELECT title 
FROM film 
WHERE rating != 'NC-17' AND rating != 'G';

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT rating, AVG(length) AS promedio 
FROM film 
GROUP BY rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title 
FROM film 
WHERE length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(amount) AS total_dinero 
FROM payment;

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT * 
FROM customer 
ORDER BY customer_id DESC 
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT actor.first_name, actor.last_name 
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title 
FROM film;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
SELECT film.title 
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND film.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT category.name, AVG(film.length) AS promedio
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING AVG(film.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG(rental_duration) 
FROM film;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT first_name || ' ' || last_name AS nombre_completo 
FROM actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT DATE(rental_date) AS dia, COUNT(*) AS cantidad 
FROM rental
GROUP BY DATE(rental_date)
ORDER BY cantidad DESC;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT title, length 
FROM film 
WHERE length > (SELECT AVG(length) FROM film);

-- 25. Averigua el número de alquileres registrados por mes.
SELECT EXTRACT(MONTH FROM rental_date) AS mes, COUNT(*) AS cantidad 
FROM rental
GROUP BY EXTRACT(MONTH FROM rental_date)
ORDER BY mes;

-- 26. Encuentra el número total de películas alquiladas por cada cliente y muestra su ID, nombre, apellido y total de alquileres.
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_alquiladas
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_alquiladas DESC;

-- 27. Obtén la cantidad total de películas alquiladas por cada tienda.
SELECT store.store_id, COUNT(rental.rental_id) AS total
FROM store 
JOIN staff ON store.store_id = staff.store_id
JOIN rental ON staff.staff_id = rental.staff_id
GROUP BY store.store_id;

-- 28. Encuentra el número de veces que se ha alquilado cada película.
SELECT film.film_id, film.title, COUNT(rental.rental_id) AS veces
FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY veces DESC;

-- 29. Encuentra las categorías de películas que tienen más de 60 películas asociadas.
SELECT category.name, COUNT(film_category.film_id) 
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
HAVING COUNT(film_category.film_id) > 60;

-- 30. Encuentra el cliente que ha gastado más dinero en alquileres.
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS total
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC
LIMIT 1;

-- 31. Obtén el nombre del cliente y el total acumulado de sus pagos realizados.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) 
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;

-- 32. Muestra los actores que han actuado en más de 20 películas.
SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) 
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(film_actor.film_id) > 20;

-- 33. Obtén la lista de películas que nunca han sido alquiladas.
SELECT film.title
FROM film 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_id IS NULL;
-- Se usó un LEFT JOIN encadenado desde film hasta rental, seguido de un filtro WHERE ... IS NULL porque requiere pensar al revés en lugar de buscar lo que
-- existe, buscamos lo que falta.


-- 34. Encuentra los clientes que han realizado al menos un pago mayor a $10.
SELECT DISTINCT customer.first_name, customer.last_name
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.amount > 10;

-- 35. Muestra las películas junto con la cantidad de actores que participan en cada una.
SELECT film.title, COUNT(film_actor.actor_id) AS cantidad_actores
FROM film 
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id, film.title
ORDER BY cantidad_actores DESC;

-- 36. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película.
SELECT actor.first_name, actor.last_name
FROM actor 
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IS NULL;

-- 37. Encuentra el número total de películas alquiladas por cada categoría.
SELECT category.name, COUNT(rental.rental_id) AS cantidad_alquileres
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name
ORDER BY cantidad_alquileres DESC;

-- 38. Muestra los clientes que han alquilado al menos una película de la categoría ‘Action’.
SELECT DISTINCT customer.first_name, customer.last_name
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action';

-- 39. Encuentra la cantidad total de pagos realizados por cada cliente en cada mes.
SELECT customer.first_name, customer.last_name,
       EXTRACT(MONTH FROM payment.payment_date) AS mes,
       COUNT(payment.payment_id) AS cantidad_pagos,
       SUM(payment.amount) AS dinero_total
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name, EXTRACT(MONTH FROM payment.payment_date)
ORDER BY customer.customer_id, mes;

-- 40. Encuentra el promedio de duración de las películas por cada combinación de categoría y clasificación.
SELECT category.name, film.rating, AVG(film.length) AS promedio_duracion
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name, film.rating
ORDER BY category.name, film.rating;

-- 41. Muestra el nombre y apellido de los clientes que han alquilado más de 30 películas.
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_alquileres
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(rental.rental_id) > 30;

-- 42. Encuentra la película más alquilada de cada categoría.
-- Usamos una tabla temporal (CTE) paso a paso
WITH conteo_alquileres AS (
    SELECT category.name AS categoria, film.title AS pelicula, COUNT(rental.rental_id) AS total
    FROM category 
    JOIN film_category ON category.category_id = film_category.category_id
    JOIN film ON film_category.film_id = film.film_id
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY category.name, film.title
)
SELECT categoria, pelicula, total
FROM (
    SELECT categoria, pelicula, total, 
           ROW_NUMBER() OVER(PARTITION BY categoria ORDER BY total DESC) AS posicion
    FROM conteo_alquileres
) subconsulta
WHERE posicion = 1;
--


-- 43. Obtén la lista de clientes que no han realizado ningún pago.
SELECT customer.first_name, customer.last_name
FROM customer 
LEFT JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.payment_id IS NULL;

-- 44. Encuentra las películas que tienen una duración superior a la media de su propia categoría.
SELECT film.title, film.length, category.name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.length > (
    SELECT AVG(f2.length)
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE fc2.category_id = category.category_id
);
-- Insertamos una subconsulta dentro de la cláusula WHERE que calcula un promedio, pero esa subconsulta depende de la consulta principal.

-- 45. Muestra los actores que han actuado en películas de todas las categorías disponibles.
SELECT actor.first_name, actor.last_name
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film_category ON film_actor.film_id = film_category.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
HAVING COUNT(DISTINCT film_category.category_id) = (SELECT COUNT(*) FROM category);
-- Usando el COUNT(DISTINCT...) contamos las diferentes categorías, luego usamos el HAVING para igualar el número con el resultado de una subconsulta global
-- que simplemente cuenta cuantas categorías existen en total. Si coinciden significa que hizo todas.ç


-- 46. Encuentra el número total de actores y actrices distintos que aparecen en las películas clasificadas como ‘PG-13’.
SELECT COUNT(DISTINCT film_actor.actor_id) AS cantidad_actores
FROM film_actor 
JOIN film ON film_actor.film_id = film.film_id
WHERE film.rating = 'PG-13';

-- 47. Encuentra la cantidad total de películas alquiladas en las que participó cada actor o actriz.
SELECT actor.first_name, actor.last_name, COUNT(rental.rental_id) AS veces_alquilada
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN inventory ON film_actor.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY veces_alquilada DESC;

-- 48. Obtén la lista de películas que tienen un costo de reemplazo superior al promedio de su categoría.
SELECT film.title, film.replacement_cost, category.name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.replacement_cost > (
    SELECT AVG(f2.replacement_cost)
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE fc2.category_id = category.category_id
);

-- 49. Encuentra la cantidad total de películas que pertenecen a más de una categoría.
SELECT film.title, COUNT(film_category.category_id) AS cantidad_categorias
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
GROUP BY film.film_id, film.title
HAVING COUNT(film_category.category_id) > 1;

-- 50. Muestra los actores que han actuado en al menos una película junto con el actor 'Woody Hoffman'.
SELECT DISTINCT actor.first_name, actor.last_name
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IN (
    SELECT film_actor2.film_id
    FROM film_actor AS film_actor2
    JOIN actor AS actor2 ON film_actor2.actor_id = actor2.actor_id
    WHERE actor2.first_name = 'WOODY' AND actor2.last_name = 'HOFFMAN'
)
AND actor.first_name != 'WOODY' AND actor.last_name != 'HOFFMAN';

-- 51. Encuentra el promedio de días que una película permanece alquilada antes de ser devuelta.
SELECT AVG(EXTRACT(DAY FROM (return_date - rental_date))) AS promedio_dias
FROM rental
WHERE return_date IS NOT NULL;
-- Restamos dos (timestamp) para obtener un intervalo del cual se extrae una porció de días para al final promediar.

-- 52. Muestra los 5 clientes que más dinero han gastado en la tienda número 1.
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS gasto_total
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
WHERE customer.store_id = 1
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY gasto_total DESC
LIMIT 5;

-- 53. Encuentra las películas que nunca han sido devueltas (return_date es nulo).
SELECT DISTINCT film.title
FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.return_date IS NULL;

-- 54. Obtén el total de ingresos generados por cada categoría de película.
SELECT category.name, SUM(payment.amount) AS ingresos
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY ingresos DESC;

-- 55. Muestra el título de las películas y su posición relativa de duración respecto a todas las demás películas (ranking general de duración).
SELECT title, length,
       RANK() OVER (ORDER BY length DESC) AS ranking
FROM film;

-- 56. Encuentra el total de alquileres y el total de ingresos generados por cada tienda.
SELECT store.store_id, 
       COUNT(DISTINCT rental.rental_id) AS alquileres, 
       SUM(payment.amount) AS ingresos
FROM store 
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY store.store_id;

-- 57. Muestra el cliente que ha alquilado la mayor cantidad de películas de la categoría ‘Action’.
SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS total_accion
FROM customer 
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action'
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_accion DESC
LIMIT 1;

-- 58. Encuentra los actores que han actuado en más películas de más de 120 minutos.
SELECT actor.first_name, actor.last_name, COUNT(film.film_id) AS peliculas_largas
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.length > 120
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY peliculas_largas DESC;

-- 59. Calcula el porcentaje de ingresos que representa cada categoría sobre el total de la empresa.
SELECT category.name, 
       SUM(payment.amount) AS ingresos_categoria,
       ROUND((SUM(payment.amount) / (SELECT SUM(amount) FROM payment)) * 100, 2) AS porcentaje
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY porcentaje DESC;

-- 60. Muestra las películas con costo de alquiler superior al promedio pero duración inferior al promedio.
SELECT title, rental_rate, length
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
  AND length < (SELECT AVG(length) FROM film);

-- 61. Encuentra el número de clientes únicos que alquilaron películas en cada día de la semana.
SELECT EXTRACT(DOW FROM rental_date) AS dia_semana,
       COUNT(DISTINCT customer_id) AS clientes
FROM rental
GROUP BY EXTRACT(DOW FROM rental_date)
ORDER BY dia_semana;

-- 62. Muestra la diferencia entre la duración máxima y mínima de las películas de cada categoría.
SELECT category.name,
       MAX(film.length) AS duracion_max,
       MIN(film.length) AS duracion_min,
       MAX(film.length) - MIN(film.length) AS diferencia
FROM category 
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

-- 63. Calcula el ingreso acumulado por fecha a lo largo del tiempo (Running Total).
SELECT DATE(payment_date) AS fecha,
       SUM(amount) AS ingresos_dia,
       SUM(SUM(amount)) OVER (ORDER BY DATE(payment_date)) AS acumulado
FROM payment
GROUP BY DATE(payment_date)
ORDER BY fecha;

-- 64. Resumen consolidado del rendimiento por película (alquileres e ingresos totales generados).
SELECT film.title,
       COUNT(rental.rental_id) AS total_alquileres,
       COALESCE(SUM(payment.amount), 0) AS ingresos_totales
FROM film 
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.film_id, film.title
ORDER BY ingresos_totales DESC;
-- Encadenamos LEFT JOINs y se envuelve la función SUM() dentro  de una función de control de nulos COALESCE()