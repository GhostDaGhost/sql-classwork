use my_guitar_shop;

-- 1.
/* 
    Create a view named problemOne_view that joins the Customers, Orders,
    Order_Items, and Products tables.
    This view should have these columns:
    last_name,
    first_name,
    order_date,
    product_name,
    price: calculated item_price minus discount_amount
    quantity
    Write select statement that selects all columns from the view.
*/
CREATE VIEW problemOne_view AS
	SELECT
	    c.last_name,
	    c.first_name,
	    o.order_date,
	    p.product_name,
	    (oi.item_price - oi.discount_amount) AS price,
	    oi.quantity
	FROM
	    customers c
	JOIN
	    orders o ON c.customer_id = o.customer_id
	JOIN
	    order_items oi ON o.order_id = oi.order_id
	JOIN
	    products p ON oi.product_id = p.product_id;

-- Select Statement
SELECT * FROM problemOne_view;

-- 2.
/* 
    Using the view from problem 1, write an update statement that updates last_name of
    the customer that has first name Allan, and answer in comments why it works or
    doesn't. Use your own last name.
*/
UPDATE customers SET last_name = 'Arizola' WHERE first_name = 'Allan';

-- It works because both columns exist within the table.

-- 3.
/* 
    Using the view from problem 1, write an update statement that updates last_name of
    the customer that has first name Allan, and answer in comments why it works or
    doesn't. Use your own last name.
*/
UPDATE customers SET price = 123 WHERE first_name = 'Allan';

-- It doesn't work because price is not part of the table.

-- 4.
/*
    Create a view name problemFour_view that has one row for each customer, that has
    summary of orders data with these columns:
    customer_id: customer id
    email_address column from the Customers table
    Total_ship_amount column that has a sum of all orders ship amounts per customer
    Write a select statement that selects all columns from the view.
*/
CREATE VIEW problemFour_view AS
    SELECT
        c.customer_id,
        c.email_address,
        SUM(o.ship_amount) AS Total_ship_amount
    FROM
        customers c
    LEFT JOIN
        orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id, c.email_address;

-- Select Statement
SELECT * FROM problemFour_view;

-- 5.
/* 
    Using the view from problem 4, write an update statement that updates the customer
    email_address to abc@gmail.com for customer_id = 1, and answer in comments why it
    works or doesn't
*/
UPDATE customers SET email_address = 'abc@gmail.com' WHERE customer_id = 1;

-- It works because the column exists within the table.

-- 6.
/*
    Create a view named problemSix_view that selects all fields for records from the
    Products table where the discount_percent > 10. Make sure the view is created with the
    CHECK OPTION
    -Create and execute an update through the view problemSix_view where we update
    product_id 1's discount_percent value to a value that doesn't exclude it from the view.
    In comments, explain why it worked
    -Create an execute an update through the view problemSix_view where we update
    product_id 1's discount_percent value to a value that does exclude it from the view
    In comments, explain why it did NOT work
*/
CREATE VIEW problemSix_view AS
    SELECT * FROM products WHERE discount_percent > 10
WITH CHECK OPTION;

UPDATE problemSix_view SET discount_percent = 15 WHERE product_id = 1;

-- Explanation: This update works the check is satisfied.

UPDATE problemSix_view SET discount_percent = 5 WHERE product_id = 1;

-- Explanation: The update fails due to the CHECK OPTION
