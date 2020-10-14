alter table boksers
add primary key(id);
alter table boksers
alter column id
set
not null;
alter table boksers
alter column name
set
not null;
alter table boksers
add check (
        rating >= 0
        and rating <= 99
    );
alter table boksers
add check (
    age >= 16 and age <=45
);
-----------------------------------------------------------------
alter table clubs
add primary key(id);
alter table clubs
alter column id
set
not null;
alter table clubs
alter column name
set
not null;
alter table clubs
add check
(
    rating >= 100 and rating <=999
);
alter table clubs
add check
(
    sportsmenNum >= 0 and sportsmenNum <=50
);
alter table clubs
add check
(
    trophiesNum >= 70 and trophiesNum <=240
);
-------------------------------------------------------------------------------
alter table sponsors
add primary key(id);
alter table sponsors
alter column id
set
not null;
alter table sponsors
alter column company
set
not null;

alter table sponsors
add check
(
    clientsqty >= 1 and clientsqty <=40
);
alter table sponsors
add check
(
    budget >= 10000 and budget <=500000
);
----------------------------------------------------------------------
alter table transfers
alter column bokser
set
not null;
alter table transfers
alter column club
set
not null;
alter table transfers
alter column sponsor
set
not null;
alter table transfers
add foreign key(bokser) references boksers(id);
alter table transfers
add foreign key(club) references clubs(id);
alter table transfers
add foreign key(sponsor) references sponsors(id);