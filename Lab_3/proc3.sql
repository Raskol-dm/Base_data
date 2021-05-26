
select *
into temp boks
from boksers;

create or replace procedure LowRateYoungBox(minAge int, maxAge bigint, procent int) as
$$
declare c cursor
	for select * 
	from boksers
	where age between minAge and maxAge;
	row record;
begin
	open c;
	loop
		fetch c into row;
		exit when not found;
		update boksers
		set rating = rating - procent
		where boksers.age = row.age and boksers.rating > 10;
	end loop;
	close c;		
end
$$ language plpgsql;

call LowRateYoungBox(18, 25, 7);

select boksers.rating as newValue, boks.rating as OldValue
from boks join boksers on boks.id = boksers.id
where boks.age between 18 and 25

update boksers
set rating = boks.rating
from boks
where  boks.id = boksers.id