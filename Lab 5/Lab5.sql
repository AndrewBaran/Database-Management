-- Andrew Baran
-- Professor Labouseur
-- Database Management

-- Lab 5


-- 1. Get the cities of agents booking an order for customer "Basics". This time use joins; no subqueries


-- 2. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. 
--		Use joins this time; no subqueries


-- 3. Get the names of customers who have never placed an order. Use a subquery
select name
from customers
where cid not in(select cid
                 from orders);



-- 4. Get the names of customers who have never placed an order. Use an outer join


-- 5. Get the names of customers who placed at least one order through an agent in their city, 
--		along with those agent(s') names


-- 6. Get the names of customers and agents in the same city, along with the name of the city, 
--		regardless of whether or not the customer has ever placed an order with that agent


-- 7. Get the name and city of customers who live in the city where the least number of products are made