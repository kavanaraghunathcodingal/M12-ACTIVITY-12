-- Example: create a table named "employees"
CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    -- Unique ID for each employee
    first_name VARCHAR(50) NOT NULL,
    -- Employee first name
    last_name VARCHAR(50) NOT NULL,
    -- Employee last name
    email VARCHAR(100) UNIQUE NOT NULL,
    -- Unique email address
    hire_date DATE NOT NULL,
    -- Date the employee was hired
    job_title VARCHAR(100) NOT NULL,
    -- Job title
    salary DECIMAL(10, 2) CHECK (salary >= 0),
    department_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Optional: add a foreign key constraint to departments table
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);
