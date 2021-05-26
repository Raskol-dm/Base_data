create or replace function AddOneClient(VARCHAR, int) returns table
(
    sponsor_id INTEGER,
	sponsor_name varchar(50),
    sponsor_clients integer,
	sponsor_budget INTEGER
)
as
$$
	update sponsors
	set clientsqty = (clientsqty + 1)
	where company = $1;
	update sponsors
	set budget = (budget + $2)
	where company = $1;
	insert into sponsors(id,company, city, clientsqty, budget)
	values(1001,'UFFB', 'Berlin', '32', '154000');
	select id, company, clientsqty, budget
	from sponsors
	where company like $1;
$$ language sql;

select * from AddOneClient('Brent Diaz',7600)

delete from sponsors
where id = 1001;