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
	zip 	text not null,

	city	text,
	state 	char(2),

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
	endTime		time,

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

	zip 	text references zipCode(zip),

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
	dayWorking	date not null,

	primary key(pid, jobID, shiftNum, dayWorking)
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


-- Insert statements

-- Zip Codes
insert into zipCode(zip, city, state)
	values('06701', 'Waterbury', 'CT');
insert into zipCode(zip, city, state)
	values('06601', 'Bridgeport', 'CT');
insert into zipCode(zip, city, state)
	values('06614', 'Stratford', 'CT');
insert into zipCode(zip, city, state)
	values('06801', 'Bethel', 'CT');
insert into zipCode(zip, city, state)
	values('12601', 'Poughkeepsie', 'NY');
insert into zipCode(zip, city, state)
	values('12538', 'Hyde Park', 'NY');
insert into zipCode(zip, city, state)
	values('12524', 'Fishkill', 'NY');


-- Job Roles
insert into jobRole(jobID, name, description)
	values('j001', 'Security', 'Protects people');
insert into jobRole(jobID, name, description)
	values('j002', 'Food vendor', 'Sells food to attendees');
insert into jobRole(jobID, name, description)
	values('j003', 'Merchandise vendor', 'Sells shirts and the like to attendees');
insert into jobRole(jobID, name, description)
	values('j004', 'Ticket seller', 'Hands out tickets');
insert into jobRole(jobID, name, description)
	values('j005', 'Stage crew', 'Helps set up bands on stage');
insert into jobRole(jobID, name, description)
	values('j006', 'Groundskeeper', 'Keeps festival grounds clean');


-- Shifts
insert into shift(shiftNum, startTime, endTime)
	values('1', '09:00:00', '14:00:00');
insert into shift(shiftNum, startTime, endTime)
	values('2', '14:00:00', '19:00:00');
insert into shift(shiftNum, startTime, endTime)
	values('3', '19:00:00', '00:00:00');


-- Person
insert into person(pid, firstName, lastName, address, zip)
	values('p000001', 'Andrew', 'Apple', '123 Fake St', '06614');
insert into person(pid, firstName, lastName, address, zip)
	values('p000002', 'Bobby', 'Bacon', '456 Fake St', '12601');
insert into person(pid, firstName, lastName, address, zip)
	values('p000003', 'Carmen', 'Cactus', '789 Fake St', '06801');
insert into person(pid, firstName, lastName, address, zip)
	values('p000004', 'Dilbert', 'Dingbat', '3399 North Rd', '12601');
insert into person(pid, firstName, lastName, address, zip)
	values('p000005', 'Elie', 'Elephant', '1 Bulldog Boulevard', '06614');

insert into person(pid, firstName, lastName, address, zip)
	values('p000006', 'Frank', 'Foodie', '283 Music St', '12538');
insert into person(pid, firstName, lastName, address, zip)
	values('p000007', 'George', 'Giraffe', '184 Costanza Lane', '06614');
insert into person(pid, firstName, lastName, address, zip)
	values('p000008', 'Harry', 'Hamburger', '128 Lane St', '06701');
insert into person(pid, firstName, lastName, address, zip)
	values('p000009', 'Iago', 'Igloo', '1485 Cherry Lane','06801');
insert into person(pid, firstName, lastName, address, zip)
	values('p000010', 'Jimmy', 'James', '485 Peach St', '06701');

insert into person(pid, firstName, lastName, address, zip)
	values('p000011', 'Tom', 'Araya', '582 Metal Lane', '06701');
insert into person(pid, firstName, lastName, address, zip)
	values('p000012', 'Kerry', 'King', '293 Street Lane', '06614');
insert into person(pid, firstName, lastName, address, zip)
	values('p000013', 'Jeff', 'Hanneman', '123 Heaven Rd', '06601');
insert into person(pid, firstName, lastName, address, zip)
	values('p000014', 'Dave', 'Lombardo', '482 Fake St', '12601');
insert into person(pid, firstName, lastName, address, zip)
	values('p000015', 'Geddy', 'Lee', '48 Fake Rd', '06614');
insert into person(pid, firstName, lastName, address, zip)
	values('p000016', 'Neil', 'Peart', '123 Marist St', '12601');
insert into person(pid, firstName, lastName, address, zip)
	values('p000017', 'Alex', 'Lifeson', '456 Marist St', '06701');

insert into person(pid, firstName, lastName, address, zip)
	values('p000018', 'Ozzy', 'Osbourne', '482 Druggy Lane', '12601');


-- Event Worker
insert into eventWorker(pid, salary)
	values('p000001', '2000');
insert into eventWorker(pid, salary)
	values('p000002', '3000');
insert into eventWorker(pid, salary)
	values('p000003', '4000');
insert into eventWorker(pid, salary)
	values('p000004', '5000');
insert into eventWorker(pid, salary)
	values('p000005', '6000');


-- Attendee
insert into attendee(pid, seatStatus)
	values('p000006', 'Grass');
insert into attendee(pid, seatStatus)
	values('p000007', 'Pit');
insert into attendee(pid, seatStatus)
	values('p000008', 'Grass');
insert into attendee(pid, seatStatus)
	values('p000009', 'Pit');
insert into attendee(pid, seatStatus)
	values('p000010', 'VIP');


-- Band Members
insert into bandMember(pid, instrument)
	values('p000011', 'Vocals');
insert into bandMember(pid, instrument)
	values('p000012', 'Guitar');
insert into bandMember(pid, instrument)
	values('p000013', 'Guitar');
insert into bandMember(pid, instrument)
	values('p000014', 'Drums');
insert into bandMember(pid, instrument)
	values('p000015', 'Vocals');
insert into bandMember(pid, instrument)
	values('p000016', 'Drums');
insert into bandMember(pid, instrument)
	values('p000017', 'Guitar');
insert into bandMember(pid, instrument)
	values('p000018', 'Vocals');


-- Bands
insert into bands(bandID, name, genre, yearFormed)
	values('b0001', 'Slayer', 'Thrash Metal', 1981);
insert into bands(bandID, name, genre, yearFormed)
	values('b0002', 'Rush', 'Progressive Rock', 1968);
insert into bands(bandID, name, genre, yearFormed)
	values('b0003', 'Black Sabbeth', 'Metal', 1968);


-- Stages
insert into stages(stageID, name, audienceSize)
	values('s001', 'Main Stage 1', 10000);
insert into stages(stageID, name, audienceSize)
	values('s002', 'Main Stage 2', 10000);
insert into stages(stageID, name, audienceSize)
	values('s003', 'Side Stage', 5000);
insert into stages(stageID, name, audienceSize)
	values('s004', 'Indoor Stage', 3000);


-- Tickets Sold
insert into ticketsSold(pid, stageID)
	values('p000006', 's001');
insert into ticketsSold(pid, stageID)
	values('p000007', 's001');
insert into ticketsSold(pid, stageID)
	values('p000008', 's002');
insert into ticketsSold(pid, stageID)
	values('p000009', 's003');
insert into ticketsSold(pid, stageID)
	values('p000010', 's004');


-- Members In Bands
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000011', 'b0001', 33);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000012', 'b0001', 33);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000013', 'b0001', 32);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000014', 'b0001', 21);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000015', 'b0002', 46);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000016', 'b0002', 46);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000017', 'b0002', 46);
insert into membersInBands(pid, bandID, yearsInBand)
	values('p000018', 'b0003', 41);


-- Schedule
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s001', 'b0001', '2012-01-01', '12:00:00', '14:00:00');
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s002', 'b0001', '2012-01-02', '15:00:00', '17:00:00');
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s001', 'b0002', '2012-01-01', '19:00:00', '21:00:00');
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s003', 'b0002', '2012-01-03', '10:00:00', '12:00:00');
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s001', 'b0003', '2012-01-03', '14:00:00', '16:00:00');
insert into schedule(stageID, bandID, datePlayed, startTime, endTime)
	values('s004', 'b0003', '2012-01-02', '20:00:00', '21:00:00');


-- Staff
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000001', 'j001', '2', '2012-01-01');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000001', 'j001', '3', '2012-01-01');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000002', 'j002', '1', '2012-01-02');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000003', 'j005', '1', '2012-01-02');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000003', 'j005', '1', '2012-01-03');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000004', 'j006', '3', '2012-01-01');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000005', 'j003', '1', '2012-01-01');
insert into staff(pid, jobID, shiftNum, dayWorking)
	values('p000005', 'j003', '1', '2012-01-02');

