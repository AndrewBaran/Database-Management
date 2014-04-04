-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- April 1, 2014

-- Lab 8: Normalization Two



-- Drop tables if they already exist in the DBMS
drop table if exists actorsInMovies;
drop table if exists directorsInMovies;

drop table if exists actor;
drop table if exists director;
drop table if exists person;

drop table if exists zipCode;
drop table if exists movies;


-- Movies
create table movies
(
    mid     char(3) not null,

    name    text,
    yearReleased    integer,

    domesticSales   integer,
    foreignSales    integer,
    mediaSales  integer,

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
    pid     char(3) not null,

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
    pid     char(3) not null references person(pid),

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
    pid     char(3) not null references person(pid),

    filmSchool  text,
    dgAnniversaryDate   date,

    primary key(pid)
);


create table actorsInMovies
(
    mid     char(3) not null references movies(mid),

    pid     char(3) references actor(pid)
);


create table directorsInMovies
(
    mid     char(3) not null references movies(mid),

    pid     char(3) references director(pid)
);



-- Insert statements

-- Zip Codes
insert into zipCode(zip, city, state)
    values(11111, 'City1', 'CT');
insert into zipCode(zip, city, state)
    values(11112, 'City2', 'NY');
insert into zipCode(zip, city, state)
    values(11113, 'City3', 'NJ');

-- Person
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p01', 'Andrew', 'A', '1970-01-01', '111 Fake St', 11111);
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p02', 'Berry', 'B', '1970-01-02', '112 Fake St', 11112);
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p03', 'Sean', 'Connery', '1930-08-25', 'I cannot google it St', 11113); -- We share the same birthday

insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p04', 'Charlie', 'C', '1970-01-03', '113 Fake St', 11113);
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p05', 'Dennis', 'D', '1970-01-04', '114 Fake St', 11112);
insert into person(pid, firstName, lastName, birthDate, streetAddress, zip)
    values('p06', 'Elephant', 'E', '1970-01-05', '115 Fake St', 11111);



-- Actor
insert into actor(pid, hairColor, eyeColor, heightInInches, weight, sagAnniversaryDate)
    values('p01', 'Brown', 'Blue', '70', '150', '2011-01-01');
insert into actor(pid, hairColor, eyeColor, heightInInches, weight, sagAnniversaryDate)
    values('p02', 'Black', 'Hazel', '56', '200', '2011-01-02');
insert into actor(pid, hairColor, eyeColor, heightInInches, weight, sagAnniversaryDate)
    values('p03', 'White', 'Brown', '74', '180', '2011-01-03');


-- Directors
insert into director(pid, filmSchool, dgAnniversaryDate)
    values('p03', 'Harvard', '2011-08-25');
insert into director(pid, filmSchool, dgAnniversaryDate)
    values('p04', 'Marist', '2011-01-04');
insert into director(pid, filmSchool, dgAnniversaryDate)
    values('p05', 'Yale', '2011-01-05');
insert into director(pid, filmSchool, dgAnniversaryDate)
    values('p06', 'MIT', '2011-01-06');


-- Movies
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m01', 'Movie 1', 1971, 10000, 20000, 30000);
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m02', 'Movie 2', 1972, 40000, 50000, 60000);
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m03', 'Movie 3', 1973, 70000, 80000, 90000);
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m04', 'Movie 4', 1974, 100, 200, 300);
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m05', 'Movie 5', 1975, 400, 500, 600);
insert into movies(mid, name, yearReleased, domesticSales, foreignSales, mediaSales)
    values('m06', 'Movie 6', 1976, 700, 800, 900);


-- Actors In Movies
insert into actorsInMovies(mid, pid)
    values('m01', 'p01');
insert into actorsInMovies(mid, pid)
    values('m01', 'p03');

insert into actorsInMovies(mid, pid)
    values('m02', 'p01');
insert into actorsInMovies(mid, pid)
    values('m02', 'p02');
insert into actorsInMovies(mid, pid)
    values('m02', 'p03');

insert into actorsInMovies(mid, pid)
    values('m03', 'p02');

insert into actorsInMovies(mid, pid)
    values('m04', 'p01');
insert into actorsInMovies(mid, pid)
    values('m04', 'p02');

insert into actorsInMovies(mid, pid)
    values('m05', 'p02');
insert into actorsInMovies(mid, pid)
    values('m05', 'p03');

insert into actorsInMovies(mid, pid)
    values('m06', 'p01');


-- Directors In Movies
insert into directorsInMovies(mid, pid)
    values('m01', 'p04');

insert into directorsInMovies(mid, pid)
    values('m02', 'p06');

insert into directorsInMovies(mid, pid)
    values('m03', 'p04');
insert into directorsInMovies(mid, pid)
    values('m03', 'p05');

insert into directorsInMovies(mid, pid)
    values('m04', 'p05');

insert into directorsInMovies(mid, pid)
    values('m05', 'p04');

insert into directorsInMovies(mid, pid)
    values('m06', 'p04');
insert into directorsInMovies(mid, pid)
    values('m06', 'p05');
insert into directorsInMovies(mid, pid)
    values('m06', 'p06');