--Create new table called monthly_sales
/*
CREATE TABLE IF NOT EXISTS monthly_sales (
month VARCHAR(10),
sales DECIMAL(10,2)
);
*/

--Add values to the table
/*
INSERT INTO monthly_sales (month,sales)
VALUES 
('Jan',1000),
('Feb',1500),
('Mar',800),
('Apr',1200);
*/

--Add more columns to the table
/*
ALTER TABLE monthly_sales
ADD COLUMN month_number int,
ADD COLUMN salesperson VARCHAR(10);
*/

--Add values to the table
/*
INSERT INTO monthly_sales (month,sales,month_number, salesperson)
VALUES
('Mar',1600,3,'Maria'),
('Jan',700,1,'Maria');
*/

--Update existing Rows
/*
UPDATE monthly_sales
SET 
    month_number =1,
    salesperson = 'Alan'
WHERE sales = 1000



UPDATE monthly_sales
SET 
    month_number =2,
    salesperson = 'Maria'

WHERE sales = 1200;



UPDATE monthly_sales
SET 
    month_number =3,
    salesperson = 'Alan'

WHERE sales = 800;


UPDATE monthly_sales
SET 
    month_number =2,
    salesperson = 'Alan'

WHERE sales = 1500;
 */


--Adding another column "Previous month sales"
/*
ALTER TABLE monthly_sales
ADD column previous_month_sales DECIMAL(10,2);
*/


--Add values to the table
/*
UPDATE monthly_sales
SET
    previous_month_sales = 1000
WHERE sales =1500;


UPDATE monthly_sales
SET
    previous_month_sales = 1500
WHERE sales =800;


UPDATE monthly_sales
SET
    previous_month_sales = 700
WHERE sales =1200;


UPDATE monthly_sales
SET
    previous_month_sales = 1200
WHERE sales =1600;
*/



--Add Another column called region
/*
ALTER TABLE monthly_sales
ADD COLUMN region VARCHAR (10);
*/


--Add values to the column region and more sales
/*
UPDATE monthly_sales

SET 
    region = 
        CASE
            WHEN salesperson = 'Alan' THEN 'South'
            WHEN salesperson = 'Maria' THEN 'North'
            WHEN salesperson = 'Peter' THEN 'South'
        END
WHERE salesperson IN ('Alan','Maria', 'Peter');
*/

/*
INSERT INTO monthly_sales (month_number, month, salesperson,region,sales)
values
(4,'Apr','Alan','South',1200),
(4,'Apr','Maria','North',1400),
(1,'Jan','Peter','South',900),
(2,'Feb','Peter','South',1100),
(3,'Mar','Peter','South',1300),
(4,'Apr','Peter','South',1700);
*/


SELECT 
        month_number,
        month,
        salesperson,
        sales
        
FROM monthly_sales;







