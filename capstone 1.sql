-- 1. Create a sample table for product sales
CREATE TABLE product_sales
(
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    sale_date DATE
);

-- 2. Insert example data
INSERT INTO product_sales
VALUES
    (1, 'Widget A', 10, 15.00, '2025-06-01'),
    (2, 'Widget B', 5, 20.00, '2025-06-02'),
    (3, 'Widget A', 15, 15.00, '2025-06-05'),
    (4, 'Widget C', 2, 100.00, '2025-06-07'),
    (5, 'Widget B', 10, 20.00, '2025-06-10');

-- 3. Filter and sort: show June sales sorted by amount
SELECT sale_id, product_name, quantity, unit_price,
    quantity * unit_price AS amount
FROM product_sales
WHERE sale_date BETWEEN '2025-06-01' AND '2025-06-30'
ORDER BY amount DESC;

-- 4. Aggregate + GROUP BY: total units & revenue per product
SELECT product_name,
    SUM(quantity)     AS total_units_sold,
    SUM(quantity * unit_price) AS total_revenue,
    AVG(unit_price)   AS avg_price
FROM product_sales
WHERE sale_date >= '2025-06-01'
GROUP BY product_name;

-- 5. Filter grouped results with HAVING and sort
SELECT product_name,
    SUM(quantity)     AS total_units_sold,
    SUM(quantity * unit_price) AS total_revenue
FROM product_sales
GROUP BY product_name
HAVING SUM(quantity) > 10
-- only products with >10 units sold
ORDER BY total_revenue DESC;
