create database lab7;    --task1

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


CREATE INDEX idx_employees_first_name ON employees (first_name); -- task1
SELECT * FROM employees WHERE first_name = 'abc';

CREATE INDEX idx_employees_name_surname ON employees (first_name, last_name); --task2
SELECT * FROM employees WHERE first_name = 'as' AND last_name = 'Ata';

CREATE UNIQUE INDEX idx_employees_salary ON employees (salary); --task3
SELECT * FROM employees WHERE salary < 100000 AND salary > 75000;

CREATE INDEX idx_employees_first_name_substring ON employees (first_name); --task4
SELECT * FROM employees WHERE substring(first_name from 1 for 4) = 'bcd';

CREATE INDEX idx_employees_department_id ON employees (department_id);      --task5
CREATE INDEX idx_departments_department_id ON departments (department_id);
CREATE INDEX idx_employees_salary_new ON employees (salary);
CREATE INDEX idx_departments_budget ON departments (budget);
SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id WHERE
    d.budget > 100000 AND e.salary < 25000;