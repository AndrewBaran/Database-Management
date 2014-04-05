-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- 4/4/2014

-- Lab 9: Normalization Three


-- Drop tables if they exist in the DBMS

-- Weak entities
drop table if exists engineers;
drop table if exists astronauts;
drop table if exists flightControlOps;
drop table if exists crew;

drop table if exists systemsInSpacecrafts;
drop table if exists partsInSystems;
drop table if exists catalog;

-- Strong entities
drop table if exists person;
drop table if exists jobType;

drop table if exists spacecraft;
drop table if exists systems;
drop table if exists parts;
drop table if exists suppliers;


-- Person
create table person
(
	pid		char(4) not null,

	firstName	text,
	lastName	text,
	age		integer,

	primary key(pid)
);


-- Engineers
create table engineers
(
	pid		char(4) not null references person(pid),

	highestDegree	text,
	favVideoGame	text,

	primary key(pid)
);


-- Astronauts
create table astronauts
(
	pid		char(4) not null references person(pid),

	yearsFlying		integer,
	golfHandicap	integer,

	primary key(pid)
);


-- Flight Control Operators
create table flightControlOps
(
	pid		char(4) not null references person(pid),

	chairPref	integer,
	prefDrink	text,

	primary key(pid)
);


-- Job Types
create table jobType
(
	jid		char(4) not null,

	name 	text,
	description		text,

	primary key(jid)
);


-- Spacecraft
create table spacecraft
(
	sid		char(4) not null,

	name 	text,
	tailNumber	integer,
	weightInTons	integer,
	fuelType	text,
	crewCapacity	integer,

	primary key(sid)	
);


-- Systems
create table systems
(
	sysID	char(6) not null,

	name 	text,
	description		text,

	primary key(sysID)
);


-- Parts
create table parts
(
	partID	char(7) not null,

	name 	text,
	description		text,

	primary key(partID)
);


-- Suppliers
create table suppliers
(
	suppID	char(7) not null,

	name 	text,
	address		text,
	paymentTerms	text,

	primary key(suppID)
);


-- Crew
create table crew
(
	pid		char(4) not null references person(pid),
	jid		char(4) not null references jobType(jid),
	sid		char(4) not null references spacecraft(sid),

	primary key(pid, jid, sid)
);


-- Systems In Spacecrafts
create table systemsInSpacecrafts
(
	sid 	char(4) not null references spacecraft(sid),
	sysID	char(6) not null references systems(sysID),

	primary key(sid, sysID)
);


-- Parts In Systems
create table partsInSystems
(
	sysID	char(6) not null references systems(sysID),
	partID	char(7) not null references parts(partID),

	primary key(sysID, partID)
);


-- Catalog of suppliers and their parts
create table catalog
(
	suppID	char(7) not null references suppliers(suppID),
	partID	char(7) not null references parts(partID),

	primary key(suppID, partID)
);



-- Insert statements for testing

-- People
insert into person(pid, firstName, lastName, age)
	values('p001', 'Alpha', 'A', 10);
insert into person(pid, firstName, lastName, age)
	values('p002', 'Beta', 'B', 20);
insert into person(pid, firstName, lastName, age)
	values('p003', 'Charlie', 'C', 30);


-- Engineers
insert into engineers(pid, highestDegree, favVideoGame)
	values('p001', 'Bachelor', 'Portal');


-- Astronauts
insert into astronauts(pid, yearsFlying, golfHandicap)
	values('p002', 20, 35);


-- Flight Control Ops
insert into flightControlOps(pid, chairPref, prefDrink)
	values('p003', 7, 'Vodka');


-- Job Types
insert into jobType(jid, name, description)
	values('j001', 'Engineer', 'Builds stuff');
insert into jobType(jid, name, description)
	values('j002', 'Astronaut', 'Goes into space');
insert into jobType(jid, name, description)
	values('j003', 'Flight Control Operator', 'The Houston that people talk to');


-- Spacecraft
insert into spacecraft(sid, name, tailNumber, weightInTons, fuelType, crewCapacity)
	values('s001', 'Apollo 7', 007, 2000, 'Magic', 20);


-- Systems
insert into systems(sysID, name, description)
	values('sys001', 'Life Support', 'Keeps you alive');
insert into systems(sysID, name, description)
	values('sys002', 'Temperature Control', 'Keeps you warm');


-- Parts
insert into parts(partID, name, description)
	values('part001', 'Screw', 'You');
insert into parts(partID, name, description)
	values('part002', 'Hammer', 'Waiting for it to fall');


-- Suppliers
insert into suppliers(suppID, name, address, paymentTerms)
	values('supp001', 'Acme', '123 Fake St', 'Monthly bill');


-- Crew
insert into crew(pid, jid, sid)
	values('p002', 'j002', 's001');


-- Systems In Spaceships
insert into systemsInSpacecrafts(sid, sysID)
	values('s001', 'sys001');
insert into systemsInSpacecrafts(sid, sysID)
	values('s001', 'sys002');


-- Parts In Systems
insert into partsInSystems(sysID, partID)
	values('sys001', 'part001');
insert into partsInSystems(sysID, partID)
	values('sys002', 'part002');


-- Catalog of suppliers and their parts
insert into catalog(suppID, partID)
	values('supp001', 'part001');
insert into catalog(suppID, partID)
	values('supp001', 'part002');