create or replace function get_stat(data)
returns table
(
    latness int,
    count_person int
)
as
$$
    select (register.wtime - '9:00'), count(id),
    from workers wk join register as reg on wk.id = reg.id_worker
    where reg.wdatea = $1 and reg.inout = 1
    group by (register.wtime - '9:00'),count(id)
$$ language sql;

select distinct employee.department 
from department 
where DATEDIFF(year, department.bd, current_date) >= 25;

create or replace function getage(bthd date) returns integer as
$$
 select extract (year from current_date) - extract (year from bthd)
$$ language sql;


select id_worker, min(wtime) as min_t 
from register
where inout = 1 and wdatea = current_date 
group by id 
order by min_t


select wk.id 
from ( 
    select people.id, count(*) from 
    ( select id_worker, min(wtime) as Ftime from register group by id_worker )
     as people where people.Ftime > '9:00' group by people.id ) 
     count_people join workers wk on count_people.id_worker = wk.id where count >= 5