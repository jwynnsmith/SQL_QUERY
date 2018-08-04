USE sakila

-- 1a
SELECT 
	first_name,
    last_name
FROM
	actor;
  
  
-- 1b
SELECT
	CONCAT(
    first_name, 
    ' ',
    last_name
    )

AS
	Actor_Name
FROM
	actor;

  
-- 2a

SELECT
	actor_id
FROM
	actor
WHERE
	first_name = 'GRACE';

-- 2b
SELECT
	last_name
FROM
	actor
WHERE
	last_name 
LIKE
	'%GEN%';

-- 2c
SELECT
	last_name,
    first_name
FROM
	actor
WHERE
	last_name 
LIKE
	'%LI%';


-- 2d
SELECT
	country_id,
    country
FROM
	country
WHERE 
	country
IN( 
	'Afghanistan',
    'Bangladesh',
    'China'
    );

 -- 3a
ALTER TABLE
	actor
    
ADD
	middle_name VARCHAR(30)

AFTER
	first_name;


-- 3b
ALTER TABLE
	actor

MODIFY
	middle_name BLOB;
    
-- 3c
ALTER TABLE
	actor
    
DROP COLUMN
	middle_name;

-- 4a
SELECT
	last_name,
	COUNT(last_name)
    
FROM
	actor
    
GROUP BY
	last_name;

-- 4b
SELECT
	last_name,
	COUNT(last_name)
    
FROM
	actor
    
GROUP BY
	last_name
    
HAVING
	COUNT(last_name) >= 2;
    
-- 4c
SELECT REPLACE('GROUCHO', 'GROUCH', 'HARP');
 
-- 4d

SELECT REPLACE('HARPO', 'HARP', 'MUCHO GROUCH');
    
UPDATE 
	actor

SET
	first_name = 'GROUCHO'
    
WHERE
	actor_id = 78 ;


-- 5a
CREATE SCHEMA address;


-- 6a
SELECT 
    first_name,
    last_name,
  	a.address
    
FROM
	staff s
    JOIN address a
    ON (a.address_id = s.address_id);


-- 6b
SELECT 
	s.first_name,
    s.last_name,
  	p.payment,
	sum(amount),
    p.payment_date
    
FROM
	staff s,
	payment p

WHERE
	s.staff_id = p.staff_id AND p.payment_date LIKE '%2005-08%' 

GROUP BY 2;

    
-- 6c
SELECT
	title,
    count(actor_id) 

FROM
	film
	INNER JOIN film_actor
    ON film.film_id = film_actor.film_id

GROUP BY
	title;
    
-- 6d
SELECT
	title,
    count(inventory_id) AS 'Number of Copies'

FROM
	film
	INNER JOIN inventory
    ON film.film_id = inventory.film_id

WHERE
	title = 'HUNCHBACK IMPOSSIBLE';



-- 6e
SELECT
    last_name,
    count(amount)

FROM
	customer
	INNER JOIN payment
    ON customer.customer_id = payment.customer_id

GROUP BY
	last_name;

-- 7a
SELECT
	title

FROM
	film

WHERE
	title LIKE 'K%' OR title LIKE'Q%';


-- 7b
SELECT
	first_name,
    last_name
    
FROM
	actor

WHERE
	actor_id IN
    
(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
    (
		SELECT film_id
        FROM film
        WHERE title = 'ALONE TRIP'
	)
);


-- 7c
SELECT
	c.first_name,
    c.last_name,
    c.email
    
FROM
	customer c
	INNER JOIN address a
    ON c.address_id = a.address_id
	
	INNER JOIN city ct
    ON a.city_id = ct.city_id

	INNER JOIN country cy
	ON ct.country_id = cy.country_id
    
WHERE
	cy.country = 'CANADA';


-- 7d

SELECT
	title
    
FROM
	film

    
WHERE
	rating = 'G';

-- 7e
SELECT
	f.title,
    count(r.rental_id)
    
FROM
	 film f
	INNER JOIN inventory i
    ON f.film_id = i.film_id
	
	INNER JOIN rental r
    ON i.inventory_id = r.inventory_id

GROUP BY f.title   

ORDER BY 2 DESC;

-- 7f
SELECT 
	c.store_id AS STORE_NUMBER,
    sum(p.amount) AS TOTAL_REVENUE 

FROM 
	customer c, 
	payment p 

WHERE c.customer_id=p.customer_id 

GROUP BY 1;


-- 7g

SELECT
	s.store_id,
    c.city,
    cy.country
    
FROM
	 store s 
	INNER JOIN address a
    ON s.address_id = a.address_id
	
	INNER JOIN city c
    ON c.city_id = a.city_id

	INNER JOIN country cy
    ON c.country_id = cy.country_id
    
GROUP BY f.title   

ORDER BY 2 DESC;


-- 7h
SELECT
	cat.name,
    sum(p.amount) AS 'Gross Revenue'

    
FROM
	 payment p 
	INNER JOIN rental r
    ON p.rental_id = r.rental_id
	
	INNER JOIN  inventory i
    ON r.inventory_id = i.inventory_id

	INNER JOIN film_category fc
    ON fc.film_id = i.film_id

	INNER JOIN category cat
    ON cat.category_id = fc.category_id
    
GROUP BY cat.name   

ORDER BY 2 DESC;

-- 8a
CREATE VIEW  Top_5_Genres AS

SELECT
	cat.name,
    sum(p.amount) AS 'Gross Revenue'

    
FROM
	 payment p 
	INNER JOIN rental r
    ON p.rental_id = r.rental_id
	
	INNER JOIN  inventory i
    ON r.inventory_id = i.inventory_id

	INNER JOIN film_category fc
    ON fc.film_id = i.film_id

	INNER JOIN category cat
    ON cat.category_id = fc.category_id
    
GROUP BY cat.name   

ORDER BY 2 DESC;

-- 8b
SELECT * FROM Top_5_Genres;

-- 8c
DROP VIEW Top_5_Genres;