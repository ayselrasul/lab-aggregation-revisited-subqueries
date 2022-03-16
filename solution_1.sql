 use sakila;


# Select the first name, last name, and email address of all the customers who have rented a movie
 
 select distinct c.customer_id, c.first_name,c.last_name,c.email
 from rental r
 join customer c using(customer_id);


# What is the average payment made by each customer (display the customer id, 
# customer name(concatenated), and the average payment made)
 
  select customer_id,concat(first_name,' ',last_name) as full_name,
         avg(amount)as average_amount
  from customer c
  join payment p using(customer_id)
  group by customer_id,concat(first_name,' ',last_name);
  
  

# Select the name and email address of all the customers who have rented the "Action" movies
# Write the query using multiple join statements

 select c.first_name,c.email
 from customer c
 left join rental r using(customer_id)
 join inventory i using(inventory_id)
 join film_category fc using(film_id)
 join category ct using(category_id)
 where ct.name = "Action";
 

# Write the query using sub queries with multiple WHERE clause and IN condition 
# Verify if the above two queries produce the same results or not
 
  select c.first_name,c.email
 from customer c
 left join rental r using(customer_id)
 join inventory i using(inventory_id)
 join film_category fc using(film_id)
 join category ct using(category_id)
 where ct.name IN (select name from category where name = "Action");



# Use the case statement to create a new column classifying existing columns as either
# or high value transactions based on the amount of payment. If the amount is between
# 0 and 2, label should be low and if the amount is between 2 and 4, the label should 
# be medium, and if it is more than 4, then it should be high

select *,
case 
   when amount between 0 and 2 then "low"
   when amount between 2 and 4 then "medium"
   when amount > 4 then "high"
End as amount_classifier 
from payment;

