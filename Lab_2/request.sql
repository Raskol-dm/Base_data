SELECT boksers.name as SportsName, clubs.name as ClubName, sponsors.company as SponsorName, transfers.position
FROM transfers, boksers, clubs, sponsors
WHERE transfers.bokser = boksers.id AND transfers.club = clubs.id and transfers.sponsor = sponsors.id;

--1 запрос
select company, name
from sponsors
    join transfers on sponsors.id = transfers.sponsor
    join boksers on transfers.bokser = boksers.id
where age > 20



--2 запрос
select boksers.name as SportsName, boksers.age as
SportsAge
from boksers
where age between 25 and 45


--3 запрос
select company, name
from sponsors
    join transfers on sponsors.id = transfers.sponsor
    join boksers on transfers.bokser = boksers.id
where boksers.name Like 'A%'

--4 запрос
select company, name, rating
from sponsors
    join transfers on sponsors.id = transfers.sponsor
    join boksers on transfers.bokser = boksers.id
where (name in ( select boksers.name
    from boksers
    where name like 'M%') and boksers.arm in ('left'))

--5 запрос
select company, name, age , budget
from sponsors
    join transfers on sponsors.id = transfers.sponsor
    join boksers on transfers.bokser = boksers.id
where age > 32 and exists (
	select age
from sponsors
    join boksers on sponsors.id = boksers.id
where arm = 'left' and budget > 5000
	)

--6 запрос

select company, name, rating, position
from sponsors
    join transfers on sponsors.id = transfers.sponsor
    join boksers on transfers.bokser = boksers.id
where (rating) > all
( select rating
from boksers
    join transfers on transfers.bokser = boksers.id
where ( position in ('KARATE','ARB') and (rating < 35))
)

--7 запрос

select
    cast(avg(rating) as numeric(7,3)),
    count(age) as Allcount_Sportsmen,
    sum(age) as TotalSum,
    cast(avg(age) as numeric(6,2)) as Milfs,
    MAX(age) as Adult_Sport

from
    boksers

--8 запрос
select name, company, position,
    ( select avg(age)
    from boksers
    where rating > 45) as MidleTopAges,
    ( select max(budget)
    from sponsors
    where clientsqty > 5 ) as MaxBudget
from
    boksers
    join transfers on boksers.id = transfers.bokser
    join sponsors on transfers.sponsor = sponsors.id
where position in ('KARATE','ARB')

--9 запрос

select name, position, age,
    case
        when ( age > 15 and age <= 25) then 'Young Sportsmen'
        when ( age > 25 and age <= 33 ) then ' Middle Sportsmen'
        else 'Grandfather'
    end
from
    boksers
    join transfers on boksers.id = transfers.bokser

--10 запрос

SELECT DISTINCT name, rating,
    CASE (rating)
 WHEN (SELECT MAX(rating)
    FROM boksers
 ) 
 THEN 'Максимальный рейтинг'
 WHEN (SELECT MIN(rating)
    FROM boksers
 ) 
 THEN 'Минимальный рейтинг'
 ELSE 'Среднячок'
 END
FROM boksers
order by rating;

--11 запрос

select
    sum(trophiesnum) as TotalTroph
into temporary
table GlobalSumTroph
from 
	clubs;

select *
from GlobalSumTroph;

--12 запрос

select boksers.name, boksers.age
from boksers join
    (         select boksers.age
        from boksers
        where age between 16 and 24
        order by age desc
 limit 1 )
 as young on young.age = boksers.age
    union
        select boksers.name, boksers.age
        from boksers join
            (                                                                                                                                                                                                                                                                                                                                                                                                 select age
                from boksers
                where age between 24 and 31
                order by age desc
  limit 1)
  as middleage on middleage.age = boksers.age
            union
                select boksers.name, boksers.age
                from boksers join
                    (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 select age
                        from boksers
                        where age between 31 and 40
                        order by age desc
  limit 1)
  as adults on adults.age = boksers.age
                    union
                        select boksers.name, boksers.age
                        from boksers join
                            ( select age
                            from boksers
                            where age between 40 and 100
                            order by age desc
  limit 1)
  as grandfather on grandfather.age = boksers.age  

--13 запрос

select sponsors.company, sponsors.budget , clientsqty
from sponsors join
                            ( select budget
                            from sponsors
                            where budget / clientsqty <
 ( select min( budget / clientsqty ) as minbc
                            from ( select budget, clientsqty
                                from sponsors
                                where clientsqty between 10 and 30 ) 
  as smth
 )
                            order by budget asc
 ) as other on sponsors.budget = other.budget                          

--14 запрос

select position                        , count(*) as totalCN
from transfers join boksers on boksers.id = transfers.bokser 
        where age >= 25
        group by position
        order by totalcn 

--15 запрос

select position, count(*) as totalCN
from transfers join boksers on boksers.id = transfers.bokser 
where arm = 'left'
group by position
having sum( rating * age ) >  avg(rating * 1000)
order by totalCN

--16 запрос
insert into boksers
    ( id, name, sex, age, arm, rating)
values
    ( 4333, 'khabib nurmagomedov', 'male', 28, 'right', 99);
select *
from boksers
where boksers.name = 'khabib nurmagomedov'


--17 запрос 
insert into 
	boksers
    (id, name, sex, age, arm, rating)
select
    (
			select max(id) + 1
    from boksers
		),
    'Konor Chiken', 'male', 35,
    'left', rt.rating
from
    boksers as rt join clubs on rt.id = clubs.id
where clubs.sportsmennum > 10
limit 1;

--18 запрос

update clubs
set trophiesnum = trophiesnum * 1.0001
where sportsmennum > 10

--19 запрос

update sponsors
set budget = ( select avg(budget*clientsqty) / 100
from sponsors
where (clientsqty > 10 and clientsqty < 25))
where sponsors.id = 21

--20 запрос

delete from boksers
where boksers.name = 'Konor Chiken'

--21 запрос

delete from boksers
where id in
( select boksers.id
from boksers
where (name like 'kha%' and arm = 'right'))

--22 запрос - ищет среднее кол-во спортсменов в клубах

with
    CTE (sportsmennum, num)
    as
    (
        select
            clubs.sportsmennum, count(*)
        from
            clubs
        group by 
			clubs.sportsmennum
    )
select
    cast(avg(num) as numeric (3, 0))
from
    CTE

--23 запрос 

drop table trees;
create table
if not exists trees
(
    children char
(40) not null primary key,
    parent char
(40)
);

insert into 
	trees
    (children, parent)
values
    (
        'Сын',
        'Отец'
);

insert into 
	trees
    (children, parent)
values
    (
        'Отец',
        'Бабушка'
);

insert into 
	trees
    (children, parent)
values
    (
        'Бабушка',
        'Прадедушка'
);

insert into 
	trees
    (children, parent)
values
    (
        'Прадедушка',
        'Прапрадедушка'
);

insert into 
	trees
    (children, parent)
values
    (
        'Прапрадедушка',
        'Прапрапрадедушка'
);

insert into 
	trees
    (children, parent)
values
    (
        'Прапрабабушка',
        'Прапрапрадедушка'
);

insert into 
	trees
    (children, parent)
values
    (
        'Прапрапрадедушка',
        'Обезьяна'
);

insert into 
	trees
    (children, parent)
values
    (
        'Обезьяна',
        null
);

with recursive famtree
( children_nm, parentn_nm)
as
    (
        select
        t.children, t.parent
    from
        trees as t
    where 
		parent is null
union all
    select
        t.children, t.parent
    from
        trees as t join famtree as f on t.parent = f.children_nm
)
select famtree.children_nm, famtree.parentn_nm
from famtree;

--24 запрос

select boksers.name, clubs.name as club,
    min(trophiesnum) over (partition by ts.position) as MinTr,
    cast(avg(sportsmennum) over (partition by ts.position) as numeric(3,0)) as MaxSp,
    position
from boksers join transfers as ts on ts.bokser = boksers.id
    join clubs on clubs.id = ts.club

--25 запрос

select *
from(
	select 
    row_number() over (partition by ts.position) as Rows,
    min(trophiesnum) over (partition by ts.position),
    position
from boksers join transfers as ts on ts.bokser = boksers.id
    join clubs on clubs.id = ts.club
) as kip
	where rows = 1

--Additional task--
CREATE TABLE table1
(
    id integer,
    var1 "char",
    valid_from_dttm date,
    valid_to_dttm date
)

CREATE TABLE table2
(
    id integer,
    var2 "char",
    valid_from_dttm date,
    valid_to_dttm date
)

insert into 
	table1(id,var1, valid_from_dttm, valid_to_dttm)
values
(
    '1',
    'A',
	'2018-09-01',
	'2018-09-15'
);

insert into 
	table1(id,var1, valid_from_dttm, valid_to_dttm)
values
(
    '1',
    'B',
	'2018-09-16',
	'5999-12-31'
);

insert into 
	table2(id,var2, valid_from_dttm, valid_to_dttm)
values
(
    '1',
    'A',
	'2018-09-01',
	'2018-09-18'
);

insert into 
	table2(id,var2, valid_from_dttm, valid_to_dttm)
values
(
    '1',
    'B',
	'2018-09-19',
	'5999-12-31'
);

select 
	t1.var1, 
	t2.var2, 
	dates.id, 
	dates.valid_from_dttm, 
	dates.valid_to_dttm
from
(
	select
	dates_from_ordered_witn_rn.rn,
	dates_from_ordered_witn_rn.id,
	dates_from_ordered_witn_rn.valid_from_dttm,
	dates_to_ordered_witn_rn.valid_to_dttm
	from
	(
		select
			row_number() over (order by id, valid_from_dttm) as rn,
			id,
			valid_from_dttm
		from
		(
			select distinct id, valid_from_dttm
			from(
					select id, valid_from_dttm
					from table1
					union all
					select id, valid_from_dttm
					from table2
				) dates_from_all
				order by valid_from_dttm
        ) dates_from_uniq
	) dates_from_ordered_witn_rn,
	(
		select
		row_number() over (order by id, valid_to_dttm) as rn,
		id,
		valid_to_dttm
		from
        (
			select distinct id, valid_to_dttm
			from (
					select id, valid_to_dttm
					FROM table1
					union all
					SELECT id, valid_to_dttm
					FROM table2
				) dates_to_all
				order by valid_to_dttm
        ) dates_to_uniq
	) dates_to_ordered_witn_rn
	where dates_from_ordered_witn_rn.id = dates_to_ordered_witn_rn.id
	and dates_from_ordered_witn_rn.rn = dates_to_ordered_witn_rn.rn
) dates left outer join table1 as t1 on
	dates.id = t1.id
	and t1.valid_from_dttm <= dates.valid_from_dttm
	and t1.valid_to_dttm >= dates.valid_to_dttm
	left outer join table2 as t2 on
	dates.id = t2.id
	and t2.valid_from_dttm <= dates.valid_from_dttm
	and t2.valid_to_dttm >= dates.valid_to_dttm
order by 
	dates.id, 
	dates.valid_from_dttm, 
	dates.valid_to_dttm
	