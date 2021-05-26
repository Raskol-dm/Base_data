CREATE or replace FUNCTION maxRatingBox() returns int OUTPUT AS
$$
    select max(rating)
    from boksers
$$ LANGUAGE sql;

select maxRatingBox();
drop FUNCTION if exists maxRatingBox();