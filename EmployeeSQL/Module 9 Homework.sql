--Create tables and import data--
CREATE TABLE titles (
    title_id varchar(25) NOT NULL PRIMARY KEY,
    title varchar(25) NOT NULL
);
SELECT * FROM titles; 

CREATE TABLE employees (
    emp_no integer NOT NULL PRIMARY KEY,
    emp_title_id varchar(25) NOT NULL,
    birth_date date,
    first_name varchar(25) NOT NULL,
    last_name varchar(25) NOT NULL,
    sex varchar(10),
    hire_date date NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
SELECT * FROM employees; 

CREATE TABLE salaries (
    emp_no integer NOT NULL,
    salary integer NOT NULL,
	PRIMARY KEY (emp_no, salary),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries;

CREATE TABLE departments (
    dept_no varchar(20) NOT NULL PRIMARY KEY,
    dept_name varchar(20) NOT NULL
);
SELECT * FROM departments;

CREATE TABLE dept_Manager (
    dept_no varchar(20) NOT NULL,
    emp_no integer NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM dept_Manager;

CREATE TABLE dept_Emp (
    emp_no integer NOT NULL,
	dept_no varchar(20) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM dept_Emp;

--Data Analysis--

--Analysis 1--
SELECT e.emp_no, e.first_name,e.last_name, e.sex, s.salary
FROM employees as e
JOIN salaries as s ON e.emp_no = s.emp_no; 

--Analysis 2--
SELECT e.first_name,e.last_name, e.hire_date
FROM employees as e
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--Analysis 3--
SELECT e.first_name, e.last_name, man.emp_no, d.dept_name, man.dept_no
FROM dept_Manager as man
JOIN employees as e ON e.emp_no = man.emp_no
JOIN departments as d ON d.dept_no = man.dept_no; 

--Analysis 4--
SELECT e.first_name, e.last_name, d.dept_name, de.emp_no, de.dept_no
FROM employees as e
JOIN dept_Emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON d.dept_no = de.dept_no; 

--Analysis 5--
SELECT e.first_name,e.last_name, e.sex
FROM employees as e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Analysis 6--
SELECT e.first_name, e.last_name, de.emp_no
FROM employees as e
JOIN dept_Emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE dept_name = 'Sales'; 

--Analysis 7--
SELECT e.first_name, e.last_name, de.emp_no, d.dept_name
FROM employees as e
JOIN dept_Emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON d.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'; 

--Analysis 8--
SELECT e.last_name, count(e.last_name)
FROM employees as e
GROUP BY e.last_name
ORDER BY count DESC;