create database customer_behaviour
use customer_behaviour

select top 10 * from customer

--1
SELECT gender, sum(purchase_amount) revenue
FROM customer
GROUP BY gender;

--2
select customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes'
AND purchase_amount > (select avg(purchase_amount) from customer);

--3
SELECT top 5 item_purchased, round(avg(review_rating), 2) avg_product_rating
FROM customer
group by item_purchased

--4
select distinct shipping_type
from customer

SELECT shipping_type, ROUND(AVG(CAST(purchase_amount AS FLOAT)), 2)
FROM customer
WHERE shipping_type in ('Standard', 'Express')
group by shipping_type

--5
SELECT subscription_status,
	COUNT(customer_id) as no_of_customers,
	ROUND(AVG(CAST(purchase_amount AS FLOAT)), 2) average_spend,
	SUM(purchase_amount) total_revenue
FROM customer
group by subscription_status

--6
SELECT TOP 5 item_purchased,
	ROUND((SUM(CASE WHEN discount_applied = 'Yes' THEN CAST(1 AS FLOAT) ELSE 0 END) / COUNT(*)) * 100, 2) perc_of_purchases
FROM customer
GROUP BY item_purchased
ORDER BY perc_of_purchases DESC;

--7
SELECT MIN(previous_purchases), MAX(previous_purchases)
FROM customer;

WITH CTE AS (
	SELECT customer_id, previous_purchases,
	CASE 
		WHEN previous_purchases = 1 THEN 'NEW'
		WHEN previous_purchases BETWEEN 2 AND 10 THEN 'RETURNING'
		ELSE 'LOYAL'
	END seg
	FROM customer
)
SELECT seg, count(*) no_of_customers
FROM cte
GROUP BY seg;

--8
with cte as (
	SELECT category, item_purchased, count(*) item_count,
	ROW_NUMBER() OVER (PARTITION BY category ORDER BY count(*) DESC) r
	FROM customer
	GROUP BY category, item_purchased
)
SELECT category, item_purchased, item_count
FROM cte
WHERE r <= 3;

SELECT category,
	RANK() OVER (PARTITION BY category ORDER BY COUNT(item_purchased) DESC)
FROM customer

--9
select subscription_status, count(customer_id) buyer_count
FROM customer
where previous_purchases > 5
group by subscription_status

--10
SELECT age_group, SUM(purchase_amount) total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC