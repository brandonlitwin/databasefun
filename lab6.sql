-- 1
select c.name, c.city
from customers c 
	inner join products p on c.city = p.city
group by c.name, c.city
having count(p.pid) > 2;
-- joins products to customers by city and finds which customers live in one of the cities that makes the most products (In this case it selected Dallas)

-- 2
select name
from products
where priceUSD > (select avg(priceUSD)
		  from products 
		 )
order by name DESC;
-- gets average priceUSD of products and selects products whose price is greater than the average

-- 3
select c.name, o.pid, sum(totalUSD)
from customers c
	inner join orders o on c.cid = o.cid
group by c.name, o.pid
order by sum(totalUSD) ASC;
-- joins customers to orders by cid and gets the customer name, pid, and sum of each customer's orders

-- 4
select c.name, coalesce(sum(totalUSD))
from customers c 
	inner join orders o on c.cid = o.cid
group by c.name 
order by name ASC;
-- joins customers to orders by cid and gets the customer name and sum of each customer's orders

-- 5
select c.name as "Customer", p.name as "Product", a.name as "Agent"
from customers c 
	inner join orders o on c.cid = o.cid
	inner join products p on p.pid = o.pid
	inner join agents a on a.aid = o.aid
where a.city = 'Newark';
-- joins each table and gets the name of the customers who ordered products from an agent in Newark

-- 6
select o.*, ((o.qty * p.priceUSD) - ((c.discount/100) * (o.qty * p.priceUSD))) as "My Calculation"
from orders o
	inner join customers c on c.cid = o.cid
	inner join products p on p.pid = o.pid
where o.totalUSD != ((o.qty * p.priceUSD) - ((c.discount/100) * (o.qty * p.priceUSD)));
-- joins customers and products to orders and compares the order's totalUSD to my calculated total, which I got by multiplying the order quantity by the price of each product and subtracting the customers's discount.

-- 7
/*
A left outer join will keep all the values from the left table in its result, and where the value on the right table does not match the value on the left table, it will show the left value but have NULL next to it under the right table's columns.
A right outer join will keep all the values from the right table in its result, and where the value on the left table does not match the value on the right table, it will show the right value but have NULL next to it under the left table's columns.
Here is a left outer join example in CAP:
select *
from customers c
	left outer join orders o on c.cid = o.cid 
	
This produces 15 rows because it shows the 14 orders and it shows the customer data of Weyland, who did not place an order, meaning that the order data in that row is all NULL.

Here is a right outer join example in CAP:
select *
from orders a
	right outer join agents o on a.aid = o.aid 
	
This produces 15 rows because it shows the 14 orders and it shows the agent data of Bond, who did not have an order placed through him, meaning that the order data in that row is all NULL. 

The difference between right and left outer join is that in a right outer join, all of the columns of the right table have their values shown, while everything that doesn't match on the left is NULL. In a left outer join, all of the columns of the left table have their values shown, while everything that doesn't match on the right is NULL.
*/