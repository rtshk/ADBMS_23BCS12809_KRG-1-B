CREATE TABLE department_new (
    dept_id INT PRIMARY KEY,
    dept_title VARCHAR(50)
);

CREATE TABLE staff (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_salary INT,
    dept_ref INT,
    FOREIGN KEY (dept_ref) REFERENCES department_new(dept_id)
);

INSERT INTO department_new VALUES
(1, 'IT'),
(2, 'SALES');

INSERT INTO staff VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'ABC', 90000, 1);

-- i. Query Using Subquery with GROUP BY
SELECT s.emp_id, s.emp_name, d.dept_title, s.emp_salary
FROM department_new AS d
JOIN staff AS s
ON d.dept_id = s.dept_ref
WHERE s.emp_salary IN  
(
    SELECT MAX(emp_salary)
    FROM staff
    GROUP BY dept_ref
);

-- ii. Query Using Correlated Subquery
SELECT s.emp_id, s.emp_name, d.dept_title, s.emp_salary
FROM department_new AS d
JOIN staff AS s
ON d.dept_id = s.dept_ref
WHERE s.emp_salary =  
(
    SELECT MAX(s2.emp_salary)
    FROM staff AS s2
    WHERE s2.dept_ref = s.dept_ref
);

CREATE TABLE A( 
EmpID int primary key, 
Ename varchar(50), 
Salary int 
); 
 
CREATE TABLE B( 
EmpID int primary key, 
Ename varchar(50), 
Salary int 
); 
 
INSERT INTO A VALUES 
(1,'AA',1000), 
(2,'BB',300); 
 
INSERT INTO B VALUES 
(2,'BB',400), (3,'CC',100); 
 
 
SELECT EmpID, Ename, min(Salary) as Min_Salary 
FROM 
(SELECT* FROM A 
UNION 
SELECT* FROM B) AS X 
GROUP BY EmpID, Ename;   