create database lab6;    --task1

--task2
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar (12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 1000000
            LOOP
                INSERT INTO locations (street_address, postal_code, city, state_province)
                VALUES (
                           'Street ' || i,  -- Генерация случайного адреса
                           substr(md5(random()::text), 1, 10) || (floor(random() * 100)::TEXT),  -- Случайный почтовый индекс (до 12 символов)
                           'City ' || (floor(random() * 100)::TEXT),  -- Генерация случайного города
                           'State ' || (floor(random() * 50)::TEXT)  -- Генерация случайной провинции
                       );
                i := i + 1;
            END LOOP;
    END
$$;

DO
$$
    DECLARE
        j INTEGER := 0;
    BEGIN
        WHILE j < 10000
            LOOP
                INSERT INTO departments (department_name, budget, location_id)
                VALUES (
                           'Department ' || j,  -- Генерация названия отдела
                           floor(random() * 100000 + 1000)::INTEGER,  -- Случайный бюджет
                           floor(random() * 1000000 + 1)::INT  -- Случайный идентификатор местоположения (предполагая, что вы добавили в locations 1,000,000 записей)
                       );
                j := j + 1;
            END LOOP;
    END
$$;

DO
$$
    DECLARE
        k INTEGER := 0;
    BEGIN
        WHILE k < 1000000
            LOOP
                INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
                VALUES (
                           'FirstName ' || k,  -- Генерация случайного имени
                           'LastName ' || k,   -- Генерация случайной фамилии
                           md5(random()::text) || '@example.com',  -- Случайный email
                           '123-456-7890',  -- Случайный номер телефона
                           floor(random() * 100000 + 30000)::INTEGER,  -- Случайная зарплата
                           floor(random() * 10000 + 1)::INT  -- Случайный идентификатор отдела (предполагая, что вы добавили в departments 10,000 записей)
                       );
                k := k + 1;
            END LOOP;
    END
$$;


explain analyse                                                                              --task3
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;

create index idx_employees_department_id ON employees (department_id);


select e.first_name, e.last_name, e.department_id, d.department_name                          --task4
from employees e
join departments d on e.department_id = d.department_id
where e.department_id in(40,80);

create index employee_department_id_40_80 on employees(department_id)
where department_id IN (40, 80);


select e.first_name, e.last_name, e.department_id, d.department_name, l.city, l.state_province  --task5
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id


select d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count        --task6
from departments d
left join employees e ON d.department_id = e.department_id
group by d.department_id, d.department_name;


select e.first_name, e.last_name, e.department_id, d.department_name                     --task7
from employees e
left join departments d ON e.department_id = d.department_id;