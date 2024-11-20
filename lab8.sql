create database lab8;   --task1

create table salesman(                          --task2
    salesman_id serial primary key,
    name varchar(50),
    city varchar(50),
    commission float
);

create table customers(
    customer_id serial primary key,
    cust_name varchar(50),
    city varchar(50),
    grade int,
    salesman_id int references salesman(salesman_id)
);

CREATE TABLE orders (
    ord_no int primary key,
    purch_amt numeric(10, 2),
    ord_date date,
    customer_id int references customers(customer_id),
    salesman_id int references salesman(salesman_id)
);

INSERT INTO salesman (salesman_id, name, city, commission) VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', 'New York', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', 200, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);


--task3
create role junior_dev with login password 'password123';

--task4
create view new_york_salesmen as
select *
from salesman
where city ='New York';

-- Task 5
CREATE VIEW order_details AS
SELECT o.ord_no, o.purch_amt, o.ord_date, c.cust_name AS customer_name, s.name AS salesman_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN salesman s ON o.salesman_id = s.salesman_id;

GRANT ALL PRIVILEGES ON order_details TO junior_dev;

-- Task 6
CREATE VIEW top_customers AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON top_customers TO junior_dev;

-- Task 7
CREATE VIEW salesman_count_per_city AS
SELECT city, COUNT(*) AS total_salesmen
FROM salesman
GROUP BY city;

-- Task 8
CREATE VIEW salesmen_with_multiple_customers AS
SELECT s.salesman_id, s.name, COUNT(c.customer_id) AS total_customers
FROM salesman s
         JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

-- Task 9
CREATE ROLE intern WITH LOGIN PASSWORD 'password123';

GRANT junior_dev TO intern;