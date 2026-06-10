CREATE TABLE decodelab_data (
    order_id TEXT,
	order_date TEXT, 
    customer_id TEXT,
    product TEXT,
    quantity TEXT,
    unit_price TEXT,
    shipping_address TEXT,
	payment_method TEXT,
	order_status TEXT,
	tracking_number TEXT,
	items_in_cart TEXT,
	coupon_code TEXT,
	referral_source TEXT,
	total_price TEXT
);


SELECT * FROM decodelab_data LIMIT 10;
-- Imported the dataset
SELECT * 
FROM decodelab_data 
LIMIT 10;

--Converting to normal parameters
ALTER TABLE decodelab_data
ALTER COLUMN order_date TYPE DATE
USING order_date::date;

UPDATE decodelab_data
SET unit_price=REPLACE(unit_price, '$', '');

ALTER TABLE decodelab_data
ALTER COLUMN unit_price TYPE NUMERIC
USING unit_price::numeric;

UPDATE decodelab_data
SET total_price=REPLACE(total_price, '$', '');

UPDATE decodelab_data
SET total_price=REPLACE(total_price, ',', '');

UPDATE decodelab_data
SET total_price=REPLACE(total_price, '.', '');

ALTER TABLE decodelab_data
ALTER COLUMN total_price TYPE NUMERIC
USING total_price::numeric;

ALTER TABLE decodelab_data
ALTER COLUMN items_in_cart TYPE NUMERIC
USING items_in_cart::numeric;

ALTER TABLE decodelab_data
ALTER COLUMN quantity TYPE INTEGER
USING quantity::integer;
-- Using where
--Expensive items over $400
SELECT *
FROM decodelab_data
WHERE unit_price > 400;
--Cheap items less than $100
SELECT *
FROM decodelab_data
WHERE unit_price < 100;

--Purchase about 3 items
SELECT *
FROM decodelab_data
WHERE quantity > 3;

--Orders after 10th June 2024
SELECT *
FROM decodelab_data
WHERE order_date > '2024-06-10';

--Orders from a specific customer
SELECT *
FROM decodelab_data
WHERE customer_id = 'C38785';

--Excluding some product type
SELECT *
FROM decodelab_data
WHERE product <> 'Tablet';

--USING ORDER BY
--Sorting by the highest price comes first
SELECT *
FROM decodelab_data
ORDER BY unit_price DESC;
--By most recent order
SELECT *
FROM decodelab_data
ORDER BY order_date DESC;
---Alphabetical order
SELECT *
FROM decodelab_data
ORDER BY product ASC;

--USING GROUP BY
--Total Quantity sold per product

SELECT product,
     SUM (quantity) AS total_quantity
FROM decodelab_data
GROUP BY product
ORDER BY total_quantity DESC;

---Total revenue per product
SELECT product,
       SUM(unit_price * quantity) AS total_revenue
FROM decodelab_data
GROUP BY product
ORDER BY total_revenue DESC;

--Number of orders per customer
SELECT customer_id,
       COUNT(*) AS total_orders
FROM decodelab_data
GROUP BY customer_id
ORDER BY total_orders DESC;