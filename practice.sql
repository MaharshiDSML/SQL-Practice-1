#Q1: Display product_id and product_name for all the products
SELECT product_id,product_name
FROM `farmers_market.product`;


#Q2: Display all details for all the products
SELECT *
FROM `farmers_market.product`;


#Q3: Explore vendor_booth_assignments. List down 10 rows of farmer’s marketvendor booth assignments, displaying the market date, vendor ID, and booth number from the vendor_booth_assignments table.
select *
from `farmers_market.vendor_booth_assignments`
limit 10;


#Q4: Sort the vendor booth assignment data by Date
select *
from `farmers_market.vendor_booth_assignments`
order by market_date
limit 10;


#Q5: Sort the customer purchases data by date. Most recent orders on top
select *
from `farmers_market.customer_purchases`
order by market_date desc;


#Q6: Sort the vendor booth assignment data by Date in decreasing order and Vendor in ascending order
select *
from `farmers_market.vendor_booth_assignments`
order by market_date desc, vendor_id;


#Q7: Fetch the details of 3rd most recent order from top
select *
from `farmers_market.customer_purchases`
order by market_date desc
limit 1 offset 2;


#Q8: From the customer purchases table, query the total amount that the customer has paid[inline calculation, alias]
select *,
quantity * cost_to_customer_per_qty as total_cost
from `farmers_market.customer_purchases`;


#Q9: Display quantity column rounded to 1 decimal places
select 
customer_id,
product_id,
round(quantity, 1) as quantity
from `farmers_market.customer_purchases`;


#Q10: Display a new column with full name of customers
select *,
concat(customer_first_name,' ', customer_last_name) as cust_full_name
from `farmers_market.customer`
limit 5;


#Q11: Display all full names in all caps
select *,
UPPER(concat(customer_first_name,' ',customer_last_name)) as customer_full_name
from `farmers_market.customer`
limit 5;


#Q12: Extract all the product names that are part of product category 1
select product_name
from `farmers_market.product`
where product_category_id = 1;


#Q13: Extract all products that have size medium
select *
from `farmers_market.product`
where product_size = 'medium';


#Q14: Extract all products that have size small and product category 1
select *
from `farmers_market.product`
where product_size = 'small' AND product_category_id = 1;


#Q15: Extract all products that have product category 2 or product name Carrots
select *
from `farmers_market.product`
where product_category_id = 2 OR product_name = 'Carrots'; 


#Q16: Extract all product_ids greater than 3
select *
from `farmers_market.product`
where product_id > 3
order by product_id;


#Q17: If you wanted to find out what booths vendor no 3 was assigned to on or before April 20, 2019.
select *
from `farmers_market.vendor_booth_assignments`
where vendor_id = 3 AND market_date <= '2019-04-20';


#Q18: Extract products with ids between 3 and 8 ( both exclusive)
select *
from `farmers_market.product`
where product_id > 3 and product_id < 8;


#Q19: Find the booth assignments for vendor 7 for any market date that occurred between April 3, 2019, and May 16, 2019, including both the dates
select *
from `farmers_market.vendor_booth_assignments`
where vendor_id = 7 and market_date between '2019-04-03' and '2019-05-16';


#Q20: Select products which are small, medium or large
select *
from `farmers_market.product`
where product_size IN ('small', 'medium', 'large');


#Q21: Select products which are not small, medium or large
select *
from `farmers_market.product`
where product_size not IN ('small', 'medium', 'large');


#Q22: Find all the products from the product table withouit sizes
select *
from `farmers_market.product`
where product_size is null;


-- query to find blank spaces
select *
from `farmers_market.product`
where product_size = ' ';


-- query blanks and nulls in one query
select *
from `farmers_market.product`
where product_size is null or product_size = ' ';


-- the below query wont work because IN keyword does not work with null
SELECT *
FROM `farmers_market.product`
where product_size in (null, ' ');


#Q23: Replace missing product size(null only) with ‘missing_value’(introducing ifnull function)
select product_id, ifnull(product_size, 'missing value') as product_size
from `farmers_market.product`;


-- replace blank values with 'missing value' (introducing replace function)
SELECT
product_id,
replace(product_size, ' ', 'missing value') as product_size
FROM `farmers_market.product`;


#Q24: Find all customers whose first names starts with a 'J'
select *
from `farmers_market.customer`
where lower(customer_first_name) like 'j%';


#Q25: Find all customers whose first names ends with an 'e'
select *
from `farmers_market.customer`
where upper(customer_first_name) like '%E';


#Q26: Get customers with first name starting with J and last name ending with e and sort the results by first and last name respectively
select *
from `farmers_market.customer`
where lower(customer_first_name) like 'j%'and lower(customer_last_name) like '%e'
order by customer_first_name, customer_last_name;


#Q27: For every vendor identify the ones who deals with 'fresh' produce and those who dont
select *,
case
  when lower(vendor_type) like '%fresh%'
  then 1
  else 0
end as fresh_or_not
from `farmers_market.vendor`;


#Q28: Get all the details of the products where product_category contains ‘Fresh’
--to check
select *
FROM `farmers_market.product`;

--to check
select *
FROM `farmers_market.product_category`;

-- inner query
select product_category_id
from `farmers_market.product_category`
where lower(product_category_name) like '%fresh%';

-- finish the whole query
select *
from `farmers_market.product`
WHERE product_category_id IN (select product_category_id
from `farmers_market.product_category`
where lower(product_category_name) like '%fresh%');


#Q29: List all the products along with their product category name.
select *
from `farmers_market.product` as p
left join `farmers_market.product_category` as pc
on p.product_category_id = pc.product_category_id;


#Q30: List all the products along with their product category name. Include product categories that don’t have any products associated to them
select *
from `farmers_market.product` as p
right join `farmers_market.product_category` as pc
on p.product_category_id = pc.product_category_id;


#Q31: List all product categories that do not have a product associated with it
select *
from `farmers_market.product` as p
right join `farmers_market.product_category` as pc
on p.product_category_id = pc.product_category_id
where p.product_category_id is null;


#Q32: List all the customers who have placed at least 1 order.
select distinct c.*
from `farmers_market.customer` c
join `farmers_market.customer_purchases` cp
on c.customer_id = cp.customer_id;


#Q33: Display all employess who earn more than their manager

select
e.employee_id,
e.manager_id,
e.salary,
m.salary as manager_salary
from `hr.employees` e
join `hr.employees`m
ON e.manager_id = m.employee_id
where m.salary < e.salary;


-- aggregate functions --


#Q34: Get count of all the employees in the company
select count(employee_id) as employee_count
from `hr.employees`;


#Q35: Display the min, max and average salary of employees
select min(salary) as min_salary, max(salary) as maxa_salary, avg(salary) as avg_salary
from `hr.employees`;


#Q36: Count the different product sizes available
select count(distinct product_size) as diff_prods_sizes, count(product_id) as num_of_products
from `farmers_market.product`;


#Q37: Find total number of products with product size medium
select count(product_id) as no_of_prods
from `farmers_market.product`
where product_size = 'medium';


#Q38: Find total number of products for different product sizes
select product_size, count(product_id) as diff_no_of_prods 
from `farmers_market.product`
group by product_size;


#Q39: Find total number of products for different product sizes and display results for small medium and large
select product_size, count(product_id) as no_of_prods
from `farmers_market.product`
where product_size in ('small', 'medium', 'large')
group by product_size;


#Q40: Count number of order by each customer
select customer_id, count(*) as order_count 
from `farmers_market.customer_purchases`
group by customer_id
order by customer_id;


#Q41: Count number of orders by each customer per market date
select customer_id, market_date, count(*) as order_count
from `farmers_market.customer_purchases`
group by customer_id, market_date
order by customer_id, market_date;


#Q42: Calculate total quantity purchased by each customer per market date
select customer_id, market_date, sum(quantity) as total_qty
from `farmers_market.customer_purchases`
group by customer_id, market_date
order by customer_id, market_date;


#Q43: How many kinds of products were purchased by each customer on each market date?
select market_date, customer_id, count(distinct product_id) as product_count
from `farmers_market.customer_purchases`
group by market_date, customer_id
order by customer_id, market_date;


#Q44: Find total price paid by customer_id 3 per market date
select market_date, customer_id, sum(quantity * cost_to_customer_per_qty) as total_cost
from `farmers_market.customer_purchases`
where customer_id = 3
group by market_date, customer_id
order by market_date; 


#Q45: Find the least and max quantity purchased by any customer
select customer_id, max(quantity) as max_quant, min(quantity) as min_quant
from `farmers_market.customer_purchases`
group by customer_id
order by customer_id;


#Q46: Display all product categories names that have more than 2 products[MEDIUM]
select pc.product_category_name, count(p.product_id)
from `farmers_market.product_category` pc
inner join `farmers_market.product` p
on pc.product_category_id = p.product_category_id 
group by pc.product_category_name
having count(p.product_id) > 2;


#Q47: Find customers with more than 30 orders
select customer_id, count(*) as cust_with_more_than_30_ordrers
from `farmers_market.customer_purchases`
group by customer_id
having count(*) > 30; 


#Q48: Display all products alongwith total no of orders for that product if no of orders exceed 200
select product_id, count(*) as total_orders
from `farmers_market.customer_purchases`
group by product_id
having count(*) > 200
order by product_id;


#Q49: Find the average amount spent on each market day. We want to consider only those days where the no of purchases were more than 3 and the transaction amount of an order was greater than 5
--tbl- customer purchases
--col- market_date, avg_cost, to be created- total_orders
--clauses- group by, having after groupby, where b4 group by
select market_date, avg(quantity * cost_to_customer_per_qty) as avg_cost
from `farmers_market.customer_purchases`
where quantity * cost_to_customer_per_qty > 5
group by market_date
having count(*) > 3
order by market_date;


---- window functions ----


#Q47: Display avg salary of all employees in a new column in the employees table.
select *, avg(salary) over() as avg_salary
from `hr.employees`;


#Q48: Display the average salary of employees in each department as a new column next to the respective employee belonging in the corresponding department
select employee_id, department_id, salary,
avg(salary) over(partition by department_id) as avg_salary
from `hr.employees`
order by department_id;


#Q49: Display details of employees with salary > average salary
select employee_id, salary, avg_salary
from
(select *, avg(salary) over() as avg_salary
from `hr.employees`) tbl
where salary > avg_salary
order by employee_id;


#Q50: Display details of employees with salary > department average salary
select *
from
(select employee_id, department_id, salary,
avg(salary) over(partition by department_id) as dept_avg_salary
from `hr.employees`
order by department_id) tbl
where salary > dept_avg_salary;

-- initial join + group by solution --
select 
e.employee_id, e.department_id, ds.dept_avg_salary, e.salary
from
(select department_id, avg(salary) as dept_avg_salary
from `hr.employees`
group by department_id) ds
inner join `hr.employees` e
on ds.department_id = e.department_id
where e.salary > ds.dept_avg_salary;

--implement ranking functions on employees based on highest salary. Do this at a department level

select 
employee_id, 
department_id, 
salary,
row_number() over(partition by department_id order by salary desc) as row_num,
rank() over(partition by department_id order by salary desc) as salary_rank,
dense_rank() over(partition by department_id order by salary desc) as salary_dense_rank
from `hr.employees`
order by department_id;

-- without partition by
select 
employee_id, 
department_id, 
salary,
row_number() over(order by salary desc) as row_num,
rank() over(order by salary desc) as salary_rank,
dense_rank() over(order by salary desc) as salary_dense_rank
from `hr.employees`
order by salary_dense_rank;


#Q51: Fetch top 2 employees from each department based on salary. No more than 2 employees in each department.
select *
from
(select 
employee_id, 
department_id, 
salary,
row_number() over(partition by department_id order by salary desc) as row_num,
from `hr.employees`
order by department_id) tbl 
where row_num <= 2;


#Q52: Fetch details of employees with top 3 salaries. Display all people if salaries are same.
select *
from
(select 
employee_id, 
department_id, 
salary,
dense_rank() over(order by salary desc) as salary_dense_rank
from `hr.employees`
order by department_id) tbl 
where salary_dense_rank <= 3;


#Q53: From each department, display the person with max salary. Display multiple people if they have same salary.
select *
from
(select 
employee_id, 
department_id, 
salary,
dense_rank() over(partition by department_id order by salary desc) as salary_dense_rank
from `hr.employees`
order by department_id) tbl 
where salary_dense_rank = 1;


#Q54: From each department, display the person with the 3rd highest salary.
-- HW -- apply rownum and then where clause


#Q55: Display running or cumulative sum of salaries in each department in the order of joining dates of employees
select
employee_id, department_id, hire_date,salary,
sum(salary) over(partition by department_id) dept_total_salary,
sum(salary) over(partition by department_id order by hire_date) dept_running_salary
from `hr.employees`
order by department_id, hire_date;


#Q56: For every employee, display their details. Also display the salary of the next highest earning employee. Use the new column to calculate salary difference
select employee_id, department_id, hire_date, salary,
lead(salary) over(order by salary) as next_salary,
lead(salary) over(order by salary) - salary as salary_difference
from `hr.employees`
order by salary;


#Q57: Display moving sum of salaries in each department in the order of joining dates of employees. moving window size is 3
select
employee_id, department_id, hire_date, salary,
sum(salary) over(partition by department_id order by hire_date) as running_salary,
sum(salary) over(partition by department_id order by hire_date rows between unbounded preceding and current row) as running_salary_wf,
sum(salary) over(partition by department_id order by hire_date rows between 1 preceding and 1 following ) as running_salary_wf
from `hr.employees`
order by department_id, hire_date;

-- first value and last value --

select
employee_id, department_id, hire_date, salary,
first_value(salary) over(partition by department_id order by salary) as first_salary,
first_value(salary) over(partition by department_id order by salary desc) as last_salary
from `hr.employees`
order by department_id desc, hire_date;


select
employee_id, department_id, hire_date, salary,
last_value(salary) over(partition by department_id order by salary) as last_salary,
last_value(salary) over(partition by department_id order by salary rows between unbounded preceding and unbounded following) as last_salary_1
from `hr.employees`
order by department_id desc, hire_date;


#Q58: Divide the salary of employees column into 5 quantiles. The 1st quantile should represent the lowest salaries and 5th should represent the highest salaries
select
employee_id, department_id, hire_date, salary,
ntile(5) over(order by salary) as salary_quantile,
ntile(5) over(order by salary desc) as salary_quantile_reverse 
from `hr.employees`
order by salary_quantile_reverse;


--- date and time ---


#Q59: Tell the joining months of all employees
select
employee_id, hire_date,
extract(month FROM hire_date) as hire_month
from `hr.employees`;


#Q60:Extract employees hired in June
select
employee_id, hire_date,
extract(month FROM hire_date) as hire_month
from `hr.employees`
where extract(month from hire_date) = 6;


#Q61: Fetch the count of employees based on the hire year
select hire_year, count(employee_id) as emp_count
from
(select
*, extract(year FROM hire_date) as hire_year
from `hr.employees`)
group by hire_year
order by hire_year;


--current date and time

select current_date(), current_datetime('Asia/Kolkata'), current_timestamp();


#Q62: Find The tenure of all employees in company till date
select
employee_id, hire_date, salary,
current_date() - hire_date as tenure,
date_diff(current_date(), hire_date, year) as tenure_year,
date_diff(current_date(), hire_date, month) as tenure_month,
date_diff(current_date(), hire_date, day) as tenure_day
from `hr.employees`;

-- try the current_datetime and datetime_diff ( H. W )

--date_add()

select 
date_add(current_date(), interval 7 day),
date_add(current_date(), interval 7 week),
date_add(current_date(), interval 1 year),
date_sub(current_date(), interval 1 year);


#Q63: For each employee, Find the time period between the company’s start date and the employee’s joining date
select
employee_id, hire_date, salary,
first_value(hire_date) over(order by hire_date) as company_start_date,
date_diff(hire_date, first_value(hire_date) over(order by hire_date), year) as hire_lag
from `hr.employees`;


#Q64: Find all employees who joined within 2 years of company’s inception
select *
from
(select
employee_id, hire_date,
first_value(hire_date) over(order by hire_date) as company_start_date,
date_diff(hire_date, first_value(hire_date) over(order by hire_date), year) as hire_lag
from `hr.employees`) as tbl
where hire_lag <= 2;


-- how to deal with multiple dateparts --

SELECT date_add(date_add(current_date(), interval 7 week), interval 1 year);

-- solve previous question using CTE

#Q65: Find all employees who joined within 2 years of company’s inception
with cte as
(
  select
  employee_id, hire_date, 
  first_value(hire_date) over(order by hire_date) as company_start_date,
  from `hr.employees`
)
select *
from cte
where date_diff(hire_date, company_start_date, year) <= 2;


--- views ---
--create a view showing total customers, total products for every market date

create view `farmers_market.market_date_agg` as
(select market_date,
count(distinct customer_id) as total_customers,
count(distinct product_id) as total_products
from `farmers_market.customer_purchases`
group by market_date);

select * from `farmers_market.market_date_agg`;
