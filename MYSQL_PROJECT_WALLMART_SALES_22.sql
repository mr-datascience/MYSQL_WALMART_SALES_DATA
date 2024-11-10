### Generic Question
-- 1. How many unique cities does the data have?

select distinct(City) from walmartsales;

-- 2. In which city is each branch?

select distinct(city) from walmartsales
where branch in ("A","b","c")
order by city;

### Product

-- 1. How many unique product lines does the data have?
select distinct(`Product line`) from walmartsales;

-- 2. What is the most common payment method?
select Payment , count(Payment) from walmartsales
group by Payment
order by Payment desc
limit 1;

select * from walmartsales;


-- 3. What is the most selling product line?

select `Product line` , count(`Product line`) from walmartsales
group by `Product line`
order by `Product line` desc
limit 1;

-- 4. What is the total revenue by month?

SELECT YEAR(DATE),MONTH(DATE),
SUM(Total)/1.18 AS TOTAL_REVENUE_BY_MONTH
FROM WALMARTSALES
GROUP BY YEAR(DATE),MONTH(DATE)
ORDER BY YEAR(DATE),MONTH(DATE);

-- 5. What month had the largest COGS?

SELECT  YEAR(DATE),MONTH(DATE),
SUM(COGS) AS LARGEST_COGS_OF_MONTH
FROM WALMARTSALES
GROUP BY YEAR(DATE),MONTH(DATE)
ORDER BY YEAR(DATE),MONTH(DATE) DESC
LIMIT 1;

-- 6. What product line had the largest revenue?
select Product_line, sum(Total)/1.18 as largest_revenue from walmartsales
group by Product_line
order by largest_revenue desc 
limit 1;
-- 5. What is the city with the largest revenue?

select City, sum(Total)/1.18 as largest_revenue from walmartsales
group by City
order by largest_revenue desc 
limit 1;

-- 6. What product line had the largest VAT?

SELECT Product_line , SUM(`Tax_5%` * cogs) AS LARGEST_VAT
FROM WALMARTSALES
GROUP BY Product_line
ORDER BY LARGEST_VAT DESC
LIMIT 1;



-- 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT Product_line,
CASE WHEN Product_line > AVG(Total) THEN "GOOD" ELSE "BAD" END AS PRODUCT_STATUS
FROM walmartsales
GROUP BY Product_line;


-- 8. Which branch sold more products than average product sold?

SELECT branch,COUNT(*) AS products_sold
FROM walmartsales
GROUP BY branch
HAVING COUNT(*) > (SELECT AVG(products_sold) FROM 
(SELECT COUNT(*) AS products_sold FROM walmartsales GROUP BY branch) AS avg_sales);

-- 9. What is the most common product line by gender?
SELECT Product_line , Gender FROM walmartsales
GROUP BY Gender,Product_line;

-- 12. What is the average rating of each product line?

SELECT Product_line , AVG(Rating) FROM walmartsales
GROUP BY Product_line;


### Sales

-- 1. Number of sales made in each time of the day per weekday
    
SELECT WEEKDAY(DATE) AS WEEK_DAY,
CASE
    WHEN HOUR(TIME) >= 0 AND HOUR(TIME) < 6 THEN '00:00 - 06:00'
    WHEN HOUR(TIME) >= 6 AND HOUR(TIME) < 12 THEN '06:00 - 12:00'
    WHEN HOUR(TIME) >= 12 AND HOUR(TIME) < 18 THEN '12:00 - 18:00'
    WHEN HOUR(TIME) >= 18 AND HOUR(TIME) < 24 THEN '18:00 - 00:00'
    END AS TIME_OF_THE_DAY,
     COUNT(*) AS SALSE_COUNT
     FROM WALMARTSALES
     GROUP BY WEEKDAY(DATE),TIME_OF_THE_DAY
     ORDER BY TIME_OF_THE_DAY;


-- 2. Which of the customer types brings the most revenue?

SELECT Customer_type, SUM(Total)/1.18 AS CUSTOMER_MOST_REVENUE FROM WALMARTSALES
GROUP BY Customer_type
ORDER BY CUSTOMER_MOST_REVENUE DESC
LIMIT 1;


-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
SELECT City,`Tax_5%` AS LARGEST_TAX,SUM(`Tax_5%`*cogs) AS LARGEST_VAT FROM walmartsales
GROUP BY CITY,`Tax_5%`
ORDER BY `Tax_5%`,LARGEST_VAT DESC
LIMIT 1;
-- 4. Which customer type pays the most in VAT?

SELECT Customer_type ,SUM(`Tax_5%`*cogs) AS PAY_MOST_VAT
FROM walmartsales
GROUP BY Customer_type
ORDER BY PAY_MOST_VAT DESC
LIMIT 1;

### Customer

-- 1. How many unique customer types does the data have?

SELECT DISTINCT(Customer_type) FROM walmartsales;

-- 2. How many unique payment methods does the data have?

SELECT DISTINCT(Payment) FROM walmartsales;


-- 3. What is the most common customer type?

SELECT Customer_type , COUNT(*) AS COMMON_CUSTOMER_TYPE FROM walmartsales
GROUP BY Customer_type
ORDER BY COMMON_CUSTOMER_TYPE DESC
LIMIT 1;

-- 4. Which customer type buys the most?

SELECT Customer_type , COUNT(*) AS MOST_BYUS FROM walmartsales
GROUP BY Customer_type
ORDER BY MOST_BYUS DESC
LIMIT 1;



-- 5. What is the gender of most of the customers?
SELECT Gender,COUNT(*) AS MOST_OF_THE_CUSTOMER_GENDER FROM walmartsales
GROUP BY Customer_type,Gender
ORDER BY MOST_OF_THE_CUSTOMER_GENDER
LIMIT 1;

-- 6. What is the gender distribution per branch?
SELECT Branch,Gender, COUNT(*) AS GENDER_DISTRIBUTION_PER_BRANCH FROM walmartsales
GROUP BY Branch,Gender
ORDER BY Branch;

-- 7. Which time of the day do customers give most ratings?

select DAY(DATE) AS DAY_1,
CASE 
    WHEN HOUR(TIME) >= 0 AND HOUR(TIME) < 6 THEN '00:00 - 06:00'
    WHEN HOUR(TIME) >= 6 AND HOUR(TIME) < 12 THEN '06:00 - 12:00'
    WHEN HOUR(TIME) >= 12 AND HOUR(TIME) < 18 THEN '12:00 - 18:00'
    WHEN HOUR(TIME) >= 18 AND HOUR(TIME) <24 THEN '18:00 - 00:00'
    
    END TIME_OF_THE_DAY, COUNT(RATING) AS RATING_OF_THE_DAY
    FROM walmartsales
    GROUP BY DAY_1,TIME_OF_THE_DAY
    ORDER BY TIME_OF_THE_DAY;


-- 8. Which time of the day do customers give most ratings per branch?
SELECT DAY(DATE) AS DAY_1, Branch,
CASE 
    WHEN HOUR(TIME) >= 0 AND HOUR(TIME) < 6 THEN '00:00-06:00'
    WHEN HOUR(TIME) >= 6 AND HOUR(TIME) < 12 THEN '06:00-12:00'
    WHEN HOUR(TIME) >= 12 AND HOUR(TIME) < 18 THEN '12:00-18:00'
    WHEN HOUR(TIME) >= 18 AND HOUR(TIME) < 24 THEN '18:00-00:00'
    
    END AS TIME_OF_THE_DAY , COUNT(Rating) AS RATING_OF_DAY
    FROM walmartsales
    GROUP BY DAY_1, Branch,TIME_OF_THE_DAY
    ORDER BY TIME_OF_THE_DAY,Branch;

-- 9. Which day fo the week has the best avg ratings?

SELECT DAYNAME(DATE) AS day_of_week,
AVG(rating) AS avg_rating FROM walmartsales
GROUP BY DAYOFWEEK(DATE),DAYNAME(DATE)
ORDER BY avg_rating DESC
LIMIT 1;



-- 10. Which day of the week has the best average ratings per branch?

SELECT DAYNAME(DATE) AS DAY_OF_WEEK, BRANCH,
AVG(RATING) AS AVG_RATING FROM walmartsales
GROUP BY DAYOFWEEK(DATE),BRANCH,DAYNAME(DATE)
ORDER BY AVG_RATING,BRANCH
LIMIT 1;





