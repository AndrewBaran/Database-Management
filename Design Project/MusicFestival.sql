-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- 4/20/2014

-- Design Project: Music Festival



-- Drop tables if they already exist in the DBMS

-- Weak entities
drop table if exists person;
drop table if exists bandMember;
drop table if exists eventWorker;
drop table if exists attendee;
drop table if exists staff;
drop table if exists membersInBands;
drop table if exists bandsOnStage;
drop table if exists ticketsSold;


-- Strong entities
drop table if exists zipCode;
drop table if exists jobRole;
drop table if exists shift;
drop table if exists bands;
drop table if exists stages;


-- Create table statements

create table zipCode
(
	zip 	integer not null,

	city	text,
	state 	text,

	primary key(zip)
);


create table jobRole
(
	jobID	char(4) not null,

	name	text,
	description		text,

	primary key(jobID)
);


create table shift
(
	shiftNum	integer not null,

	startTime	time,

	primary key(shiftNum)
);


create table bands
(
	bandID	char(5) not null,

	name	text,
	genre	text,
	yearFormed	integer,

	primary key(bandID)
);


create table stages
(
	stageID		char(4) not null,

	name	text,
	audienceSize	integer,

	primary key(stageID)
);


create table person
(
	pid		char(7) not null,

	firstName	text,
	lastName	text,
	address		text,

	zip 	integer references zipCode(zip)
);


create table bandMember
(
	pid		char(7) not null references person(pid),

	instrument		text,
	-- Do I need yearsPlayed field?

	primary key(pid)
);


create table eventWorker
(
	pid		char(7) not null references person(pid),

	salary	real,

	primary key(pid)
);


create table attendee
(
	pid		char(7) not null references person(pid),

	seatStatus	text
		check (seatStatus = 'Grass' or seatStatus = 'Pit' or seatStatus = 'VIP'),

	primary key(pid)
);