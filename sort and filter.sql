-- 1. Create a sample table for employees
CREATE TABLE employees
(
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50)
);

-- 2. Insert some example data
INSERT INTO employees
VALUES
    (1, 'Arjun', 'Engineering', 75000.00, 'Bangalore'),
    (2, 'Neha', 'Marketing', 55000.00, 'Mumbai'),
    (3, 'Priya', 'Engineering', 80000.00, 'Bangalore'),
    (4, 'Ravi', 'Sales', 45000.00, 'Chennai'),
    (5, 'Sita', 'Engineering', 60000.00, 'Pune');

-- 3. Filter & sort:
-- Select all employees in Engineering department, sorted by salary descending
SELECT emp_id, name, salary
FROM employees
WHERE department = 'Engineering'
ORDER BY salary DESC;

-- 4. Another example: show only employees earning more than 60 000, sorted by name ascending
SELECT emp_id, name, department, salary
FROM employees
WHERE salary > 60000
ORDER BY name ASC;
