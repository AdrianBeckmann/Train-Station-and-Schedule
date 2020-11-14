DROP TABLE Trip_Table;
DROP TABLE Transaction;
DROP TABLE Metro_Card;
DROP TABLE Rider_Account;
DROP TABLE Discount;
DROP TABLE Schedule_Station;
DROP TABLE Schedule;
DROP TABLE Line_Station;
DROP TABLE Train_Line;
DROP TABLE Station;

CREATE TABLE Station
(
    sid int,
    station_name varchar(50),
    address varchar(50),
    status number(1), -- this should only let you enter 0 or 1, there is no boolean type
    PRIMARY KEY (sid)
);

CREATE TABLE Train_Line
(
    lineid int,
    line_name varchar(50),
    station_num int,
    PRIMARY KEY (lineid)
);

CREATE TABLE Line_Station
(
    lsid int,
    lineid int,
    sid int,
    seq_num int,
    PRIMARY KEY (lsid),
    FOREIGN KEY (lineid) REFERENCES Train_Line (lineid),
    FOREIGN KEY (sid) REFERENCES Station (sid)
);

CREATE TABLE Schedule
(
    schid int,
    lineid int,
    direction int,
    PRIMARY KEY (schid),
    FOREIGN KEY (lineid) REFERENCES Train_Line (lineid)
);

CREATE TABLE Schedule_Station
(
    ssid int,
    schid int,
    sid int,
    arrival_time interval day to second,
    PRIMARY KEY (ssid),
    FOREIGN KEY (schid) REFERENCES Schedule (schid),
    FOREIGN KEY (sid) REFERENCES Station (sid)
);

CREATE TABLE Discount
(
    disid int,
   dtype varchar (10),
   disval number,
    PRIMARY KEY (disid)
);

CREATE TABLE Rider_Account
(
    acctid int,
    email varchar(50),
    password varchar(50),
    name varchar(50),
    age int,
    PRIMARY KEY (acctid)
);

CREATE TABLE Metro_Card
(
    cid int,
    disid int,
    acctid int,
    balance number,
    PRIMARY KEY (cid),
    FOREIGN KEY (disid) REFERENCES discount(disid),
    FOREIGN KEY (acctid) REFERENCES Rider_Account(acctid)
);

CREATE TABLE Transaction
(
    transid int,
    cid int,
    tot timestamp, --time of transaction
    amount number,
    PRIMARY KEY (transid),
    FOREIGN KEY (cid) REFERENCES Metro_Card (cid)
);

CREATE TABLE Trip_Table
(
    tripid int,
    cid int,
    entid int,
    exid int,
    cost number,
    ent_time timestamp,
    ext_time timestamp,
    PRIMARY KEY (tripid),
    FOREIGN KEY (cid) REFERENCES Metro_Card (cid)
);
insert into Station values(1,'Rockville', 11111, 1);
insert into Station values(2,'Chinatown', 22222, 1);
insert into Station values(3,'Union Station', 33333, 1);
insert into Station values(4,'Fort Totten', 44444, 1);
insert into Station values(5,'College Park', 55555, 1);
insert into Station values(6,'Greenbelt', 66666, 1);

insert into Train_Line values(1, 'Green Line', 4);
insert into Train_Line values(2, 'Red Line', 4);
insert into Train_Line values(3, 'Blue Line', 3); 

insert into Rider_Account values(1,'abeckm2@umbc.edu','abeckm2','Adrian', 65);
insert into Rider_Account values(2,'bhayes2@umbc.edu','bhayes2','Ben', 20);
insert into Rider_Account values(3,'consik1@umbc.edu','consik1','Kyle', 11);

Insert into Discount values (1,'regular',25);
Insert into Discount values (2,'children',20);
Insert into Discount values (3,'senior',15);

insert into Metro_Card values(1,3,1,45);
insert into Metro_Card values(2,1,2,35);
insert into Metro_Card values(3,2,3,10);

Insert into Transaction values (1, 1, timestamp '2020-03-11 00:13:28.00', 13);
Insert into Transaction values (2, 1, timestamp  '2020-03-15 00:17:58.00', 7);
Insert into Transaction values (3, 2, timestamp  '2020-02-11 00:04:17.00', 13);

Insert into Schedule values (1, 1, 1); -- Green Line is increasing
Insert into Schedule values (2, 1, 2); -- Green Line is decreasing
Insert into Schedule values (3, 2, 1); -- Red Line is increasing
Insert into Schedule values (4, 2, 2); -- Red Line is decreasing

--schedule station id, schedule id, station id, arrival time
Insert into Schedule_Station values (1,1,6, interval '03 07:30:00.00' day to second); -- Green Line is increasing at Greenbelt
Insert into Schedule_Station values (2,1,5, interval '03 07:40:00.00' day to second); -- Green Line is increasing at College Park
Insert into Schedule_Station values (3,1,4, interval '03 07:50:00.00' day to second); -- Green Line is increasing at Fort Totten
Insert into Schedule_Station values (4,1,2, interval '03 08:10:00.00' day to second); -- Green Line is increasing at Chinatown
Insert into Schedule_Station values (5,2,6, interval '03 08:10:00.00' day to second); -- Green Line is decreasing at Greenbelt
Insert into Schedule_Station values (6,2,5, interval '03 08:00:00.00' day to second); -- Green Line is decreasing at College Park
Insert into Schedule_Station values (7,2,4, interval '03 07:50:00.00' day to second); -- Green Line is decreasing at Fort Totten
Insert into Schedule_Station values (8,2,2, interval '03 07:30:00.00' day to second); -- Green Line is decreasing at Chinatown

Insert into Schedule_Station values (9,3,1, interval '03 07:30:00.00' day to second); -- Red Line is increasing at Rockville
Insert into Schedule_Station values (10,3,2, interval '03 07:40:00.00' day to second); -- Red Line is increasing at Chinatown
Insert into Schedule_Station values (11,3,3, interval '03 07:50:00.00' day to second); -- Red Line is increasing at Union Station
Insert into Schedule_Station values (12,3,4, interval '03 08:10:00.00' day to second); -- Red Line is increasing at Fort Totten
Insert into Schedule_Station values (13,4,1, interval '03 08:10:00.00' day to second); -- Red Line is decreasing at Rockville
Insert into Schedule_Station values (14,4,2, interval '03 08:00:00.00' day to second); -- Red Line is decreasing at Chinatown
Insert into Schedule_Station values (15,4,3, interval '03 07:50:00.00' day to second); -- Red Line is decreasing at Union Station
Insert into Schedule_Station values (16,4,4, interval '03 07:30:00.00' day to second); -- Red Line is decreasing at Fort Totten

Insert into Line_Station values (1, 2, 1, 1); -- Rockville is the first station on the red line
Insert into Line_Station values (2, 2, 2, 2); -- Chinatown is the second station on the red line
Insert into Line_Station values (3, 2, 3, 3); -- Union station is the third station on the red line
Insert into Line_Station values (4, 2, 4, 4); -- Fort Totten is the fourth station on the red line
Insert into Line_Station values (5, 1, 2, 4); -- Chinatown is the fourth station on the green line
Insert into Line_Station values (6, 1, 4, 3); -- Fort Totten is the third station on the green line
Insert into Line_Station values (7, 1, 5, 2); -- College Park is the second station on the green line
Insert into Line_Station values (8, 1, 6, 1); -- Greenbelt is the first station on the green line

Insert into Trip_Table values (1, 1, 3, 2, 50, timestamp '2017-01-21 12:34:56.78', timestamp '2020-05-21 12:34:56.78');
Insert into Trip_Table values (2, 3, 1, 3, 75, timestamp '2017-02-21 12:34:56.78', timestamp '2020-04-21 12:34:56.78');
Insert into Trip_Table values (3, 2, 2, 1, 90, timestamp '2017-03-21 12:34:56.78', timestamp '2020-03-26 12:34:56.78');

/*Normal Case: Prints out how to reach the destination station from the origin station and the transfer station that is needed*/
exec transferStation('Greenbelt','Rockville');
/*Special Case: Prints out that the stations are on the same line*/
exec transferStation('Greenbelt','Chinatown');
/*Special Case: Prints out that the origin station entered doesn't exist*/
exec transferStation('Grenbelt','Chinatown');
/*Special Case: Prints out that the destination station entered doesn't exist*/
exec transferStation('Greenbelt','Chinaton');

/*Normal Case: Lists out the number of accounts, the number of metro cards, the total spending amount, the average number of 
trips per account, the station that appears most as entrance is, and the station that appears most as a destination station.*/
exec databaseInfo;

/*Special Case: No existing ID*/
exec listcards(0);
/*Normal Cases: Prints out card id and balance*/
exec listcards(1);
exec listcards(3);

/*Special Case: Prints out that origin station entered doesn't exist*/
exec PR_schedule(interval '00 7:25:00.00' day to second, interval '00 0:35:00.00' day to second, 'Collge Park', 'Greenbelt', 'Green Line');
/*Special Case: Prints out that destination station entered doesn't exist*/
exec PR_schedule(interval '00 7:25:00.00' day to second, interval '00 0:35:00.00' day to second, 'College Park', 'Grenbelt', 'Green Line');
/*Special Case: Prints out that the train line entered doesn't exist*/
exec PR_schedule(interval '00 7:25:00.00' day to second, interval '00 0:35:00.00' day to second, 'College Park', 'Greenbelt', 'Gren Line');
/*Normal Cases: Prints out all schedules that occur between the arrival time and allowed wait time at origin station and when they should arrive by*/
exec PR_schedule(interval '03 7:30:00.00' day to second, interval '03 0:10:00.00' day to second, 'Rockville', 'Union Station', 'Red Line');
exec PR_schedule(interval '03 7:30:00.00' day to second, interval '03 1:10:00.00' day to second, 'Rockville', 'Union Station', 'Red Line');
exec PR_schedule(interval '03 7:30:00.00' day to second, interval '03 1:10:00.00' day to second, 'Union Station', 'Rockville', 'Red Line');

/*Normal Case: Prints out all transactions that occurred between March 10th and the 20th as well as the amount*/
exec transactionCheck(1,timestamp '2020-03-10 00:00:00.00', timestamp '2020-03-21 00:00:00.00');
/*Special Case: Prints out that no card id matches entered card id*/
exec transactionCheck(0,timestamp '2020-03-10 00:00:00.00', timestamp '2020-03-21 00:00:00.00');

--new account
exec create_account (1, 'kenn4@umbc.edu', 'kenn4', 'Kenny', 22);
select * from Rider_account;

exec login ('abeckm2@umbc.edu', 'abeckm2');
--correct email
exec login ('abeckm2@umbc.edu', 'abec');
--correct password
exec login ('abec@umbc.edu', 'abeckm2');

select * from Rider_Account;

--Normal case:
Select * from Rider_Account;
Select * from Metro_Card;
EXECUTE PR_NEW_CARD(3,500);
Select * from Rider_Account;
Select * from Metro_Card;
--Special Case:

EXECUTE PR_NEW_CARD(15,500);

/* normal case*/
Select * from Metro_Card;
Select * from Transaction;
EXECUTE AddMoney(1,500);
Select * from Metro_Card;
Select * from Transaction;
/* special case*/
EXECUTE AddMoney(50,5)

-- valid card id, should work as expected
exec add_trip_info(1, 1, 2, timestamp '2020-03-11 00:13:28.00', timestamp '2020-03-14 00:13:28.00');
-- different cid to confirm price consistency 
exec add_trip_info(2, 1, 2, timestamp '2020-03-11 00:13:28.00', timestamp '2020-03-14 00:13:28.00');
-- different cid to confirm price consistency 
exec add_trip_info(3, 1, 2, timestamp '2020-03-11 00:13:28.00', timestamp '2020-03-14 00:13:28.00');

-- select statement to check that trip has been added to the table correctly
select * from trip_table;

-- invalid card id
exec add_trip_info(-5, 1, 2, timestamp '2020-03-11 00:13:28.00', timestamp '2020-03-14 00:13:28.00');

--normal output
exec PR_stationtime(interval '03 7:30:00.00' day to second, 'Greenbelt', interval '00 00:30:00.00' day to second);
--misspelled station name
exec PR_stationtime(interval '03 8:00:00.00' day to second, 'Chiatown', interval '00 2:00:00.00' day to second);