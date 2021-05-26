--delete from boksers where id = 1006

--drop trigger controlAdding on boksers


create or replace function controlAdding()
returns trigger
as
$$
person = TD['new']["name"]
plpy.notice(person)
flag = 1
for row in plpy.cursor("select * from boksers"):
    if row["name"] == person:
        flag = 0
        break
if flag == 1:
    try:
        plan = plpy.prepare("insert into bokser(name, sex, age, arm, rating) values($1, $2, $3, $4, $5);", ["varchar", "varchar", "integer", "varchar", "integer"])
        plan = plpy.execute(plan, [person, null, null, null, null])
        plpy.notice("new bokser added")
    except:
        plpy.notice("problems on adding new bokser")
plpy.notice("bokser exists in base")
$$ language plpython3u;

--select * from boksers;

create trigger controlAdding
before insert on boksers for each row
execute procedure controlAdding();

insert into boksers
(
	id, name, sex, age, arm, rating
)
values
(1006,'Ilon Mask', 'female', 19, 'left', 65);