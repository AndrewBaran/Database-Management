-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- April 1, 2014

-- Lab 8: Normalization Two



-- Drop tables if they already exist in the DBMS
drop table if exists actor;
drop table if exists director;
drop table if exists person;

drop table if exists zipCode;
drop table if exists movies;


-- Movies
create table movies
(

    mid     char(4) not null,

    name    text,
    yearReleased    text,

    domesticSales   text,
    foreignSales    text,
    mediaSales  text,

    primary key(mid)

);


-- Zip code
create table zipCode
(
    zip     integer not null,

    city    text,
    state   char(2),

    primary key(zip)
);


-- Person
create table person
(
    pid     char(4) not null,

    firstName   text,
    lastName    text,
    birthDate   date,

    streetAddress   text,

    zip     integer references zipCode(zip),

    primary key(pid)

);


-- Actor
create table actor
(
    pid     char(4) not null references person(pid),

    hairColor   text,
    eyeColor    text,
    heightInInches  real,
    weight  real,

    sagAnniversaryDate  date,

    primary key(pid)
    
);


-- Director
create table director
(

    pid     char(4) not null references person(pid),

    filmSchool  text,
    dgAnniversaryDate   date,

    primary key(pid)

);




-- Insert statements

-- Zip Codes
insert into zipCode(zip, city, state)
    values(11111, 'City1', 'CT');
insert into zipCode(zip, city, state)
    values(11112, 'City2', 'NY');


-- Actor
insert into actor(pid, hairColor, eyeColor, heightInInches, weight, sagAnniversaryDate)
    values('p01', 'Brown', 'Blue', '70', '150', '2011-01-01');


-- Directors
insert into director(pid, filmSchool, dgAnniversaryDate)
    values('p02', 'Film1', '2012-01-01');



-- People
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p01', 'Andrew', 'A', '1970-01-01', '111 Fake St', 11111);
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p02', 'Berry', 'B', '1970-01-02', '112 Fake St', 11112);