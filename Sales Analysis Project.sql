---What is the total sales revenue in the dataset?---
---So i sum the sales and named it as total_sales_revenue from the table and my query is as below
SELECT SUM(Sales) AS total_sales_revenue
FROM [dbo].[SuperstoreAnaylsis]

--Which ship mode is the most commonly used?--****
--Here i select top 1 the count it as shipment_count the i group it by the column name
SELECT TOP 1 ship_mode, COUNT(*) AS shipment_count
FROM [dbo].[SuperstoreAnaylsis]
GROUP BY ship_mode
  
--Which category has the highest average sales?--
-- For this i selected the category column, averaged the sales then as average_sales grouped it by the the category column
-- then order by the average_sales
SELECT category, AVG(sales) AS average_sales
FROM [dbo].[SuperstoreAnaylsis]
GROUP BY category
ORDER BY average_sales 
DESC

--Calculate the total sales revenue for each sub-category--
SELECT Category, AVG(Sales) AS avg_category_sales 
FROM [dbo].[SuperstoreAnaylsis]
GROUP BY Category 
ORDER BY avg_category_sales 
DESC 

--Identify the last date in the dataset--
--Here i selected MAX order date as last_date from the table
SELECT MAX([Order_Date]) AS last_date
FROM [dbo].[SuperstoreAnaylsis]


--Find the Top 5 customers who made the Highest total purchases--
SELECT TOP 5 [Customer_ID] , SUM(sales) AS total_purchases
FROM [dbo].[SuperstoreAnaylsis]
GROUP BY [Customer_ID]
ORDER BY total_purchases DESC


SELECT CAST(Order_Date AS DATE) AS order_date, AVG(Sales) AS avg_daily_sales
FROM [dbo].[SuperstoreAnaylsis]
WHERE Order_Date >= (
    SELECT DATEADD(DAY, -30, MAX(Order_Date))
    FROM [dbo].[SuperstoreAnaylsis]
)
AND Order_Date <= (
    SELECT MAX(Order_Date)
    FROM [dbo].[SuperstoreAnaylsis]
)
GROUP BY CAST(Order_Date AS DATE)
ORDER BY order_date;


--Predicting Sales for the next 7days---
SELECT 
    CONVERT(DATE, Order_Date) AS prediction_start_date, 
    CONVERT(DATE, DATEADD(DAY, 1, Order_Date)) AS day_1,
    CONVERT(DATE, DATEADD(DAY, 2, Order_Date)) AS day_2, 
    CONVERT(DATE, DATEADD(DAY, 3, Order_Date)) AS day_3, 
    CONVERT(DATE, DATEADD(DAY, 4, Order_Date)) AS day_4, 
    CONVERT(DATE, DATEADD(DAY, 5, Order_Date)) AS day_5, 
    CONVERT(DATE, DATEADD(DAY, 6, Order_Date)) AS day_6, 
    CONVERT(DATE, DATEADD(DAY, 7, Order_Date)) AS day_7,
    ROUND(AVG(sales), 2) AS predicted_daily_sales 
FROM [dbo].[SuperstoreAnaylsis]
GROUP BY Order_Date;



