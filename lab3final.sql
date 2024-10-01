CREATE DATABASE lab3;  -- task1

select lastname     -- task3
from employees;

select distinct lastname     -- task4
from employees;

select * from employees where lastname = 'Smith';    -- task5

select * from employees where lastname in ('Smith', 'Doe');    -- task6

select * from employees where department = 14;    -- task7

select * from employees where department in (37, 77);      -- task8

select sum(budget) as total_budget          -- task9
from departments;

select department, count(*) as employee_count     -- task10
from employees
group by department;

select department, count(*) as employee_count        -- task11
from employees
group by department
having count(*) > 2;

select name                                         -- task12
from departments
where budget= (
    select max(budget)
    from departments
    where budget < (select max(budget) from departments)
    );

select employees.name, employees.lastname      -- task13
from employees
where employees.department = (
    select departments.code
    from departments
    where departments.budget = (select min(budget) from departments)
    );

select name                                 -- task14
from (
    select name, city
    from employees
    union all
    select name,city
    from customers
     ) as all_people
where city = 'Almaty';

select budget, code                             -- task15
from departments
where budget > 60000
order by budget asc, code desc;

select budget * 0.9                            -- task16
from departments
where budget = (select min(budget) from departments);

update employees                               -- task17
set department = (
    select code
    from departments
    where name = 'IT'
    )
where department = (
    select code
    from departments
    where name = 'Research'
    );


delete from employees                      -- task18
where department = (
        select code
        from departments
        where name = 'IT'
    );

delete from employees;                   -- task19