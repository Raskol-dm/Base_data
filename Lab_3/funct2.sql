create or replace function getRichSponsors(VARCHAR, int) returns setof sponsors as
$$
    select *
    from sponsors
    where budget > $2
    and city = $1
$$ LANGUAGE sql;

select * from getRichSponsors('Andersonland', 23000);