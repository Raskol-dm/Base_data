-- Определяемый пользователем тип данных CLR

create type stat as
(
    name varchar,
    city varchar,
    rate integer
);

--drop type stat;
--drop function getSportbySkill;


create or replace function getSportbySkill(skill varchar) returns stat
as
$$
plan = plpy.prepare("select bk.name, sp.city, bk.rating from boksers as bk joine transfrs as tr on tr.bokser = bk.id join sponsors as sp on sp.id = tr.club where tr.position = $1", ["varchar"])
stat = plpy.execute(plan, [skill])
plpy.notice(stat[0])
return(stat[0]['name'], stat[0]['city'], stat[0]['rating'])
$$ language plpython3u;

select * from getSportbySkill('KUNFU');