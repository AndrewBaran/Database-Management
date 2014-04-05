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
	sysID	char(4) not null,

	name 	text,
	description		text,

	primary key(sysID)
);


-- Parts
create table parts
(
	partID	char(4) not null,

	name 	text,
	description		text,

	primary key(partID)
);


-- Suppliers
create table suppliers
(
	suppID	char(4) not null,

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
	sysID	char(4) not null references systems(sysID),

	primary key(sid, sysID)
);


-- Parts In Systems
create table partsInSystems
(
	sysID	char(4) not null references systems(sysID),
	partID	char(4) not null references parts(partID),

	primary key(sysID, partID)
);


-- Catalog of suppliers and their parts
create table catalog
(
	suppID	char(4) not null references suppliers(suppID),
	partID	char(4) not null references parts(partID),

	primary key(suppID, partID)
);


-- Insert statements
