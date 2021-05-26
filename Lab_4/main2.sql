--- вариант 2 Савинов Егор ИУ7-54Б

drop table timeT;
drop table employee;

create table employee
(
    id serial not null primary key,
    name varchar(256),
    hd varchar(256),
    department varchar(256)
)

insert into employee(id, name, bd, department)
values (1, 'Иванов Иван Иванович', '25-09-1990', 'ИТ');

insert into employee(id, name, bd, department)
values (2, 'Петров Петр Петрович', '12-11-1987', 'Бухгалтерия');

create table timeT
(
    id int references employee(id) not  null,
    dataS date,
    week varchar(256),
    timeS time,
    type int
)

insert into timeT(id, dataS, week, timeS, type)
values (1, '14-12-2018', 'Суббота', '9:00', 1);

insert into timeT(id, dataS, week, timeS, type)
values (1, '14-12-2018', 'Суббота', '9:20', 2);

insert into timeT(id, dataS, week, timeS, type)
values (1, '14-12-2018', 'Суббота', '9:25', 1);

insert into timeT(id, dataS, week, timeS, type)
values (2, '14-12-2018', 'Суббота', '9:05', 1);

create or replace function get_stat(data)
returns table
(
    delay int,
    count_person int
)
as
$$
    select (timeT.timeS - '9:00'), count(id),
    from employee emp join timeT tt on emp.id = tt.id
    where timeT.time = $1 and timeT.type = 1
$$ language sql;

select * from get_stat('14-12-2018');
