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
select distinct o2.pid
from agents a, orders o1, orders o2, customers c
where a.aid = o1.aid
    and c.cid = o1.cid
    and a.aid = o2.aid
    and c.city = 'Kyoto'
order by o2.pid asc;


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
select customers.name, customers.city
from customers
where city in(select city
              from(select city, sum(quantity)
                   from products
                   group by city
                   order by sum(quantity) asc
                   limit 1
                   ) lowestCity
             );
