-- 1. Create a sample table
CREATE TABLE sales (
  sale_id     INT PRIMARY KEY,
  product_id  INT,
  quantity    INT,
  price       DECIMAL(8,2),
  sale_date   DATE
);

-- 2. Insert sample data
INSERT INTO sales VALUES
(1, 101, 2, 150.00, '2025-07-01'),
(2, 102, 1, 50.00,  '2025-07-01'),
(3, 101, 3, 150.00, '2025-07-02'),
(4, 103, 5, 20.00,  '2025-07-02'),
(5, 102, 2, 50.00,  '2025-07-03');

-- 3. Total number of sales entries
SELECT COUNT(*) AS total_sales
FROM sales;

-- 4. Total quantity sold across all sales
SELECT SUM(quantity) AS total_units_sold
FROM sales;

-- 5. Average price per sale
SELECT AVG(price) AS avg_sale_price
FROM sales;

-- 6. Highest and lowest sale price
SELECT MAX(price) AS highest_price,
       MIN(price) AS lowest_price
FROM sales;

-- 7. Total revenue per product
SELECT product_id,
       SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_id;

-- 8. Show only products with total revenue over 300
SELECT product_id,
       SUM(quantity * price) AS total_revenue
FROM sales
GROUP BY product_id
HAVING SUM(quantity * price) > 300;
