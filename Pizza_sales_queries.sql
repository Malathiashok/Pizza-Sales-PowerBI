use pizza_db

select * from sales

drop table sales
### 1. Total revenue
select sum(total_price) as Total_Revenue from pizza_sales

## 2.Average Order Value
select sum(total_price)/count(distinct order_id) as Avg_Order_Value from sales

## 3.Total Pizzas Sold

select sum(quantity) as Total_pizzas_sold from sales

## 4. Total Orders
select count(distinct order_id) as Total_Orders from sales

## 5. Average Pizzas per Order
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizza_Order   from sales



select * from pizza_sales limit 5

# Change the datatype from text to time

UPDATE pizza_sales
SET order_time = STR_TO_DATE(order_time, '%H:%i:%s');
alter table pizza_sales
modify order_time time 

 # Change the datatype from text to date
 
 UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d:%m:%Y');
alter table pizza_sales
modify order_date time 

select day(order_date) as order_day, count(distinct order_id) as Total_orders 


## Daily Trend for Total Orders
select dayname(order_date) as order_day, count(distinct order_id) as Total_orders 
from pizza_sales group by dayname(order_date)


## Hourly Trend for Total Orders\
SELECT HOUR(order_time) AS Order_Hours, count(distinct order_id) as Total_orders 
FROM pizza_sales group by HOUR(order_time)
order by HOUR(order_time)


### Percentage of Sales by Pizza Category
select pizza_category, sum(total_price) as Total_sales,
sum(total_price)*100 / (select sum(total_price) from pizza_sales where month(order_date)=1)
as PCT from pizza_sales
where month(order_date)=1
group by pizza_category


## Perceantage of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales,
cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales where quarter(order_date) = 1 ) as decimal(10,2))as PCT
from pizza_sales
where quarter(order_date) = 1
group by pizza_size
order by PCT desc


## Total Pizzas sold by Pizza Category
select pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_category

## Top 5 Best Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as Total_Pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc limit 5


## Bottom 5 Worst Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as Total_Pizzas_sold
from pizza_sales
where month(order_date)=1
group by pizza_name
order by sum(quantity) limit 5



