select *
into temp cl
from clubs;

create or replace procedure updateClubRate(newRate int, tropL int, tropH int) as
$$
	update clubs
	set rating = newRate
	where trophiesnum between tropL and tropH
$$	language sql;

call updateClubRate(200, 50, 100);

select clubs.rating as newValue, cl.rating as OldValue
from cl join clubs on cl.id = clubs.id
where cl.trophiesnum between 50 and 100
order by cl.rating desc;