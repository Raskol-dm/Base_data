-- Пользовательская агрегатная функция
-- Считает средний возраст спортсменов выше определенного рейтинга
-- В противном случае выводим - 0
--drop function getavgAge;


create or replace function getAvgAge(rating integer) returns real
as
$$
summ = 0
col = 0
for row in plpy.cursor("select * from boksers"):
	if row["rating"] >= rating:
		summ += row["age"]
		col += 1
if (col == 0):
	return 0
else:
	avgr = (summ / col)
	return avgr
$$ language plpython3u;

select * from getAvgAge(25);

select * from getAvgAge(101);