--drop function getObjByAddress;
-- Определяемая пользователем табличная функция CLR
-- Находит всех спортсменов, которые занимают этим видом спорта

create or replace function getBoksersbySport(skill varchar)
returns table
(
    name varchar, 
    sex varchar, 
    age bigint, 
    rating int
)
as
$$
result = []
for row in plpy.cursor("select * from transfers as tr join boksers as bk on tr.bokser = bk.id"):
	if row["position"] == skill:
		result.append(row)
return result
$$ language plpython3u;

select * from getBoksersbySport('KARATE');

drop function getBoksersbySport;
