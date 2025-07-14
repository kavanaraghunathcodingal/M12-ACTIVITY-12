-- 1. Create a sample table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    grade CHAR(1),
    city VARCHAR(50),
    score DECIMAL(5,2)
);

-- 2. Insert sample data
INSERT INTO students (id, name, age, grade, city, score) VALUES
(1, 'Arjun', 20, 'A', 'Mumbai', 85.5),
(2, 'Neha', 19, 'B', 'Pune',   72.3),
(3, 'Priya',22, 'A', 'Mumbai', 91.0),
(4, 'Ravi',  18, 'C', 'Navi Mumbai', 63.8),
(5, 'Sita',  21, 'B', 'Mumbai', 78.0);

-- 3. Comparison operators (=, <>, >, <, >=, <=)
SELECT * FROM students WHERE age >= 20;

-- 4. BETWEEN operator for range
SELECT name, age FROM students WHERE age BETWEEN 18 AND 21;

-- 5. IN operator for matching multiple values
SELECT name, grade FROM students WHERE grade IN ('A','B');

-- 6. LIKE operator for pattern matching
SELECT name FROM students WHERE name LIKE 'P%';  -- names starting with 'P'

-- 7. IS NULL operator (none in this dataset, but example)
SELECT * FROM students WHERE city IS NULL;

-- 8. Logical AND, OR, NOT
-- 8a) AND: all conditions must be true
SELECT * FROM students
WHERE city = 'Mumbai' AND grade = 'A';  :contentReference[oaicite:1]{index=1}

-- 8b) OR: any one condition true
SELECT * FROM students
WHERE city = 'Pune' OR score > 90;         :contentReference[oaicite:2]{index=2}

-- 8c) NOT to negate a condition
SELECT * FROM students
WHERE NOT city = 'Mumbai';                 :contentReference[oaicite:3]{index=3}

-- 8d) Combining AND, OR, NOT with parentheses
SELECT * FROM students
WHERE (grade = 'A' OR grade = 'B')
  AND NOT (city = 'Navi Mumbai');          :contentReference[oaicite:4]{index=4}

-- 9. Example of excluding a range with NOT BETWEEN
SELECT * FROM students
WHERE score NOT BETWEEN 70 AND 90;          :contentReference[oaicite:5]{index=5}

-- 10. Set operator: UNION combines two queries
SELECT id, name, city FROM students WHERE grade = 'A'
UNION
SELECT id, name, city FROM students WHERE city = 'Pune';  :contentReference[oaicite:6]{index=6}

-- 11. Using XOR logic via OR + NOT AND (since SQL doesn’t support XOR)
-- e.g., students older than 20 or with score > 90, but not both
SELECT * FROM students
WHERE (age > 20 OR score > 90)
  AND NOT (age > 20 AND score > 90);        :contentReference[oaicite:7]{index=7}
