-- Check for Null Values--

SELECT COUNT(*)
FROM ecommerce_sales
WHERE category_code IS NULL;

SELECT COUNT(*)
FROM ecommerce_sales
WHERE brand IS NULL;

--Update Table with placeholder--

UPDATE ecommerce_sales
SET category_code = 'Unknown Category'
WHERE category_code IS NULL;

UPDATE ecommerce_sales
SET brand = 'Unknown Brand'
WHERE brand IS NULL;

--Check for duplicates--

SELECT
    event_time,
    event_type,
    product_id,
    category_code,
    category_id, 
    brand,
    price,
    user_id,
    user_session,
    COUNT(*) as num_duplicates
FROM
    ecommerce_sales
GROUP BY
    event_time,
    event_type,
    product_id,
    category_code,
    category_id,
    brand,
    price,
    user_id,
    user_session
HAVING
    COUNT(*) > 1;
	
--Deleting Duplicates with CTE--

WITH CTE_Duplicates AS (
    SELECT
        ROWID,
        ROW_NUMBER() OVER(
            PARTITION BY
                event_time,
                event_type,
                product_id,
                category_code,
                category_id,
                brand,
                price,
                user_id,
                user_session
            ORDER BY event_time
        ) as rn
    FROM
        ecommerce_sales
)
DELETE FROM ecommerce_sales
WHERE ROWID IN (SELECT ROWID FROM CTE_Duplicates WHERE rn > 1);

--Create a purchase table from the Ecommerce table--

CREATE TABLE purchases AS
SELECT
    event_time,
    product_id,
    category_code,
    category_id, 
    brand,
    price,
    user_id,
    user_session,
    CAST(STRFTIME('%Y', REPLACE(event_time, ' UTC', '')) AS INTEGER) AS sale_year,
    CAST(STRFTIME('%m', REPLACE(event_time, ' UTC', '')) AS INTEGER) AS sale_month_num,
    STRFTIME('%W', REPLACE(event_time, ' UTC', '')) AS sale_week_of_year,
    STRFTIME('%Y-%m', REPLACE(event_time, ' UTC', '')) AS sale_year_month,
    CAST(STRFTIME('%d', REPLACE(event_time, ' UTC', '')) AS INTEGER) AS sale_day_of_month,
    CAST(STRFTIME('%w', REPLACE(event_time, ' UTC', '')) AS INTEGER) AS sale_day_of_week_num
FROM
    ecommerce_sales
WHERE
    event_type = 'purchase'
    AND event_time IS NOT NULL AND event_time != '';

--Top Selling Product Categories--

SELECT category_code, COUNT(*) as number_of_purchases
FROM purchases
GROUP BY category_code
ORDER BY number_of_purchases DESC
LIMIT 10;

--Least Selling Product Categories--

SELECT category_code, COUNT(*) as number_of_purchases
FROM purchases
GROUP BY category_code
ORDER BY number_of_purchases ASC
LIMIT 10;

--Total Revenue Per Product Category--

SELECT category_code, SUM(price) as total_revenue
FROM purchases
GROUP BY category_code
ORDER BY total_revenue DESC
LIMIT 10;

--Day with the Most Purchases (Highest Volume)--

SELECT
  DATE(SUBSTR(event_time, 1, LENGTH(event_time) - 4)) AS sale_date, -- Remove " UTC"
  COUNT(*) AS number_of_purchases
FROM
  purchases
GROUP BY
  sale_date
ORDER BY
  number_of_purchases DESC
LIMIT 1;

--Day with the Highest Total Revenue (Highest Sales Value)

SELECT
  DATE(SUBSTR(event_time, 1, LENGTH(event_time) - 4)) AS sale_date, -- Remove " UTC"
  SUM(price) AS total_revenue
FROM
  purchases
WHERE
  price IS NOT NULL
GROUP BY
  sale_date
ORDER BY
  total_revenue DESC
LIMIT 1;

--which brand within the construction_tools_light (Highest Selling Category) category brought the most sales (total price) and the most orders (count of purchases)--

SELECT
  brand,
  SUM(price) AS total_sales,
  COUNT(*) AS total_orders
FROM
  purchases
WHERE
  category_code = 'construction.tools.light'
GROUP BY
  brand
ORDER BY
  total_sales DESC, total_orders DESC
LIMIT 1;

--Find categories with an Unknown brand--

SELECT DISTINCT category_code
FROM purchases
WHERE brand = 'Unknown Brand';

--Find brands with an Unknown Category--

SELECT DISTINCT brand
FROM purchases
WHERE category_code = 'Unknown Category';



