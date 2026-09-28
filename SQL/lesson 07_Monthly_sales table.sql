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



SELECT 
        month_number,
        month,
        salesperson,
        sales
FROM monthly_sales;





