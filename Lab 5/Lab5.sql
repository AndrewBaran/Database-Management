-- Andrew Baran
-- Professor Labouseur
-- Database Management

-- Lab 5


-- 1. Get the cities of agents booking an order for customer "Basics". This time use joins; no subqueries
select agents.city
from customers, orders, agents
where customers.cid = orders.cid
    and agents.aid = orders.aid
    and customers.name = 'Basics';


-- 2. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. 
--		Use joins this time; no subqueries
select distinct pid
from customers
    join
orders
on customers.cid = orders.cid
    join
agents
on agents.aid = orders.aid
    and customers.city = 'Kyoto'


-- 3. Get the names of customers who have never placed an order. Use a subquery
select name
from customers
where cid not in(select cid
                 from orders);


-- 4. Get the names of customers who have never placed an order. Use an outer join
select customers.name
from customers
    full outer join
orders
on customers.cid = orders.cid
where orders.ordno is null;


-- 5. Get the names of customers who placed at least one order through an agent in their city, 
--		along with those agent(s') names
select customers.name as customerName, agents.name as agentName
from customers, orders, agents
where customers.cid = orders.cid
    and agents.aid = orders.aid
    and customers.city = agents.city;


-- 6. Get the names of customers and agents in the same city, along with the name of the city, 
--		regardless of whether or not the customer has ever placed an order with that agent
select customers.name as customerName, customers.city, agents.name as agentName, agents.city
from customers, agents
where customers.city = agents.city;


-- 7. Get the name and city of customers who live in the city where the least number of products are made


-- Dallas: 455,900
-- Newark: 504,100
-- Duluth: 275,900
-- Total: 1,235,900

-- Answer:

-- Tiptop   |   Duluth
-- ACME     |   Duluth