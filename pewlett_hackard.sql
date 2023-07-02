-- List the employee number, last name, first name, sex, 
-- and salary of each employee (2 points)

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s
ON (e.emp_no = s.emp_no)
ORDER BY e.emp_no;

-- List the first name, last name, and hire date for
-- the employees who were hired in 1986 (2 points)

SELECT first_name, last_name, hire_date 
FROM employees 
WHERE EXTRACT (YEAR FROM hire_date) = 1986;

-- List the manager of each department along
-- with their department number, department name, employee number, 
-- last name, and first name (2 points)

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, d.dept_name
FROM employees AS e
JOIN dept_manager AS m
ON (e.emp_no = m.emp_no)
JOIN departments AS d
ON (m.dept_no = d.dept_no) 
WHERE e.emp_title_id IN
	(SELECT title_id
	FROM titles 
	WHERE title = 'Manager')
ORDER BY dept_name;

-- List the department number for each employee along with 
-- that employee’s employee number, last name, first name, 
-- and department name (2 points)

SELECT dm.dept_no, e.emp_no, e.first_name, e.last_name, dm.dept_name
FROM employees as e 
JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
JOIN departments as dm
ON (d.dept_no = dm.dept_no);

-- List first name, last name, and sex of each employee whose 
-- first name is Hercules and whose last name begins with the
-- letter B (2 points)

SELECT first_name, last_name, sex 
FROM employees 
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%'

-- List each employee in the Sales department, 
-- including their employee number, last name, and 
-- first name (2 points)

SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
(
	SELECT emp_no
    FROM dept_emp
    WHERE dept_no IN
      (
		  SELECT dept_no
		  FROM departments
		  WHERE dept_name = 'Sales'
	)
);

-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and 
-- department name (4 points)

SELECT e.emp_no, e.last_name, e.first_name, dm.dept_name
FROM employees as e
JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
JOIN departments as dm
ON (d.dept_no = dm.dept_no)
WHERE dept_name IN ('Sales', 'Development')
ORDER BY dm.dept_name;

-- List the frequency counts, in descending order, 
-- of all the employee last names (that is, how many
-- employees share each last name) (4 points)

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
