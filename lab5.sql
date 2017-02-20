-- 1
select city
from agents a inner join orders o on o.aid = a.aid 
where o.cid='c006'
-- joins agents and orders by aid and finds where cid='006'

-- 2
select pid
from orders o 
	inner join agents a on a.aid = o.aid
	inner join customers c on c.cid = o.cid
where c.city = 'Kyoto'
group by pid
-- joins agents and customers tables to orders table and finds where the city is Kyoto

-- 3
select name
from customers
where cid not in (select cid
		   from orders)
-- uses subquery to find which customers are not in orders

-- 4
select name
from customers c left outer join orders o on c.cid = o.cid
where o.ordnumber is null
-- uses left join to find which customers are not in orders

-- 5
select c.name as "Customer", a.name as "Agent"
from customers c 
	inner join orders o on c.cid = o.cid
	inner join agents a on a.aid = o.aid
where c.city = a.city
group by c.name, a.name
-- joins orders and agents to customers and finds where the customers ordered from agents in their city

-- 6
select c.name as "Customer", a.name as "Agent", c.city as "City"
from customers c 
	inner join agents a on c.city = a.city
where c.city = a.city
-- joins agents to customers and finds which agents live in the same city as customers

-- 7
select c.name, c.city
from customers c inner join products p on c.city = p.city
group by c.name, c.city
having count(p.pid) < 3
-- joins products to customers by city and finds which customers live in the city that makes the fewest products (Duluth makes 2 products).