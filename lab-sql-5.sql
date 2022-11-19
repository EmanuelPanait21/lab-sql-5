/*1.Drop column picture from staff.
2.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
4.Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
	1.Check if there are any non-active users
	2.Create a table backup table as suggested
	3.Insert the non active users in the table backup table
	4.Delete the non active users from the table customer

*/
use sakila;
select * from sakila.staff;
-- 1.Drop column picture from staff.
alter table sakila.staff 
drop column picture;

-- 2.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from sakila.customer where first_name = 'TAMMY';

insert into sakila.staff
values(3, 'TAMMY', 'SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org',2,1,'Tammy', null, current_timestamp);
select * from sakila.staff;

insert into sakila.staff
select address_id, store_id, active from sakila.customer;
select * from sakila.staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select inventory_id from  sakila.inventory 
where  film_id = 1
limit 1;

select film_id, title  from sakila.film 
where title = "Academy Dinosaur";

select staff_id, first_name, last_name from sakila.staff 
where first_name = 'Mike' and  last_name = 'Hillyer';

insert into sakila.rental
values(16050, current_timestamp, 1, 130, null, 1, current_timestamp);

select * from sakila.rental where inventory_id = 1;

-- 4.1. Check if there are any non_active users
select * from customer where active = 0;

-- 4.2. Create a table backup table as suggested
create table deleted_users(
customer_id int unique not null,
email varchar(50) default null,
`date` datetime default null,
constraint primary key(customer_id)
);

-- 4.3. Insert the non active users in the table backup table
insert into deleted_users(customer_id, email, date)
select customer_id, email, create_date
from customer
where active = 0;

select * from deleted_users;

-- 4.4. Delete the non active users from the table customer `films_2020.csv`
SET  global FOREIGN_KEY_CHECKS= 0;
delete from customer where active = 0;
SET  global FOREIGN_KEY_CHECKS=1;
select * from customer where active = 0;