-- Вывод названия таблицы и ее физического размера

create or replace procedure table_size() as
$$
	declare c cursor
	for select table_name, size
	from 
	(
		select table_name,
		pg_relation_size(cast(table_name as varchar)) as size 
		from information_schema.tables
		where table_schema not in ('information_schema','pg_catalog')
	) as tmp;
		row record;
begin
	open c;
	loop
		fetch c into row;
		exit when not found;
		raise notice '{table : %} {size : %}', row.table_name, row.size;
	end loop;
	close c;
end
$$ language plpgsql;

--drop PROCEDURE table_size();

call table_size();