-- Andrew Baran
-- Professor Labouseur
-- Database Management

-- Lab 4


-- 1. Get the cities of agents booking an order with customer "Basics"
select city
from agents
where aid in(select aid
             from orders
             where cid in(select cid
                          from customers
                          where name = 'Basics')
            )
order by city asc;


-- 2. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto
select distinct pid
from orders
where aid in(select aid
             from orders
             where cid in(select cid
                          from customers
                          where city = 'Kyoto')
            )
order by pid asc;


-- 3. Find the cids and names of customers who never placed an order through agent a03
select cid, name
from customers
where cid in(select cid
             from orders
                except
            select cid
            from orders
            where aid = 'a03');


-- 4. Get the cids and names of customers who ordered both product p01 and p07
select cid, name
from customers
where cid in(select cid
       from orders
       where pid = 'p01'
    intersect
       select cid
       from orders
       where pid = 'p07');


-- 5. Get the pids of products ordered by any customers who ever placed an order through agent a03
select distinct pid
from orders
where cid in(select cid
             from orders
             where aid = 'a03')
order by pid asc;


-- 6. Get the names and discounts of all customers who place orders through agents in Dallas or Duluth
select name, discount
from customers
where cid in(select cid
             from orders
             where aid in(select aid
                          from agents
                          where city = 'Dallas'
                              or city = 'Duluth')
            )
order by name asc;


-- 7. Find all customers who have the same discount as that of any customers in Dallas or Kyoto
select *
from customers
where discount in(select discount
                  from customers
                  where city = 'Dallas'
                      or city = 'Kyoto');