-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/7hPtMz
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- DROP DATABASE IF EXISTS Employees_db;
-- CREATE DATABASE Employees_db;
-- USE Employees_db;

-- create table titles

DROP TABLE IF EXISTS titles CASCADE;

CREATE TABLE "titles" (
    "title_id" varchar(5)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

-- create table departments

DROP TABLE IF EXISTS departments CASCADE;

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- create table employees

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title" varchar(5)   NOT NULL,
    "birth_day" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

-- create table salaries

DROP TABLE IF EXISTS salaries;

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

-- create table dept_emp

DROP TABLE IF EXISTS dept_emp;

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    "concat_no" varchar(11)   NOT NULL
);

-- create table dept_manager;

DROP TABLE IF EXISTS dept_manager;
 
CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    "concat_no" varchar(11)   NOT NULL
);

-- setting up relation between tables by assigning primary keys and 
-- foreign keys to apropriate tables

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

-------- import data into tables ------

-- import data from titles.csv file

COPY titles(title_id, title)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\titles.csv'
DELIMITER ','
CSV HEADER;

-- import data from department.csv file

COPY departments(dept_no, dept_name)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\departments.csv'
DELIMITER ','
CSV HEADER;

-- import data from employees.csv file

COPY employees(emp_no, emp_title, birth_day,
		first_name, last_name,
		sex, hire_date)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\employees.csv'
DELIMITER ','
CSV HEADER;

-- import data from salaries.csv file

COPY salaries(emp_no, salary)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\salaries.csv'
DELIMITER ','
CSV HEADER;

-- import data from dept_emp.csv file

COPY dept_emp(emp_no, dept_no)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- import data from dept_manager.csv file

COPY dept_manager(dept_no, emp_no)
FROM 'C:\Users\home\Documents\Monu-Hw [KD]\sql-challenge\EmployeeSQL\data\dept_manager.csv'
DELIMITER ','
CSV HEADER;

-- Adding composite keys to dept_manager & dept_emp table

ALTER TABLE dept_manager
ADD concat_no varchar(11);

UPDATE dept_manager
SET concat_no = CONCAT (dept_no, '_', emp_no);

ALTER TABLE dept_emp
ADD concat_no varchar(11);

UPDATE dept_emp
SET concat_no = CONCAT (dept_no, '_', emp_no);
