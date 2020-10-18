-------------------------------------------------
-----------------Data Analysis-------------------
-------------------------------------------------

-- 1. List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.

SELECT 	em.emp_no "Employee Number", 
		em.last_name "Last Name", 
		em.first_name "First Name", 
		em.sex "Sex", 
		sa.salary::money "Salary"
FROM employees em
JOIN salaries sa ON
	 em.emp_no = sa.emp_no;

-- 2. List first name, last name, and hire date for 
-- employees who were hired in 1986.

SELECT first_name "First Name", last_name "Last Name", 
		hire_date "Hire Date"
FROM employees
WHERE 
	EXTRACT(YEAR FROM hire_date) = '1986';

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name.

SELECT 	de.dept_no "Department Number", 
		de.dept_name "Department Number",
		dm.emp_no "Manager Employee Number", 
		em.last_name "Last Name", 
		em.first_name "First Name"
FROM dept_manager dm
JOIN departments de ON
		dm.dept_no = de.dept_no
JOIN employees em ON
		dm.emp_no = em.emp_no;

-- 4. List the department of each employee with the 
-- following information: employee number, last name, 
-- first name, and department name.
SELECT 	em.emp_no "Employee Number",
		em.last_name "Last Name",
		em.first_name, 
		de.dept_name
FROM departments de
JOIN dept_emp dp ON
		de.dept_no = dp.dept_no
JOIN employees em ON
		dp.emp_no = em.emp_no;

-- 5. List first name, last name, and sex for 
-- employees whose first name is "Hercules" 
-- and last names begin with "B."

SELECT 	first_name "First Name",
		last_name "Last Name",
		sex "Sex"
FROM employees
WHERE 
	first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, 
-- including their employee number, last name, 
-- first name, and department name.

SELECT 	em.emp_no "Employee Number", 
		em.last_name "Last Name", 
		em.first_name "First Name", 
		de.dept_name "Department Name"
FROM employees em
JOIN dept_emp dp ON
		em.emp_no = dp.emp_no
JOIN departments de ON
		dp.dept_no = de.dept_no 
	WHERE 	1=1
			AND de.dept_name = 'Sales';

-- 7. List all employees in the Sales and 
-- Development departments, including their 
-- employee number, last name, first name, 
-- and department name.

SELECT 	em.emp_no "Employee Number", 
		em.last_name "Last Name", 
		em.first_name "First Name", 
		de.dept_name "Department Name"
FROM employees em
JOIN dept_emp dp ON
		em.emp_no = dp.emp_no
JOIN departments de ON
		dp.dept_no = de.dept_no
	WHERE 	1=1
			AND de.dept_name = 'Sales'
			OR de.dept_name = 'Development';

-- 8. In descending order, list the frequency 
-- count of employee last names, i.e., how many 
-- employees share each last name.

SELECT last_name "Last Name", COUNT(last_name) "Counts"
FROM employees
GROUP BY last_name
ORDER BY "Counts" DESC;

-- In descending order, list the frequency 
-- count of employee first names, i.e., how many 
-- employees share each first name.

SELECT first_name "First Name", COUNT(first_name) "Counts"
FROM employees
GROUP BY first_name
ORDER BY "Counts" DESC;

-- -- In descending order, list the frequency 
-- count of employee birth day, i.e., how many 
-- employees have the same birth day.

SELECT birth_day "Birth Day", COUNT(birth_day) "Counts"
FROM employees
GROUP BY birth_day
ORDER BY "Counts" DESC;

-- In descending order, list the frequency 
-- count of employee hire date, i.e., how many 
-- employees have been hired on same date.

SELECT hire_date "Hire Date", COUNT(hire_date) "Counts"
FROM employees
GROUP BY hire_date
ORDER BY "Counts" DESC;

-- -- In descending order, list the frequency 
-- count of employee's title, i.e., how many 
-- employees currently hold same title.

SELECT 	ti.title "Title", 
		COUNT(em.emp_title) "Counts"
FROM employees em
JOIN titles ti ON
		ti.title_id = em.emp_title
GROUP BY
 		em.emp_title,
		ti.title
ORDER BY "Counts";

-- find out employee, whose ID number is 499942
SELECT 	emp_no "Employee Number",
		first_name "First Name",
		last_name	"Last Name"
FROM employees
WHERE 	1=1
		AND emp_no = '499942'



