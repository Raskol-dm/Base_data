--create extension if not exists plpython3u;

-- Скалярная функция CLR определяемая пользователем
-- Вывести имя по рейтингу
-- DROP FUNCTION getinfo;

create or replace function getInfo(rating integer) returns VARCHAR
as
$$
for row in plpy.cursor("select * from boksers"):
	if row["rating"] == rating:
		return row["name"]
return "None"
$$ language plpython3u;

select * from getInfo(66);