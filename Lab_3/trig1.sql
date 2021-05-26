drop table if exists insertion_tb;

create table if not exists insertion_tb
(
	new_id serial not null,
	insertion_time time not null
);

create or replace function catch_insertion()
returns trigger as
$$
   begin
      insert into insertion_tb(new_id, insertion_time) 
	  values (new.id, current_timestamp);
      return new;
   end;
$$ language plpgsql;

create trigger insert_control
	after insert on clubs
	for each row execute procedure catch_insertion()