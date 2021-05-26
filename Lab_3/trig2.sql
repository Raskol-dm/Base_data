drop view if ex
Триггер при обновлении выводит старую стр и новую на которую обнов
create view spon_view as
select *
from sponsors;

create or replace function UpdateSponsorsBase()
returns trigger as
$$
begin
	update sponsors
	set clientsqty = clientsqty - 1,
    budget = budget - 10000
	where id = old.id;
	return old;
end;
$$ language plpgsql;

create trigger DeletedFromSponsors
	instead of delete on spon_view
	for each row
	execute procedure UpdateSponsorsBase();


--- drop trigger DeletedFromSponsors on spon_view;
--- drop function UpdateSponsorsBase();

insert into spon_view
values
(
	1002, '1X', 'Novosibirsk', 33, 85000
);


delete from spon_view
where id = '1002';

select *
from spon_view
where id = 1002;
