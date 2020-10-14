copy boksers
(id, name, sex, age, arm, rating)
from 'D:\Base_data\boksers.csv' delimiter ',' csv;
copy clubs
(id, name, rating, trophiesNum, sportsmenNum)
from 'D:\Base_data\clubs.csv' delimiter ',' csv;
copy sponsors
(id, company, city, clientsQty, budget)
from 'D:\Base_data\sponsors.csv' delimiter ',' csv;
copy transfers
from 'D:\Base_data\transfers.csv' delimiter ',' csv;