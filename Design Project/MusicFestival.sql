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
	zip 	integer,

	city	text,
	state 	text,

	primary key(zip)
);