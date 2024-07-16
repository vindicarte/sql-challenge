--Create Tables for CSV

CREATE TABLE departments (
    dept_no varchar Primary Key  NOT NULL,
    dept_name varchar  NOT NULL
);


CREATE TABLE titles (
    title_id varchar Primary Key  NOT NULL,
    title varchar   NOT NULL
);

CREATE TABLE employees (
    emp_no int Primary Key  NOT NULL,
    emp_title_id varchar NOT NULL,
	Foreign Key (emp_title_id) references titles(title_id),
    birth_date varchar   NOT NULL,
    first_name varchar   NOT NULL,
    last_name varchar   NOT NULL,
    sex varchar   NOT NULL,
    hire_date varchar   NOT NULL
);

CREATE TABLE dept_emp (
    emp_no int NOT NULL,
	Foreign Key (emp_no) references employees(emp_no),
	dept_no varchar NOT NULL,
    Foreign Key (dept_no) references departments(dept_no),
	Primary Key (emp_no, dept_no)
	);


CREATE TABLE dept_manager (
    dept_no varchar NOT NULL,
	Foreign Key (dept_no) references departments(dept_no),
    emp_no int NOT NULL,
	Foreign Key (emp_no) references employees(emp_no),
	Primary Key (dept_no, emp_no)
);


CREATE TABLE salaries (
    emp_no int NOT NULL,
	Foreign Key (emp_no) references employees(emp_no),
    salary int   NOT NULL,
	Primary Key (emp_no)
);



-- 1. List the employee number, last name, first name, sex, and salary of each employee
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986

select e.first_name, e.last_name, e.hire_date
from employees as e
where hire_date like '%1986';

-- 3. List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.

select e.emp_no, e.last_name, e.first_name, m.dept_no, n.dept_name
from employees as e
inner join dept_manager as m on e.emp_no = m.emp_no
inner join departments as n on m.dept_no = n.dept_no;

-- 4. List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name.

select d.dept_no, e.emp_no, e.last_name, e.first_name, n.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments as n on d.dept_no = n.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name 
-- is Hercules and whose last name begins with the letter B.

select e.first_name, e.last_name, e.sex from employees as e
where e.first_name = 'Hercules' and e.last_name like 'B%';

-- 6. List each employee in the Sales department, including their 
-- employee number, last name, and first name.

select e.emp_no, e.last_name, e.first_name, n.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments as n on d.dept_no = n.dept_no
where n.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, n.dept_name
from employees as e
inner join dept_emp as d on e.emp_no = d.emp_no
inner join departments as n on d.dept_no = n.dept_no
where n.dept_name = 'Sales' or n.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).

select last_name, count(last_name) as "count"
	from employees
	group by last_name
	order by "count" desc;


