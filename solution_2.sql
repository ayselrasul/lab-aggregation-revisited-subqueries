
use sakila;

##Instructions:

#Convert the query into a simple stored procedure

select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
  
#Creating procedure:

delimiter //
create procedure customer_details_per_category()
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
end;
//
delimiter ;


# Now keep working on the previous stored procedure to make it more dynamic. Update the
# stored procedure in a such manner that it can take a string argument for the category
# name and return the results for all customers that rented movie of that category/genre
#For eg., it could be action, animation, children, classics, etc

drop procedure if exists customer_details_per_category;

#Updating procedure:

delimiter //
create procedure customer_details_per_category (IN type varchar(50))
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = type
group by first_name, last_name, email;
end;
//
delimiter ;

#Calling function:
call customer_details('action');
call customer_details('animation');
call customer_details('children');
call customer_details('classics');
call customer_details('drama');


# Write a query to check the number of movies released in each movie category. Convert 
# the query into a stored procedure to filter only those categories that have movies 
# released greater than a certain number. Pass that number as an argument in the stored
# procedure

drop procedure if exists number_of_movies_per_category;

delimiter //
create procedure number_of_movies_per_category(IN parameter int)
Begin
select c.name,count(film_id)as number_of_films 
from film_category fc
join category c using(category_id)
group by c.name
having number_of_films > parameter;
End;
//
delimiter;



#Calling function:
Call number_of_movies_per_category(65);
Call number_of_movies_per_category(70);










   
   





