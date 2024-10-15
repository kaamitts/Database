create database  lab5;

create table customers(
    customers_id   int,
    customers_name varchar(100),
    city           varchar(50),
    grade          int,
    salesman_id    int
);

create table orders(
    order_no int,
    purch_atm float,
    order_date varchar(20),
    customer_id int,
    salesman_id int
);

create table salesmen(
    salesman_id int,
    name varchar(100),
    city varchar(50),
    commission float
);

insert into customers (customers_id, customers_name, city, grade, salesman_id) VALUES
     (3002, 'Nick Rimando', 'New York', 100, 5001),
     (3005, 'Graham Zusi', 'California', 200, 5002),
     (3001, 'Brad Guzan', 'London', 100, 5005),
     (3004, 'Fabian Johns', 'Paris', 300, 5006),
     (3007, 'Brad Davis', 'New York', 200, 5001),
     (3009, 'Geoff Camero', 'Berlin', 100, 5003),
     (3008, 'Julian Green', 'London', 300, 5002);
insert into orders (order_no, purch_atm, order_date, customer_id, salesman_id) VALUES
       (70001, 150.50, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.50, '2012-08-17', 3009, 5003),
       (70007, 948.50, '2012-09-10', 3005, 5002),
       (70005, 2400.60, '2012-07-27', 3007, 5001),
       (70008, 5760.00, '2012-09-10', 3002, 5001);
insert into salesmen (salesman_id, name, city, commission) VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', 'London', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

select sum(purch_atm) as total      --task3
from orders;

select avg(purch_atm) as average    --task4
from orders;

select count(customers_name)        --task5
from customers
where customers_name is not null;

select min(purch_atm) as min        --task6
from orders;

select *                            --task7
from customers
where customers_name like '%b';

select *                           --task8
from orders
where customer_id in(
    select customers_id
    from customers
    where city = 'New York'
    );

select *                            --task9
from customers
where customers_id in (
    select customer_id
    from orders
    where purch_atm > 10
    );

select sum(grade) as total          --task10
from customers;

select *                            --task11
from customers
where customers_name is not null;

select max(grade) as max_grade      --task12
from customers;