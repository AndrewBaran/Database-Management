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
	pid		char(4),

	firstName	text,
	lastName	text,
	age		integer,

	primary key(pid)
);


-- Engineers
create table engineers
(
	pid		char(4) references person(pid),

	highestDegree	text,
	favVideoGame	text,

	primary key(pid)
);


-- Astronauts
create table astronauts
(
	pid		char(4) references person(pid),

	yearsFlying		integer,
	golfHandicap	integer,

	primary key(pid)

);


-- Flight Control Operators
create table flightControlOps
(
	pid		char(4) references person(pid),

	chairPref	integer,
	prefDrink	text,

	primary key(pid)
);


create table jobType
(
	jid		char(4),

	name 	text,
	description		text,

	primary key(jid)
);


create table spacecraft
(
	sid		char(4),

	name 	text,
	tailNumber	integer,
	weightInTons	integer,
	fuelType	text,
	crewCapacity	integer,

	primary key(sid)	
);