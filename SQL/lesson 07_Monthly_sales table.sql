--Create new table called monthly_sales
/*
CREATE TABLE IF NOT EXISTS monthly_sales (
month VARCHAR(10),
sales DECIMAL(10,2)
);
*/

--Add values to the table

INSERT INTO monthly_sales (month,sales)
VALUES 
('Jan',1000),
('Feb',1500),
('Mar',800),
('Apr',1200);


