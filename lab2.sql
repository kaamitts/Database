CREATE DATABASE lab2;

CREATE TABLE countries (
       country_id SERIAL PRIMARY KEY,
       country_name VARCHAR(100) NOT NULL,
       region_id INT,
       population INT
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Kazakhstan', 1, 18700000);

INSERT INTO countries (country_id, country_name)
VALUES (2, 'Russia');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Uzbekistan', NULL, 33000000);

INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Germany', 2, 83000000),
    ('USA', 3, 331000000),
    ('Canada', 4, 38000000);

ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population) VALUES (5, 5000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries);

INSERT INTO countries_new SELECT * FROM countries;

UPDATE countries SET region_id = 1 WHERE region_id IS NULL;

SELECT country_name, population * 1.1 AS "New Population" FROM countries;

DELETE FROM countries WHERE population < 100000;

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
    RETURNING *;

DELETE FROM countries RETURNING *;