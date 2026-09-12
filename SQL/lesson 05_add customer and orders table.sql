/*
CREATE TABLE customers (
    customer_id INT Primary key,
    customer_name varchar (50)
);

CREATE TABLE orders (
    order_id INT Primary key,
    customer_id INT,
        Foreign key (customer_id)
            References customers(customer_id)
);



INSERT INTO customers (customer_id,customer_name)
Values 
(1,'Alan'),
(2,'Maria'),
(3,'Peter'),
(4,'Sarah');

*/

INSERT INTO orders (order_id,customer_id)
Values
(101,1),
(102,3),
(103,3);