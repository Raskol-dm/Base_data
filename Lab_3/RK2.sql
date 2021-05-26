
--Вариант 4
create table if not exists groupp(
	id serial not null primary key,
	name varchar(30) not null,
	teacher varchar(40),
	mx_hour int
);

insert into groupp(name, teacher, mx_hour)
values ('Ocean', 'Maria Huko Viktorovna', 38);

insert into groupp(name, teacher, mx_hour)
values ('Solnashko', 'Yuly Huko Viktorovna', 98);

insert into groupp(name, teacher, mx_hour)
values ('Korablik', 'Perk Huko Viktorovna', 11);

insert into groupp(name, teacher, mx_hour)
values ('Korablik', 'Viktoriy Huko Viktorovna', 31);

insert into groupp(name, teacher, mx_hour)
values ('Futurama', 'Nika Huko Viktorovna', 52);

insert into groupp(name, teacher, mx_hour)
values ('Simpson', 'Tatyna Huko Viktorovna', 44);

insert into groupp(name, teacher, mx_hour)
values ('Futurama', 'Alexsandra Huko Viktorovna', 15);

insert into groupp(name, teacher, mx_hour)
values ('Sourth_Park', 'Rita Huko Viktorovna', 78);

insert into groupp(name, teacher, mx_hour)
values ('American', 'Lola Huko Viktorovna', 65);

insert into groupp(name, teacher, mx_hour)
values ('2X2', 'Zuva Huko Viktorovna', 24);

insert into groupp(name, teacher, mx_hour)
values ('Naludy', 'Maria Huko Viktorovna', 16);

create table if not exists children(
	id serial not null primary key,
	name varchar(30) not null,
	birthday DATE,
	sex varchar(10),
    adres varchar(15),
    kafedra VARCHAR (15)
);

insert into children(name, birthday, sex, adres, kafedra)
values ('Pety', '2005-11-03','male', 'Pushkina 7', 'Boys');

insert into children(name, birthday, sex, adres, kafedra)
values ('Masha', '2006-11-03','female', 'Tolstoy 7', 'IT');

insert into children(name, birthday, sex, adres, kafedra)
values ('Dima', '2005-11-13','male', 'Severnay 74', 'FB');

insert into children(name, birthday, sex, adres, kafedra)
values ('Yuly', '2005-12-03','female', 'Moroz 32', 'IT');

insert into children(name, birthday, sex, adres, kafedra)
values ('Sasha', '2007-11-03','female', 'Polyna 1', 'DR');

insert into children(name, birthday, sex, adres, kafedra)
values ('Rita', '2004-11-23','female', 'Kilometr 34', 'BMW');

insert into children(name, birthday, sex, adres, kafedra)
values ('Pety', '2005-01-03','male', 'Putilkovo 65', 'OP');

insert into children(name, birthday, sex, adres, kafedra)
values ('Koly', '2005-07-13','male', 'Lubanka 21', 'IT');

insert into children(name, birthday, sex, adres, kafedra)
values ('Egor', '2005-11-15','male', 'London 4B', 'BMW');

insert into children(name, birthday, sex, adres, kafedra)
values ('Vasiy', '2005-04-24','male', 'Upiter 75', 'Girl');


create table if not exists parents(
	id serial not null primary key,
	name varchar(30) not null,
    age int,
	positions varchar(30),
);

insert into parents(name, age, positions)
values ('Olga Ven Disel', 45, 'mama');

insert into parents(name, age, positions)
values ('Yra Ven Disel', 33, 'papa');

insert into parents(name, age, positions)
values ('Masha Ven Disel', 27, 'mama');

insert into parents(name, age, positions)
values ('Oleg Ven Disel', 53, 'papa');

insert into parents(name, age, positions)
values ('Koly Ven Disel', 36, 'papa');

insert into parents(name, age, positions)
values ('Vika Ven Disel', 36, 'mama');

insert into parents(name, age, positions)
values ('Sasha Ven Disel', 33, 'mama');

insert into parents(name, age, positions)
values ('Pety Ven Disel', 34, 'papa');

insert into parents(name, age, positions)
values ('Dima Ven Disel', 19, 'papa');

insert into parents(name, age, positions)
values ('Katy Ven Disel', 21, 'mama');


create table if not exists group_child(
	id_group int references groupp(id) not null,
	id_children int references children(id) not null UNIQUE
);

insert into group_child(id_group, id_children)
values (1, 7);

insert into group_child(id_group, id_children)
values (2, 8);

insert into group_child(id_group, id_children)
values (3, 4);

insert into group_child(id_group, id_children)
values (6, 2);

insert into group_child(id_group, id_children)
values (7, 1);

insert into group_child(id_group, id_children)
values (1, 3);

insert into group_child(id_group, id_children)
values (2, 9);

insert into group_child(id_group, id_children)
values (1, 10);

create table if not exists child_parent(
	id_parents int references parents(id) not null,
	id_children int references children(id) not null 
);

insert into child_parent(id_parents, id_children)
values (1, 7);

insert into child_parent(id_parents, id_children)
values (2, 7);

insert into child_parent(id_parents, id_children)
values (3, 4);

insert into child_parent(id_parents, id_children)
values (6, 2);

insert into child_parent(id_parents, id_children)
values (7, 1);

insert into child_parent(id_parents, id_children)
values (9, 1);

insert into child_parent(id_parents, id_children)
values (4, 7);

insert into child_parent(id_parents, id_children)
values (1, 10);

------------------------------------
--1) Инструкция SELECT, использующая поисковое выражение CASE 
--Определить к какой группе относится возраст родителя ребёнка, обучающегося на кафедре
select parents.name, age, children.kafedra,
    case
        when ( age > 18 and age <= 28) then 'Young Parent'
        when ( age > 28 and age <= 36 ) then 'Middle Parent'
        else 'Alder Parent'
    end
from
    parents
    join child_parent on parents.id = child_parent.id_parents
    join children on children.id = child_parent.id_children

--2) Инструкция UPDATE со скалярным подзапросом в предложении SET
-- Обновить у всех групп макс часы в соответсвии со средним значением * 1.5 
--среди детей в кафедре"IT"

update groupp
set mx_hour = ( select avg(mx_hour) * 1.5
from groupp
join group_child on groupp.id = group_child.id_group
join children on children.id = group_child.id_children
where (children.kafedra = 'IT'))

--3) Инструкцию SELECT, консолидирующую данные с помощью
--предложения GROUP BY и предложения HAVING 
-- вывести учителей, которые обучают более одного ребёнка
select group_child.id_group,groupp.teacher, count(*) as col_child
from group_child
join groupp on groupp.id = group_child.id_group
group by group_child.id_group,groupp.teacher
having count(*) > 1;

--Создать хранимую процедуру без параметров, которая осуществляет поиск
--ключевого слова 'EXEC' в тексте хранимых процедур в текущей базе
--данных. Хранимая процедура выводит инструкцию 'EXEC', которая
--выполняет хранимую процедуру или скалярную пользовательскую
--функцию. Созданную хранимую процедуру протестировать. 

create or replace procedure show_procedureEx() as
$$
declare 
	cur cursor
	for select proname, proargtypes
	from (
		select proname, pronargs, prorettype, proargtypes
		from pg_proc
		where proname = 'Exec'
	) AS tmp;
	row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		raise notice '{Proc_name : %} {args : %}', row.proname, row.proargtypes;
	end loop;
	close cur;
end
$$ language plpgsql;
call show_procedureEx();
-------------------------------------------------------------------------------------