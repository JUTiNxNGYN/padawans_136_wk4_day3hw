-- Justin Nguyen
-- Week 5 - Wednesday
-- Questions

-- 1. List all customers who live in Texas (use
-- JOINs)

-- SELECT *
-- from address

SELECT first_name, last_name, district
from customer
INNER JOIN address
ON address.address_id = customer.address_id
where district = 'Texas'

-- There are 5 customers who live in Texas: Jennifer Davis, Kim Cruz, 
-- Richard Mccrary, Bryan Hardison, and Ian Still

-- 2. Get all payments above $6.99 with the Customer's Full
-- Name

-- select*
-- from payment 

SELECT first_name,last_name,amount
FROM Customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99

-- There are 7 customers with payments that are above $6.99. 
-- Alfredo Mcadams (1), Alvin Deloach (1), Douglas Graf (1), Harold Martino (1), Ida Andrews (1)
-- Mary Smith (7), and Peter Menard (23) payments


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING sum(amount) >= 175
    ORDER BY sum(amount)
)

-- Mary Smith and Peter Menard are the two customers who made payments over $175

-- 4. List all customers that live in Nepal (use the city
-- table)

-- SELECT *
-- from city

-- select * 
-- FROM country

SELECT first_name, last_name, city, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city 
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id
WHERE country.country = 'Nepal'

-- There is only 1 customer who lives in Nepal, Kevin Schuler, who lives in Birgunj, Nepal.

-- 5. Which staff member had the most
-- transactions?

-- select *
-- from staff

SELECT first_name,last_name, COUNT(*) AS transaction_count
FROM staff
INNER JOIN payment 
ON staff.staff_id = payment.staff_id
INNER JOIN rental 
ON payment.rental_id = rental.rental_id
GROUP BY staff.staff_id
ORDER BY transaction_count DESC

-- The staff with the most transactions was Jon Stephens with 7304 transactions

-- 6. How many movies of each rating are
-- there?

-- select rating
-- from film

select rating, COUNT(*) AS unique_pos_value
from film
GROUP BY rating
ORDER BY unique_pos_value 

-- There are the ratings:
-- G: 178
-- PG: 194
-- R: 196
-- NC-17: 209
-- PG-13: 224

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id in (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(*) = 1
)

-- The customers who made a single payment above $6.99 are
-- Ida Andrews, Harold Martino, Douglas Graf, Alvin Deloach, and Alredo Mcadams

-- 8. How many free rentals did our stores give away?

SELECT COUNT(payment.rental_id) AS free_rental_count
FROM payment
INNER JOIN rental 
ON payment.rental_id = rental.rental_id
WHERE payment.amount = 0

-- There were no free rentals that the store gave away