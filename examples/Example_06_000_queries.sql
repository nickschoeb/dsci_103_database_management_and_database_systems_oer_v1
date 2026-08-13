-- use example 02
-- delete update

select * from people;

-- update a single record
select * from people where last_name = 'Graves';
update people set last_name = 'Smith' where last_name = 'Graves';
select * from people where last_name = 'Smith';

-- update all (see what happens probably not what we want)
update people set last_name = 'Smith';

-- delete one
delete from people where last_name = 'Smith';
delete from peoplecars;

-- use example 04
select * from customers;
select * from orders;

-- ok
delete from customers where customer_id = 1;

-- better
delete from orders where customerid = 1;
-- then delete customer
