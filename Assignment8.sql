use my_guitar_shop;

-- 1.
/* 
    Create and call a stored procedure named testProblemOne_sp. This stored
    procedure should declare a variable and set it to the most expensive price from all
    products in the Products table using list_price column.
     If the price is more than 1000 output, "Wow the most expensive guitar has the
    price <put price of the most expensive guitar here>'
     If the price is less than 1000 output, "I am going to buy the guitar that costs
    <put price of the most expensive guitar here>'
*/
DELIMITER //

CREATE PROCEDURE testProblemOne_sp()
BEGIN
    DECLARE max_price DECIMAL(10,2);
    SELECT MAX(list_price) INTO max_price FROM products;

    IF max_price > 1000 THEN
        SELECT CONCAT('Wow the most expensive guitar has the price ', max_price) AS Message;
    ELSE
        SELECT CONCAT('I am going to buy the guitar that costs ', max_price) AS Message;
    END IF;
END//

DELIMITER ;

CALL testProblemOne_sp();

-- 2.
/* 
    Create and call a stored procedure named testProblemTwo_sp. This stored
    procedure should use two variables to store: (1) the count of the orders that use
    credit card Visa in the Orders table and (2) the lowest shipping price for those orders
    (that used Visa credit card). If the lowest shipping price is greater than or equal to 5,
    the stored procedure should display a result set that displays the values of both
    variables. Otherwise, the procedure should display a result set that displays a
    message that says, “The lowest price of shipping for Visa orders is less than 5”.
*/
DELIMITER //

CREATE PROCEDURE testProblemTwo_sp()
BEGIN
    DECLARE visa_orders_count INT;
    DECLARE lowest_shipping_price DECIMAL(10,2);
    
    SELECT COUNT(*) INTO visa_orders_count FROM orders WHERE card_type = 'Visa';
    SELECT MIN(ship_amount) INTO lowest_shipping_price FROM orders WHERE card_type = 'Visa';
    
    IF lowest_shipping_price >= 5 THEN
        SELECT visa_orders_count AS Visa_Orders_Count, lowest_shipping_price AS Lowest_Shipping_Price;
    ELSE
        SELECT 'The lowest price of shipping for Visa orders is less than 5' AS Message;
    END IF;
END//

DELIMITER ;

CALL testProblemTwo_sp();

-- 3.
/* 
    Create and call a stored procedure named testProblemThree_sp. This stored
    procedure should create a cursor for a result set that consists of the product_name
    (from product table), item_price (from order_items table) and quantity columns (from
    order_items table) for each product from order #7.
    The rows in this result set should be sorted in ascending sequence by
    product_name. Then, the procedure should display a string variable that includes the
    product_name, item_price and quantity for each product so it looks something like
    this:
    Here, each value is enclosed in double quotes ("), each column is separated by a
    comma (,) and each row is separated by a pipe character (|).
    Make sure to close the cursor after it is done being used
*/
