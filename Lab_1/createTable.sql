drop table transfers;
drop table boksers;
drop table clubs;
drop table sponsors;
create table
if not exists boksers
(
    id serial,
    name varchar
(25),
    sex varchar
(10),
    age int,
    arm varchar
(5),
    rating int
);
create table
if not exists clubs
(
    id serial,
    name varchar
(50),
    rating int,
    trophiesNum int,
    sportsmenNum int
);
create table
if not exists sponsors
(
    id serial,
    company VARCHAR
(50),
    city varchar
(30),
    clientsQty int,
    budget int
);
create table
if not exists transfers
(
    bokser int,
    club int,
    sponsor int,
    position varchar
(13)
);
