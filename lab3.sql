select ordNumber, totalUSD from Orders;

select name, city from Agents where name='Smith';

select pid, name, priceUSD from Products where quantity>200100;

select name, city from Customers where city='Duluth';

select name from Agents where city!='Duluth' and city!='New York';

select * from Products where city!='Dallas' and city!='Duluth' and priceUSD>=1.00;

select * from Orders where month='Feb' or month='May';

select * from Orders where month='Feb' and totalUSD>=600.00;

select * from Orders where cid='c005';


