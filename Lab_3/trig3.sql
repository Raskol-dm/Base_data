create table if not exists insert_tb
(
    old_id int,
	old_name VARCHAR,
    new_id int,
    new_name VARCHAR
);

create or replace function catch_insert()
returns trigger as
$$
   begin
      insert into insert_tb(old_id, new_id, old_name, new_name) 
	  values (old.id, new.id, old.name, new.name);
      return old;
   end;
$$ language plpgsql;

create trigger insert_control
	after insert on clubs
	for each row execute procedure catch_insertion()


insert into clubs
values
(
	1002, 'Kombo', 248, 200, 12
);

select * from insert_tb