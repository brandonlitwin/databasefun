-- Brandon Litwin, CMPT 308N, 2/12/17
-- 1
select city 
from agents
where aid in (select aid 
             from orders
             where cid = 'c006'
             );

-- 2
select distinct pid
from orders
where aid in (select aid 
              from orders
              where cid = (select cid 
             		   from customers
              		   where city = 'Kyoto') kyoto_customers
              ) agents
order by pid DESC;

-- 3
select cid, name
from customers
where cid not in (select cid
                  from orders
                  where aid = 'a01'
		 );

-- 4
select cid
from orders
where pid in ('p01','p07')    
group by cid
having count(pid) = 2;

-- 5
select distinct pid
from orders
where cid not in (select cid
                  from orders
                  where aid = 'a08'
                  ) cid_from_agent08
order by pid DESC;

-- 6
select name, discount, city
from customers
where cid in (select cid
              from orders
              where aid in (select aid
                            from agents
                            where city in ('Tokyo', 'New York')
                            ) tokyo_or_newyork_agents
              ) cid_from_agents;
-- 7
select * 
from customers
where city not in ('Duluth', 'London')
and discount in (select discount
                  from customers
                  where city in ('Duluth', 'London')
                  );
/*
Check constraints in SQL are used in creating a table to restrict the values that can be 
placed inside. They are done by adding a line in the CREATE TABLE statement with the 
keyword CHECK and then the name of the column and the condition. The advantage of having
check constraints is that it is a preventative measure that can eliminate the hassle of 
removing bad data after it is already added to the table.

A good use of a check constraint is if you have a column called CITY in the table AGENTS, 
and you know that there are only five different cities where you've hired agents, 
then you can add a CHECK to the CITY column that checks if the city is one of those five names.
If it is not, then you know something must be wrong with the data and it should not be 
added to the table. 

A bad use of a check constraint is if you are checking a value of a column that has a VARCHAR(30) 
data type and then you add a check where the condition is (value>=30). This is a bad check constraint 
because it is unneccesary. The table automatically rejects values that are larger than 30 because that
is how much space it was allotted during creation. A check constraint should do the job of limiting
the values in ways that cannot be done during creation, like only allowing one of five cities to be entered.

Information found on w3schools
*/
