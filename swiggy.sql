/* Show all orders placed in Kolkata */
select * from swiggy
where city  = 'Kolkata';

/* Find the total number of orders */
select count(order_id) as total_order
from swiggy;

/* Display unique restaurant names */
select distinct restaurant_name
from swiggy;

/* Find orders with order_amount > 500 */
select * from swiggy
where order_amount > 500;

/* Show all cancelled orders */
select * from swiggy
where order_status = 'Cancelled';

/* Find total revenue per city */
select city, sum(order_amount) as revenue
from swiggy
where order_status = 'Delivered'
group by city
order by revenue desc;

/* Find number of orders per restauran */
select restaurant_name, count(order_id) as total_orders
from swiggy
group by restaurant_name
order by total_orders desc;

/* Find average order value per city */
select city, round(avg(order_amount),2) as avg_order
from swiggy
group by city
order by avg_order desc;

/* Get orders placed in March 2024 */
select *
from swiggy
where order_date between '2024-03-01' and '2024-03-31';

/* Find the first and last order date */
select 
max(order_date) as latest_date,
min(order_date) as first_date
from swiggy;

/* Find top 3 cities by total revenue */
select city, sum(order_amount) as total_revenue
from swiggy
where order_status = 'Delivered'
group by city
order by total_revenue desc
limit 3;

/* Find restaurants with more than 100 orders */
select restaurant_name, count(order_id) as total_orders
from swiggy
group by restaurant_name
having total_orders > 100;

/* Find cancellation percentage per city */
select city, round(100*sum(case when order_status = 'Cancelled' then 1 else 0 end)/count(order_id),2) as cancellation_percentage
from swiggy
group by city;

/* Find monthly revenue trend */
select date_format(order_date, '%Y-%m') as month, sum(order_amount) as total_revenue 
from swiggy
group by month
order by month;

/* Rank orders by order amount within each city */
select city, order_amount, rank()over(partition by city order by order_amount desc) as rank_city
from swiggy;

/* Find top 2 highest orders per city */
with cte_main as (
select  city, order_amount, row_number()over(partition by city order by order_amount desc) as rn
from swiggy
)
select * from cte_main
where rn<=2;

select count(order_id) 
from swiggy
where order_status ='Delivered'