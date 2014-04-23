-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- 4/20/2014

-- Design Project: Music Festival


-- Drop views if they already exist in the DBMS
drop view if exists bandInformation;
drop view if exists completeSchedule;
drop view if exists employeeSchedule;
drop view if exists customerData;

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
drop table if exists tickets;


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
	description	text,

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


-- Tickets
create table tickets
(
	ticketID	char(4) not null,

	ticketName	text,
	timeLength	integer,
	seatArea	text,
	priceUSD	real,

	primary key(ticketID)
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

	salaryUSD	real,

	primary key(pid)
);


-- Attendee
create table attendee
(
	pid		char(7) not null references person(pid),

	age		integer,

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
	ticketID	char(4) not null references tickets(ticketID),

	primary key(pid, ticketID)
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


-- Tickets
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t001', 'One Day Grass', 1, 'Grass', 10);
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t002', 'Three Day Grass', 3, 'Grass', 25);
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t003', 'One Day Pit', 1, 'Pit', 30);
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t004', 'Three Day Pit', 3, 'Pit', 80);
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t005', 'One Day VIP', 1, 'VIP', 100);
insert into tickets(ticketID, ticketName, timeLength, seatArea, priceUSD)
	values('t006', 'Three Day VIP', 3, 'VIP', 250);



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
insert into eventWorker(pid, salaryUSD)
	values('p000001', 15);
insert into eventWorker(pid, salaryUSD)
	values('p000002', 20);
insert into eventWorker(pid, salaryUSD)
	values('p000003', 25);
insert into eventWorker(pid, salaryUSD)
	values('p000004', 30);
insert into eventWorker(pid, salaryUSD)
	values('p000005', 40);


-- Attendee
insert into attendee(pid, age)
	values('p000006', 18);
insert into attendee(pid, age)
	values('p000007', 25);
insert into attendee(pid, age)
	values('p000008', 32);
insert into attendee(pid, age)
	values('p000009', 44);
insert into attendee(pid, age)
	values('p000010', 59);


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
insert into ticketsSold(pid, ticketID)
	values('p000006', 't001');
insert into ticketsSold(pid, ticketID)
	values('p000007', 't001');
insert into ticketsSold(pid, ticketID)
	values('p000008', 't002');
insert into ticketsSold(pid, ticketID)
	values('p000009', 't003');
insert into ticketsSold(pid, ticketID)
	values('p000010', 't004');


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
	values('s001', 'b0002', '2012-01-01', '14:00:00', '16:00:00');
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



-- Views

-- View that allows a person to see each band member, their associated band, instrument played, and years played.
create view bandInformation as

    select person.firstName, person.lastName, bands.name as bandName, bandMember.instrument, membersInBands.yearsInBand
    from bands, bandMember, membersInBands, person
    where bands.bandID = membersInBands.bandID
        and bandMember.pid = membersInBands.pid
        and person.pid = bandMember.pid;


-- View that gives a complete, accurate, and minimal necessary schedule of all the bands
create view completeSchedule as 

    select stages.name as stageName, bands.name as bandName, schedule.datePlayed, schedule.startTime, schedule.endTime 
    from schedule, bands, stages
    where schedule.bandID = bands.bandID
        and schedule.stageID = stages.stageID;


-- View that shows the full employee schedule
create view employeeSchedule as

    select person.firstName, person.lastName, staff.dayWorking, shift.shiftNum, jobRole.name as jobName, shift.startTime, shift.endTime
    from staff, jobRole, shift, eventWorker, person
    where staff.jobID = jobRole.jobID
        and staff.shiftNum = shift.shiftNum
        and staff.pid = eventWorker.pid
        and eventWorker.pid = person.pid;


-- View that shows all customer information
create view customerData as

    select person.firstName, person.lastName, attendee.age, tickets.ticketName, tickets.priceUSD
    from ticketsSold, attendee, person, tickets
    where ticketsSold.pid = attendee.pid
        and ticketsSold.ticketID = tickets.ticketID
        and attendee.pid = person.pid;


-- Triggers

-- Prevent chaning of salary to negative
create or replace function validateInfo() returns trigger as
$$
begin
	if new.salaryUSD < 0 then
		update eventWorker
		set salaryUSD = old.salaryUSD 
		where pid = new.pid;

		raise notice 'Warning: Cannot change salary to a negative value';
	end if;

	return new;
end
$$
language PLPGSQL;


create trigger validateSalary
after update on eventWorker
for each row
execute procedure validateInfo();


-- Prevent two bands from being in the same timeslot
create or replace function preventConflict() returns trigger as
$$
declare
	conflictNumber integer;
begin
	select count(*) into conflictNumber
	from schedule
	where datePlayed = new.datePlayed
		and startTime = new.startTime;

	if conflictNumber > 1 then
		delete from schedule
		where new.stageID = stageID
			and new.bandID = bandID
			and new.datePlayed = datePlayed
			and new.startTime = startTime;

		raise notice 'Conflicting time slot: You cannot enter two bands for the same time';
		
		return null;
	end if;

	if conflictNumber <= 1 then
		return new;
	end if;
	

end
$$
language PLPGSQL;


create trigger conflictManagement
after insert on schedule
for each row
execute procedure preventConflict();


-- Prevent underage attendees (18 years or less)
create or replace function preventUnderage() returns trigger as
$$
begin

	if new.age < 18 then
		delete from attendee
		where new.pid = pid;

		raise notice 'Warning: Attendents of the festival must be 18 years or older';

		return null;
	end if;

	if new.age >= 18 then
		return new;
	end if;

end
$$ language PLPGSQL;


create trigger ageCheck
after insert on attendee
for each row
execute procedure preventUnderage();


-- Queries and reports

-- Query that allows management to see the sales numbers in terms of tickets sold, which tickets were sold, and the profit from that sales.
select tickets.ticketName, priceUSD, count as salesNumbers, (tickets.priceUSD * count) as profitUSD
from tickets
    join
(select ticketsSold.ticketID, count(ticketsSold.ticketID)
from ticketsSold
group by ticketsSold.ticketID) ticketSales
on tickets.ticketID = ticketSales.ticketID
order by profitUSD desc;


-- Query that gets the average age of the attendees of the festival
select round(avg(attendee.age), 2) as averageAge
from attendee;


-- Query that gets the number of attendees from each state
select zipCode.state, count(zipCode.state) as population
from person, attendee, zipCode
where person.pid = attendee.pid
    and person.zip = zipCode.zip
group by zipCode.state;


-- Query that shows how many hours total each stage is being used
select stages.name as stageName, sum((extract(minute from endTime - startTime) / 60.0) + extract (hour from endTime - startTime)) as hoursUsed
from schedule, stages
where schedule.stageID = stages.stageID
group by stages.name
order by hoursUsed desc;


-- Security permissions

-- Attendees
drop role if exists attendee;
create role attendee;

grant select on completeSchedule to attendee;
grant select on bandInformation to attendee;


-- Ticket Office
drop role if exists ticketOffice;
create role ticketOffice;

grant select on tickets to ticketOffice;
grant select, insert, update, delete on ticketsSold to ticketOffice;
grant select, insert, update, delete on attendee to ticketOffice;


-- Security Personel
drop role if exists securityOfficial;
create role securityOfficial;

grant select, delete on person to securityOfficial;
grant select, delete on attendee to securityOfficial;
grant select on employeeSchedule to securityOfficial;


-- Management
drop role if exists management;
create role management;

grant select, insert, update, delete on jobRole to management;
grant select, insert, update, delete on staff to management;
grant select, insert, update, delete on schedule to management;
grant select, insert, update, delete on eventWorker to management;
grant select, insert, update, delete on tickets to management;
grant select on employeeSchedule to management;
grant select on completeSchedule to management;


-- Database administrator
drop role if exists databaseManager;
create role databaseManager;

grant all privileges on all tables in schema public to databaseManager;