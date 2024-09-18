CREATE database lab1; --task 1

create table users
(
    id serial,
    firstname VARCHAR(50),      --task2
    lastname VARCHAR(50)
);

alter table users
    add column isadmin int; --task 3

alter table users
    alter column isadmin TYPE boolean USING isadmin::boolean; --task 4

alter table users
    alter column isadmin set default false; --task 5

alter table users
    add primary key(id); --task 6

create table tasks
(
    id serial,
    name VARCHAR(50),   --task 7
    user_id int
);

drop table tasks; --task 8

drop database lab1 --task 9
