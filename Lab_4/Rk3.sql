create table if not exists workers (
	id serial not null primary key,
	name varchar(50) not null,
	birthdate date,
	unit varchar(15)
);

insert into workers(name, birthdate, unit)
values ('Иванов Иван Иванович', '25-09-1990', 'ИТ');

insert into workers(name, birthdate, unit)
values ('Петров Петр Петрович', '12-11-1987', 'Бухгалтерия');

insert into workers(name, birthdate, unit)
values ('Иванов Сергей Михалич', '25-09-1989', 'ИТ');

insert into workers(name, birthdate, unit)
values ('Леонтьев Павел Юрьевич', '25-09-1999', 'ИТ');


create table if not exists register (
	id_worker int references workers(id) not null,
	wdatea date,
	weekday varchar(15),
	wtime time,
	inout int
);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '21-12-2019', 'Суббота', '9:01', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '22-12-2020', 'Суббота', '9:20', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '22-12-2020', 'Суббота', '9:40', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(2, '14-12-2020', 'Суббота', '17:00', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(2, '14-12-2020', 'Суббота', '13:00', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(2, '14-12-2020', 'Суббота', '11:00', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(2, '14-12-2020', 'Суббота', '10:00', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '21-12-2020', 'Суббота', '15:00', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '21-12-2020', 'Суббота', '9:19', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(1, '21-12-2020', 'Суббота', '9:11', 2);


insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '21-12-2020', 'Суббота', '9:11', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '21-12-2020', 'Суббота', '9:15', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '28-12-2020', 'Суббота', '9:10', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '28-12-2020', 'Суббота', '9:15', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '14-12-2020', 'Суббота', '9:10', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(3, '14-12-2020', 'Суббота', '9:17', 2);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(4, '14-12-2020', 'Суббота', '10:10', 1);

insert into register(id_worker, wdatea, weekday, wtime, inout)
values(4, '14-12-2020', 'Суббота', '17:10', 2);



create or replace function getage(bthd date) returns integer as
$$
	select extract (year from current_date) - extract (year from bthd) 
$$ language sql;

create or replace function getInfo() returns integer
as
$$
select count (*)
    from ( select id_worker, count(inout) as qty from (
        select * from register as reg join (
            select id from workers
            where getage(workers.birthdate) > 17 and getage(workers.birthdate) < 41
        ) lvl1
        on reg.id_worker = lvl1.ID
        where reg.inout = 2
    ) lvl2
    group by id_worker
    ) lvl3
    where qty > 3 );
$$ language sql;

select getInfo();