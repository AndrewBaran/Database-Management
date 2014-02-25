-- Andrew Baran
-- Professor Labouseur
-- Database Managementi

-- Lab 6


-- 1. Get the name and city of customers who live in a city where the most number of products are made


-- 2. Get the name and city of customers who live in any city where the most number of products are made
select customers.name as customerName, customers.city
from customers
where city in (select city
               from products
               group by city
               having sum(quantity) = (select max(maximum)
                                       from (select city, sum(quantity) as maximum
                                             from products
                                             group by city
                                             order by sum(quantity) desc
                                            ) sumOfProducts
                                      )
              );


-- 3. List the products whose priceUSD is above the average priceUSD
select *
from products
where priceusd > (select avg(priceusd)
                  from products);


-- 4. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low
select customers.name, orders.pid, dollars
from customers join orders
on customers.cid = orders.cid
order by dollars desc;


-- 5. Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs
select customers.name, coalesce(sum(qty), 0) as totalOrdered
from customers left join orders
on customers.cid = orders.cid
group by customers.cid
order by customers.name asc;


-- 6. Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, and the names of the agents who sold it to them
select customers.name as customerName, products.name as productName, agents.name as agentName
from customers, orders, agents, products
where customers.cid = orders.cid
    and agents.aid = orders.aid
    and products.pid = orders.pid
    and agents.city = 'New York';


-- 7. Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in other tables and then comparing those values to the values in Orders.dollars
