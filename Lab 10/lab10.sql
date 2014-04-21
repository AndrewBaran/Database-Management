-- Andrew Baran
-- Professor Labouseur
-- Database Management
-- April 13, 2014

-- Lab 10


-- function PreReqsFor(courseNum) - Returns the immediate prerequisites for the passed-in course number
create or replace function PreReqsFor(IN courseNumber integer) returns setof integer as
$$
begin

    return query (select courses.num
                  from courses
                  where courses.num in (select prereqnum
                                        from prerequisites
                                        where prerequisites.coursenum = courseNumber));

end;
$$
language PLPGSQL;

-- End PreReqsFor()


-- function IsPreReqFor(courseNum) - Returns the courses for which the passed-in course number is an immediate pre-requisite
create or replace function IsPreReqFor(IN courseNumber integer) returns setof integer as
$$
begin

    return query (select prerequisites.courseNum
                  from prerequisites
                  where prerequisites.preReqNum = courseNumber);

end;
$$
language PLPGSQL;

-- End IsPreReqFor()