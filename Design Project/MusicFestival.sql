-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- 4/20/2014

-- Design Project: Music Festival



-- Drop tables if they already exist in the DBMS

-- Weak entities
drop table if exists staff;
drop table if exists membersInBands;
drop table if exists schedule;
drop table if exists ticketsSold;
drop table if exists bandMember;
drop table if exists eventWorker;
drop table if exists attendee;
drop table if exists person;


-- Strong entities
drop table if exists zipCode;
drop table if exists jobRole;
drop table if exists shift;
drop table if exists bands;
drop table if exists stages;


-- Create table statements

-- ZipCode
create table zipCode
(
	zip 	integer not null,

	city	text,
	state 	text,

	primary key(zip)
);


-- JobRole
create table jobRole
(
	jobID	char(4) not null,

	name	text,
	description		text,

	primary key(jobID)
);


-- Shift
create table shift
(
	shiftNum	integer not null,

	startTime	time,

	primary key(shiftNum)
);


-- Bands
create table bands
(
	bandID	char(5) not null,

	name	text,
	genre	text,
	yearFormed	integer,

	primary key(bandID)
);


-- Stages
create table stages
(
	stageID		char(4) not null,

	name	text,
	audienceSize	integer,

	primary key(stageID)
);


-- Person
create table person
(
	pid		char(7) not null,

	firstName	text,
	lastName	text,
	address		text,

	zip 	integer references zipCode(zip),

	primary key(pid)
);


-- BandMember
create table bandMember
(
	pid		char(7) not null references person(pid),

	instrument		text,

	primary key(pid)
);


-- EventWorker
create table eventWorker
(
	pid		char(7) not null references person(pid),

	salary	real,

	primary key(pid)
);


-- Attendee
create table attendee
(
	pid		char(7) not null references person(pid),

	seatStatus	text
		check (seatStatus = 'Grass' or seatStatus = 'Pit' or seatStatus = 'VIP'),

	primary key(pid)
);


-- Staff
create table staff
(
	pid			char(7) not null references eventWorker(pid),
	jobID		char(4) not null references jobRole(jobID),
	shiftNum	integer not null references shift(shiftNum),

	primary key(pid, jobID, shiftNum)
);


-- TicketsSold
create table ticketsSold
(
	pid			char(7) not null references attendee(pid),
	stageID		char(4) not null references stages(stageID),

	primary key(pid, stageID)
);


-- MembersInBands
create table membersInBands
(
	pid		char(7) not null references bandMember(pid),
	bandID	char(5) not null references bands(bandID),

	yearsInBand		integer,

	primary key(pid, bandID)
);


-- Schedule
create table schedule
(
	stageID		char(4) not null references stages(stageID),
	bandID		char(5) not null references bands(bandID),
	datePlayed	date not null,
	startTime	time,
	endTime		time,

	primary key(stageID, bandID, datePlayed)
);