CREATE SCHEMA SQL_Basics_Practice;

CREATE TABLE SQL_Basics_Practice.sales (
    "Order ID" INT PRIMARY KEY,
    "Order Date" DATE,
    "Customer ID" INT,
    "Customer Name" VARCHAR(255),
    "Sales Person" VARCHAR(255),
    "Region" VARCHAR(255),
    "Product_Type" VARCHAR(255),
    "Price" INT,
    "Quantity" INT
);

INSERT INTO SQL_Basics_Practice.sales ("Order ID", "Order Date", "Customer ID", "Customer Name", "Sales Person", "Region", "Product_Type", "Price", "Quantity") VALUES
(1, '2023-01-01', 101, 'Company A', 'Alice', 'Region1', 'Product1', 100, 2),
(2, '2023-01-02', 102, 'Company B', 'Bob', 'Region2', 'Product2', 150, 3),
(3, '2023-01-03', 103, 'Company C', 'Charlie', 'Region3', 'Product3', 200, 4),
(4, '2023-01-04', 104, 'Company D', 'Diana', 'Region4', 'Product4', 250, 5),
(5, '2023-01-05', 105, 'Company E', 'Eva', 'Region5', 'Product5', 300, 6);

SELECT * FROM SQL_Basics_Practice.sales
ORDER BY "Order Date" ASC, "Quantity" DESC;

-- Create a new table 'sales_bkp' as a copy of 'sales' structure
CREATE TABLE SQL_Basics_Practice.sales_bkp AS
SELECT * FROM SQL_Basics_Practice.sales;
-- Optionally, to copy all the data from 'sales' to 'sales_bkp'
INSERT INTO SQL_Basics_Practice.sales_bkp
SELECT * FROM SQL_Basics_Practice.sales;

DELETE FROM SQL_Basics_Practice.sales_bkp
WHERE "Order ID" = (SELECT MIN("Order ID") FROM SQL_Basics_Practice.sales_bkp);

ALTER TABLE SQL_Basics_Practice.sales_bkp
ADD COLUMN "CreatedBy" VARCHAR(255) DEFAULT 'Subhajit Basistha';

SELECT "Order ID", "CreatedBy", "Sales Person", "Price"
FROM SQL_Basics_Practice.sales_bkp;

ALTER TABLE SQL_Basics_Practice.sales_bkp
DROP COLUMN "CreatedBy";

DROP TABLE SQL_Basics_Practice.sales_bkp;

CREATE TABLE SQL_Basics_Practice.sales_data (
    "Order ID" INT PRIMARY KEY,
    "Order Date" DATE,
    "Customer ID" INT,
    "Customer Name" VARCHAR(255),
    "Sales Person" VARCHAR(255),
    "Region" VARCHAR(255),
    "Product_Type" VARCHAR(255),
    "Price" INT,
    "Quantity" INT
);

SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'sales_data' AND table_schema = 'SQL_Basics_Practice';

SELECT * FROM sql_basics_practice.sales_data;

SELECT * 
FROM SQL_Basics_Practice.sales_data
WHERE "Region" = 'California';

SELECT 
    MIN("Price") AS Min_Price, 
    MAX("Price") AS Max_Price, 
    AVG("Price") AS Avg_Price, 
    SUM("Price") AS Total_Price, 
    
    MIN("Quantity") AS Min_Quantity, 
    MAX("Quantity") AS Max_Quantity, 
    AVG("Quantity") AS Avg_Quantity, 
    SUM("Quantity") AS Total_Quantity
FROM SQL_Basics_Practice.sales_data;

SELECT "Product_Type", COUNT("Order ID") AS Number_of_Orders
FROM SQL_Basics_Practice.sales_data
GROUP BY "Product_Type"
ORDER BY Number_of_Orders DESC;

ALTER TABLE SQL_Basics_Practice.sales_data
ADD COLUMN "Revenue" INT GENERATED ALWAYS AS ("Price" * "Quantity") STORED;

SELECT "Sales Person", SUM("Revenue") AS Total_Revenue
FROM SQL_Basics_Practice.sales_data
GROUP BY "Sales Person"
ORDER BY Total_Revenue DESC;

SELECT * 
FROM SQL_Basics_Practice.sales_data
WHERE "Revenue" BETWEEN 1000 AND 3000
AND "Region" = 'Texas';

SELECT "Sales Person", SUM("Revenue") AS Total_Revenue
FROM SQL_Basics_Practice.sales_data
GROUP BY "Sales Person"
HAVING SUM("Revenue") > 250000
ORDER BY Total_Revenue DESC;

