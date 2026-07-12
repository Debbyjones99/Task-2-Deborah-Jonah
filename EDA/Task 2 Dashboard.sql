-- SELECT

--1. Display all records from the dataset.
select *
from decodelabs_dataset dd 

--2. Display only the OrderID, Product, Quantity, and TotalPrice columns.
select
	dd.orderid ,
	dd.product ,
	quantity,
	dd.totalprice 
from decodelabs_dataset dd 

-- WHERE
-- 3 Show all delivered orders.

select 
	dd.orderid ,
	dd.orderstatus 
from decodelabs_dataset dd 
where dd.orderstatus = 'Delivered'

-- 4 Show all orders with a TotalPrice greater than a specified amount (e.g., 1000)

select 
	dd.orderid ,
	dd.totalprice 
from decodelabs_dataset dd 
where dd.totalprice >= 1000

--ORDERED BY

-- 5 List all orders from the highest to the lowest TotalPrice.

select 
	dd.orderid,
	dd.totalprice 
from decodelabs_dataset dd 
order by dd.totalprice desc

--6 List orders by date (oldest to newest)

select 
	dd.orderid,
	date
from decodelabs_dataset dd 
order by date desc

-- GROUP BY 

-- 7 Which product sells the most?

select 
	dd.product ,
	SUM(dd.quantity ) quantity
from  decodelabs_dataset dd 
group by dd.product 
order by quantity desc

--8 Which product generates the most revenue?

select 
	dd.product ,
	SUM(dd.totalprice ) revenue
from  decodelabs_dataset dd 
group by dd.product 
order by revenue desc

-- 9 Which order status occurs most frequently?
select 
	dd.orderstatus ,
	count(dd.orderstatus) order_quantity
from decodelabs_dataset dd 
group by dd.orderstatus

-- Aggregations (COUNT, SUM, AVG)

-- How many orders are in the dataset?

select 
	count(*)
from decodelabs_dataset dd 

-- What is the average order value?

select  
	AVG(dd.totalprice )
from decodelabs_dataset dd 

-- What is the average number of items in a cart?

select 
	avg(dd.itemsincart )
from decodelabs_dataset dd  

-- Additional Business Questions

--Which month had the highest sales?

select 
	date_trunc('MONTH', DATE) as month,
	sum(dd.totalprice ) revenue
from decodelabs_dataset dd 
group by month
order by revenue desc

-- Are sales increasing or decreasing over time?

with revenue as (
select 
	date_trunc('month',date) as month,
	SUM(dd.totalprice ) revenue
from decodelabs_dataset dd 
group by date
)
select 
	month,
	revenue ,
	lag(revenue ) over (order by month) previous_month_rev
from revenue 

-- What are the top 10 highest-value orders?

select
	dd.orderid ,
	sum(dd.totalprice ) hvo
from decodelabs_dataset dd 
group by dd.orderid 
order by hvo desc
limit 10

-- Which products have the highest average selling price?

select 
	dd.product ,
	ROUND(avg(dd.unitprice), 2) Avg_selling_price
from decodelabs_dataset dd 
group by dd.product 
order by avg_selling_price desc

-- Which payment method generated the highest revenue?

select 
	dd.paymentmethod ,
	SUM(dd.totalprice) revenue
from decodelabs_dataset dd 
group by dd.paymentmethod 
order by revenue desc

-- Which referral source generated the highest revenue?
select 
	dd.referralsource,
	SUM(dd.totalprice) revenue
from decodelabs_dataset dd 
group by dd.referralsource 
order by revenue desc

-- Which order status contributed the most to total revenue?
select 
	dd.orderstatus ,
	SUM(dd.totalprice) revenue
from decodelabs_dataset dd 
group by dd.orderstatus  
order by revenue desc





































































