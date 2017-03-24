/*Brandon Litwin Database Management 3/24/17*/
DROP TABLE IF EXISTS CastAndCrew;
DROP TABLE IF EXISTS  Movies;
DROP TABLE IF EXISTS  Actors;
DROP TABLE IF EXISTS  Directors;
DROP TABLE IF EXISTS  People;

CREATE TABLE People (
	personID varchar(10) NOT NULL,
	name varchar(40) NOT NULL,
	address varchar(60) NOT NULL,
	birthDate varchar(8) NOT NULL,
	spouseName varchar(40),
	heightInInches int NOT NULL,
	weightInPounds int NOT NULL,
	eyeColor varchar(10) NOT NULL,
	hairColor varchar(10) NOT NULL,
	PRIMARY KEY (personID)
);

CREATE TABLE Actors (
	personID varchar(10) NOT NULL,
	favColor varchar(10),
	actorsGuildAnniversaryDate varchar(8),
	FOREIGN KEY (personID) REFERENCES People(personID)
);

CREATE TABLE Directors (
	personID varchar(10) NOT NULL,
	filmSchoolAttended varchar(40),
	directorsGuildAnniversaryDate varchar(8),
	favLensMaker varchar(40),
	FOREIGN KEY (personID) REFERENCES People(personID)
);

CREATE TABLE Movies (
	MPAANumber varchar(7) NOT NULL,
	title varchar(40) NOT NULL,
	yearReleased varchar(4) NOT NULL,
	domesticBoxOfficeSalesUSD int NOT NULL,
	foreignBoxOfficeSalesUSD int NOT NULL,
	dvdBluRaySalesUSD int NOT NULL,
	PRIMARY KEY (MPAANumber)
);

CREATE TABLE CastAndCrew (
	personID varchar(10) NOT NULL,
	MPAANumber varchar(7) NOT NULL,
	role varchar(25) NOT NULL,
	FOREIGN KEY (MPAANumber) REFERENCES Movies(MPAANumber),
	FOREIGN KEY (personID) REFERENCES People(personID)
);

INSERT INTO People
VALUES ('p001', 'Sean Connery', '22 Maple St', '08251930', 'Micheline Roquebrune', 74, 180, 'Brown', 'Black'),
	   ('p002', 'Terence Young', '123 Apple Rd', '06201915', 'Sabine Sun', 65, 145, 'Brown', 'Brown'),
	   ('p003', 'Guy Hamilton', '22 Green Mountain Rd', '09161922', 'Naomi Chance', 68, 155, 'Brown', 'Brown'),
	   ('p004', 'Lewis Gilbert', '19 Juniper Ct', '03061920', 'Hylda Tafler', 67, 150, 'Blue', 'Blond')
;

INSERT INTO Actors
VALUES ('p001', 'Red', '10251960')
;

INSERT INTO Directors
VALUES ('p002', 'Cambridge', '04101963', 'Argus'),
	   ('p003', 'Cambridge', '05181967', 'Cookie'),
	   ('p004', 'La Femis', '06121962', 'Canon')
;

INSERT INTO Movies
VALUES ('20568', 'From Russia With Love', '1963', 24796765, 54100000, 10000000),
	   ('20808', 'Goldfinger', '1964', 51081062, 73800000, 50000000),
	   ('21666', 'You Only Live Twice', '1967', 43084787, 68500000, 30000000)
;

INSERT INTO CastAndCrew 
VALUES ('p001', '20568', 'Actor'),
	   ('p001', '20808', 'Actor'),
	   ('p001', '21666', 'Actor'),
	   ('p002', '20568', 'Director'),
	   ('p003', '20808', 'Director'),
	   ('p004', '21666', 'Director')
;
/*Query to find all directors who have directed movies that Sean Connery acted in*/	
select name
from people p
	inner join CastAndCrew c on p.personID = c.personID 
	where c.role = 'Director' AND c.mpaanumber in (select mpaanumber /*select names of directors*/	
												   from CastAndCrew /*select movies that Sean Connery acted in*/
						      					   where personID = (select personID
																	 from People
																	 where name = 'Sean Connery') /*select personID of Sean Connery*/
												  )
;


