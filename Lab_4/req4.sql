-- Хранимая процедура CLR
-- Пора платить налоги

-- Тестирование процедуры выполняется на копии таблицы sponsors

drop procedure nalog_Budget;
drop table spon

select *
into temp spon
from sponsors;

create procedure nalog_Budget(costp int) as
$$
for row in plpy.cursor("select * from spon"):
    if row["budget"] >= costp:
        newbd = int(row["budget"] - costp * 0.13)
        plan = plpy.prepare("update spon set budget = $1 where budget = $2;", ["integer", "integer"])
        plpy.execute(plan, [newbd, row["budget"]])
$$ language plpython3u;

call nalog_Budget(150000);

select * from spon where budget > 150000