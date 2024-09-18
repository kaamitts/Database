-- 1. Create database "lab1"
CREATE DATABASE lab2;

-- Switch to the newly created database
\c lab2

-- 2. Create table "users" with fields
CREATE TABLE users (
    id SERIAL PRIMARY KEY,  -- autoincrementing integer
    firstname VARCHAR(50),
        lastname VARCHAR(50)
);

-- 3. Add integer column "isadmin" to "users"
ALTER TABLE users
    ADD COLUMN isadmin INTEGER;

-- 4. Change type of "isadmin" to boolean
ALTER TABLE users
    ALTER COLUMN isadmin TYPE BOOLEAN
        USING isadmin::BOOLEAN;

-- 5. Set default value as false to "isadmin"
ALTER TABLE users
    ALTER COLUMN isadmin SET DEFAULT FALSE;

-- 6. Primary key constraint is already added in step 2 (id is SERIAL PRIMARY KEY)

-- 7. Create table "tasks" with fields
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INTEGER REFERENCES users(id)
);

-- 8. Delete "tasks" table
DROP TABLE tasks;

-- 9. Delete "lab1" database
-- First, switch to another database before dropping "lab1"
\c postgres
DROP DATABASE lab1;