/*Brandon Litwin
  CMPT 308N-111
  5/1/17
*/

DROP TABLE IF EXISTS Quotes;
DROP TABLE IF EXISTS FoughtIn;
DROP TABLE IF EXISTS MajorBattles;
DROP TABLE IF EXISTS Fortresses;
DROP TABLE IF EXISTS Politicians;
DROP TABLE IF EXISTS Soldiers;
DROP TABLE IF EXISTS Flagships;
DROP TABLE IF EXISTS Fleets;
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS PoliticalGroups;

--Create Statements
CREATE TABLE PoliticalGroups (
	pgID text NOT NULL,
	pgName text NOT NULL,
	dateEstablishedUC int NOT NULL,
	PRIMARY KEY(pgID)
);

CREATE TABLE People (
	personID text NOT NULL,
	firstName text NOT NULL,
	lastName text NOT NULL,
	alliedWith text NOT NULL REFERENCES PoliticalGroups(pgID),
	birthDateUC int NOT NULL,
	deathDateUC int check(birthDateUC<deathDateUC),
	PRIMARY KEY(personID)
);

CREATE TABLE Fleets (
	flID text NOT NULL,
	fleetName text NOT NULL,
	belongsTo text NOT NULL REFERENCES PoliticalGroups(pgID),
	PRIMARY KEY(flID)
);

CREATE TABLE Flagships (
	shipID text NOT NULL,
	shipName text NOT NULL,
	fleetAssignedTo text NOT NULL REFERENCES Fleets(flID),
	shipCapactity int NOT NULL,
	activeStatus text NOT NULL,
	PRIMARY KEY(shipID)
);

CREATE TABLE Soldiers (
	personID text NOT NULL REFERENCES People(personID),
	rank text NOT NULL,
	shipAssignedTo text NOT NULL REFERENCES Flagships(shipID),
	PRIMARY KEY(personID)
);

CREATE TABLE Politicians (
	personID text NOT NULL REFERENCES People(personID),
	position text NOT NULL,
	PRIMARY KEY(personID)
);

CREATE TABLE Fortresses (
	foID text NOT NULL,
	fortressName text NOT NULL,
	signatureWeapon text NOT NULL,
	diameterInKm int NOT NULL,
	controlledBy text NOT NULL REFERENCES PoliticalGroups(pgID),
	PRIMARY KEY(foID)
);

CREATE TABLE MajorBattles (
	battleID text NOT NULL,
	battleName text NOT NULL,
	battleVictor text NOT NULL REFERENCES PoliticalGroups(pgID),
	allianceCasualties int NOT NULL,
	empireCasualties int NOT NULL,
	dateBegunUC varchar(10) NOT NULL,
	dateEndedUC varchar(10) check(dateBegunUC<dateEndedUC),
	PRIMARY KEY(battleID)
);

CREATE TABLE FoughtIn (
	battleID text NOT NULL REFERENCES MajorBattles(battleID),
	pgID text NOT NULL REFERENCES PoliticalGroups(pgID),
	PRIMARY KEY(battleID, pgID)
);

CREATE TABLE Quotes (
	quoteID text NOT NULL,
	saidBy text NOT NULL REFERENCES People(personID),
	famousQuote text NOT NULL,
	PRIMARY KEY(quoteID)
);

INSERT INTO PoliticalGroups
VALUES('pg001', 'Free Planets Alliance', '527'),
	  ('pg002', 'New Galactic Empire', '799'),
	  ('pg003', 'Fezzan Dominion', '682')
;
--Insert Statements
INSERT INTO People 
VALUES('p001', 'Reinhard', 'Lohengramm', 'pg002', '776', '801'),
	  ('p002', 'Wen-li', 'Yang', 'pg001', '767', '800'),
	  ('p003', 'Siegfried', 'Kircheis', 'pg002', '777', '797'),
	  ('p004', 'Julian', 'Mintz', 'pg001', '782', NULL),
	  ('p005', 'Adrian', 'Rubinsky', 'pg003', '750', '801'),
	  ('p006', 'Job', 'Trunicht', 'pg001', '755', '800'),
	  ('p007', 'Katerose', 'Kruetzer', 'pg001', '784', NULL),
	  ('p008', 'Jessica', 'Edwards', 'pg001', '767', '797'),
	  ('p009', 'Frederica', 'Greenhill', 'pg001', '774', NULL),
	  ('p010', 'Klaus', 'Lichtenlade', 'pg002', '733', '797'),
	  ('p011', 'Alex', 'Cazerne', 'pg001', '764', NULL),
	  ('p012', 'Walter', 'Schonkopf', 'pg001', '764', '801'),
	  ('p013', 'Oskar', 'Ruenthal', 'pg002', '767', '800'),
	  ('p014', 'Wolfgang', 'Mittermeyer', 'pg002', '769', NULL),
	  ('p015', 'Friedrich', 'Goldenbaum', 'pg002', '715', '796'),
	  ('p016', 'Olivier', 'Poplin', 'pg001', '769', NULL),
	  ('p017', 'Dusty', 'Attemborough', 'pg001', '768', NULL),
	  ('p018', 'Fritz', 'Bittenfeld', 'pg002', '765', NULL),
	  ('p019', 'Paul', 'Oberstein', 'pg002', '759', '801'),
	  ('p020', 'Alan', 'Labouseur', 'pg002', '760', NULL)
;		

INSERT INTO Fleets
VALUES('fl001', 'Yang Fleet', 'pg001'),
	  ('fl002', 'Lohengramm Fleet', 'pg002'),
	  ('fl003', 'Black Lancers', 'pg002'),
	  ('fl004', 'Mittermeyer Fleet', 'pg002'),
	  ('fl005', 'Ruenthal Fleet', 'pg002')
;

INSERT INTO Flagships
VALUES('s001', 'Ulysses', 'fl001', '660', 'Active'),
	  ('s002', 'Brunhild', 'fl002', '1171', 'Decommissioned'),
	  ('s003', 'Kings Tiger', 'fl003', '902', 'Active'),
	  ('s004', 'Tristan', 'fl005', '944', 'Decommissioned'),
	  ('s005', 'Beowulf', 'fl004', '954', 'Active'),
	  ('s006', 'Alpaca', 'fl002', '3007', 'Active')
;

INSERT INTO Soldiers
VALUES('p002', 'Fleet Admiral', 's001'),
	  ('p003', 'Fleet Admiral', 's002'),
	  ('p004', 'Ensign', 's001'),
	  ('p007', 'Corporal', 's001'),
	  ('p009', 'Lieutenant Commander', 's001'),
	  ('p011', 'Vice Admiral', 's001'),
	  ('p012', 'Brigadier General', 's001'),
	  ('p013', 'Fleet Admiral', 's004'),
	  ('p014', 'Fleet Admiral', 's005'),
	  ('p016', 'Lieutenant Commander', 's001'),
	  ('p017', 'Vice Admiral', 's001'),
	  ('p018', 'Fleet Admiral', 's003'),
	  ('p020', 'Emperors Data Consultant', 's006')
;

INSERT INTO Politicians
VALUES('p001', 'Emperor'),
	  ('p005', 'Lord'),
	  ('p006', 'Supreme Chairman'),
	  ('p008', 'Councilor'),
	  ('p010', 'Prime Minister'),
	  ('p015', 'Emperor'),
	  ('p019', 'Minister of Military Affairs')
;

INSERT INTO Fortresses
VALUES('fo001', 'Iserlohn', 'Thor Hammer', '60', 'pg001'),
	  ('fo002', 'Geiersburg', 'Vulture Claw', '45', 'pg002')
;

INSERT INTO MajorBattles
VALUES('b001', 'Battle of Astarte', 'pg002', '1500000', '150000', '01/01/796', '01/02/796'),
	  ('b002', 'Battle of Amritsar', 'pg002', '4000000', '200000', '10/15/796', '10/16/796'),
	  ('b003', 'Eigth Battle of Iserlohn', 'pg001', '50000', '1800000', '04/03/798', '04/04/798'),
	  ('b004', 'Battle of Rantemario', 'pg002', '5206000', '1660000', '02/07/799', '02/09/799'),
	  ('b005', 'Battle of Vermillion', 'pg002', '1405901', '2349432', '04/24/799', '05/05/799'),
	  ('b006', 'Battle of the Corridor', 'pg001', '100000', '3791100', '04/13/800', '05/07/800'),
	  ('b007', 'Battle of Shiva', 'pg002', '300000', '2500000', '05/29/801', '06/03/801')
;

INSERT INTO FoughtIn
VALUES('b001', 'pg001'),
	  ('b001', 'pg002'),
	  ('b002', 'pg001'),
	  ('b002', 'pg002'),
	  ('b003', 'pg001'),
	  ('b003', 'pg002'),
	  ('b004', 'pg001'),
	  ('b004', 'pg002'),
	  ('b005', 'pg001'),
	  ('b005', 'pg002'),
	  ('b006', 'pg001'),
	  ('b006', 'pg002'),
	  ('b007', 'pg001'),
	  ('b007', 'pg002')
;

INSERT INTO Quotes
VALUES('q001', 'p001', 'My conquest is the sea of stars.'),
	  ('q002', 'p002', 'Alcohol is the friend of humanity. Can I abandon a friend?'),
	  ('q003', 'p003', 'Reinhard, you must obtain the universe. '),
	  ('q004', 'p004', 'I made tea.'),
	  ('q005', 'p005', 'Once the Empire and the Alliance destroy each other, I will take control.'),
	  ('q006', 'p006', 'Democracy is not all that remarkable. They put someone like me in power.'),
	  ('q007', 'p007', 'You know, I use inexperience as my sales point and am living my life comfortably.'),
	  ('q008', 'p008', 'The people demand an end to this war.'),
	  ('q009', 'p009', 'You may have caused millions to die, but at the very least you made me happy.'),
	  ('q010', 'p010', 'This is a rather bad state of affairs.'),
	  ('q011', 'p011', 'Love and the human mind cannot be analyzed with formulas.'),
	  ('q012', 'p012', 'I need no epitaph. Only tears from beautiful women will bring peace to my soul.'),
	  ('q013', 'p013', 'Regardless of the color of eyes or skin, the color of blood is the same for everyone.'),
	  ('q014', 'p014', 'One success is bound to beget imitations.'),
	  ('q015', 'p015', 'Just as there is no immortal person, I am afraid that there is also no indestructible empire.'),
	  ('q016', 'p016', 'One cannot live by jokes alone. But if there were no jokes, I would rather not live.'),
	  ('q017', 'p017', 'We are doing this revolution out of foppery and whim. Got that?'),
	  ('q018', 'p018', 'Praise people loudly, and denounce people even louder.'),
	  ('q019', 'p019', 'There are no monarchs with clean hands.'),
	  ('q020', 'p020', 'I do not believe in the Empire, but they are paying me well.')
;
--Views
CREATE OR REPLACE VIEW ActiveSoldiers AS
SELECT firstName, lastName
	FROM People 
	inner join Soldiers on People.personID = Soldiers.personID
	inner join Flagships on Soldiers.shipAssignedTo = Flagships.shipID
	inner join Fleets on Flagships.fleetAssignedTo = Fleets.flID
WHERE Fleets.flID in (SELECT flID
					  FROM Fleets
					  WHERE ActiveStatus='Active')
ORDER BY lastName asc
;

CREATE OR REPLACE VIEW CommandedByFleetAdmiral AS
SELECT firstName, lastName, shipName, fleetName
FROM People
	inner join Soldiers on People.personID = Soldiers.personID
	inner join Flagships on Soldiers.shipAssignedTo = Flagships.shipID
	inner join Fleets on Flagships.fleetAssignedTo = Fleets.flID
WHERE People.personID in (SELECT personID
				  FROM Soldiers
				  WHERE rank='Fleet Admiral')
ORDER BY lastName asc
;

CREATE OR REPLACE VIEW QuotesFromDeceased AS
SELECT firstName, lastName, famousQuote
FROM People 
	inner join Quotes on People.personID = Quotes.saidBy
WHERE People.deathDateUC IS NOT NULL
ORDER BY deathDateUC asc
;
--Reports
SELECT battleName, allianceCasualties, empireCasualties
FROM MajorBattles
WHERE empireCasualties>allianceCasualties
AND battleVictor='pg002'
;

SELECT firstName, lastName, deathDateUC
FROM People
WHERE deathDateUC<(SELECT dateEstablishedUC
				   FROM PoliticalGroups
				   WHERE pgID='pg002')
ORDER BY deathDateUC asc
;
--Stored Procedures
CREATE OR REPLACE FUNCTION NumberOfMajorBattlesWon(text, REFCURSOR) RETURNS REFCURSOR AS
$$
DECLARE
	pg_Name text	    := $1;
	resultset REFCURSOR := $2;
BEGIN
	open resultset for
		SELECT count(MajorBattles.battleVictor) as NumberOfBattlesWon
		FROM MajorBattles
			inner join PoliticalGroups on MajorBattles.battleVictor = PoliticalGroups.pgID
		WHERE pgName = pg_Name;
	return resultset;
END;
$$
language plpgsql;

SELECT NumberOfMajorBattlesWon('New Galactic Empire', 'results');
Fetch all from results;

SELECT NumberOfMajorBattlesWon('Free Planets Alliance', 'results');
Fetch all from results;

CREATE OR REPLACE FUNCTION UpdateFlagshipStatus() RETURNS TRIGGER AS
$$
DECLARE
BEGIN
	IF new.deathDateUC IS NOT NULL
	AND (SELECT rank
		 FROM Soldiers
		 WHERE Soldiers.personID = new.personID) = 'Fleet Admiral'
	THEN
		UPDATE Flagships
		SET ActiveStatus = 'Decommissioned'
		WHERE shipID = (SELECT shipID
					    FROM Flagships
							inner join Soldiers on Flagships.shipID = Soldiers.shipAssignedTo
						WHERE Soldiers.personID = new.personID
					    )
	;
	END IF;
RETURN new;		 
END;
$$
language plpgsql;

--Triggers
CREATE TRIGGER UpdateFlagshipStatus
AFTER UPDATE ON People
FOR EACH ROW
EXECUTE PROCEDURE UpdateFlagshipStatus();

UPDATE People
SET deathDateUC = '801'
WHERE personID = 'p018';

CREATE ROLE Admin;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO Admin;

CREATE ROLE Historian;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM Historian;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA PUBLIC TO Historian;

CREATE ROLE Viewer;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM Viewer;
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO Viewer;

