create database lab4;              --task1

create table Warehouses(                --task2
    code serial primary key,
    location varchar(255),
    capacity int
);

create table  Boxes(
    code char(4),
    contents varchar(255),
    value real,
    warehouse int
);

insert into Warehouses(location, capacity) values('Chicago', 3);    --task3
insert into Warehouses(location, capacity) values('Chicago', 4);
insert into Warehouses(location, capacity) values('New_York', 7);
insert into Warehouses(location, capacity) values('Los_Angelos', 2);
insert into Warehouses(location, capacity) values('San_Francisco', 8);

insert into Boxes(code, contents, value, warehouse) values('OMN7', 'Rocks', 180, 3);
insert into Boxes(code, contents, value, warehouse) values('4H8P', 'Rocks', 250, 1);
insert into Boxes(code, contents, value, warehouse) values('4RT3', 'Scissors', 190, 4);
insert into Boxes(code, contents, value, warehouse) values('7G3H', 'Rocks', 200, 1);
insert into Boxes(code, contents, value, warehouse) values('8JN6', 'Papers', 75, 1);
insert into Boxes(code, contents, value, warehouse) values('8Y6U', 'Papers', 50, 3);
insert into Boxes(code, contents, value, warehouse) values('9J6F', 'Papers', 175, 2);
insert into Boxes(code, contents, value, warehouse) values('LL08', 'Rocks', 140, 4);
insert into Boxes(code, contents, value, warehouse) values('P0H6', 'Scissors', 125, 1);
insert into Boxes(code, contents, value, warehouse) values('P2T6', 'Scissors', 150, 2);
insert into Boxes(code, contents, value, warehouse) values('TU55', 'Papers', 90, 5);


select * from warehouses;    --task4

select *             --task5
from boxes
where value > 150;

select distinct contents        --task6
from boxes;

select warehouses.code, count(boxes.code) as box_count            --task7
from warehouses
    left join boxes on warehouses.code = boxes.warehouse
group by warehouses.code
order by warehouses.code asc;

select warehouses.code, count(boxes.code) as box_count            --task8
from warehouses
left join boxes on warehouses.code = boxes.warehouse
group by warehouses.code
having count(boxes.code) > 2
order by warehouses.code asc;

insert into Warehouses(location, capacity) values('New_York', 3);    --task9

insert into boxes(code, contents, value, warehouse) values('H5RT', 'Papers', 200, 2);  --task10

update boxes                --task11
set value = value * 0.85
where code = (
    select code
    from boxes
    order by value desc
    limit 1 offset 2
    );

delete from boxes              --task12
where value < 150;

delete from boxes              --task13
where warehouse in (
    select code
    from warehouses
    where location = 'New_York'
    )
returning *;