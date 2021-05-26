
-- Пора платить налоги
select *
into temp spon
from sponsors;

create procedure nalogNaBudget(LowPl int, HighPl int) as
$$
begin
	if (LowPl <= HighPl) then
	    update sponsors
     	set budget = budget - (LowPl*0.13)
    	where budget >= LowPl and budget < (LowPl + 50000);
		call nalogNaBudget(LowPl + 50000, HighPl);
    end if;
end;	
$$ language plpgsql;

call nalogNaBudget(250000, 500000);

select sponsors.budget as newValue, spon.budget as OldValue
from spon join sponsors on spon.id = sponsors.id
where spon.budget between 250000 and 500000
order by oldvalue