create or replace function getValuesFromTree(base varchar)
returns setof trees
as
$$
begin
    return query
    select (getValuesFromTree(t.children)).*
    from trees t where t.parent = base;

    return query
    select tr.children, tr.parent
    from trees tr
    where tr.parent = base;
end
$$ language plpgsql;

select * from getValuesFromTree('Прадедушка');