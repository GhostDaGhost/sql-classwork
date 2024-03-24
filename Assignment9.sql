use my_guitar_shop;

-- 1.
/* 
    Create and call a stored procedure named insert_category_sp. In the stored
    procedure, a new row is added to the Categories table. To do that, this procedure
    should have one parameter for the category name.
    Code two CALL statements that test this procedure. Note that this table doesn’t
    allow duplicate category names.
    The second call should try to add the same value for category name. Verify the 2nd
    call results in an error.
*/
DELIMITER //

CREATE PROCEDURE insert_category_sp(IN category_name VARCHAR(255))
BEGIN
    DECLARE category_count INT;
    SELECT COUNT(*) INTO category_count FROM categories WHERE CategoryName = category_name;

    IF category_count = 0 THEN
        INSERT INTO categories(CategoryName) VALUES (category_name);
        SELECT 'Category added successfully.' AS Message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate category name. Cannot insert.';
    END IF;
END //

DELIMITER ;

-- Call #1
CALL insert_category_sp('New Category');

-- Call #2 (would be a fail)
CALL insert_category_sp('New Category');

-- 2.
/* 
    Create and call a stored function named discount_price_sf that calculates the
    discount price of an item in the Order_Items table (discount amount subtracted from
    item price). To do that, this function should accept one parameter for the item ID,
    and it should return the value of the discount price for that item.
*/
DELIMITER //

CREATE FUNCTION discount_price_sf(item_id INT) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE item_price DECIMAL(10, 2);
    DECLARE discount DECIMAL(10, 2);
    DECLARE discounted_price DECIMAL(10, 2);

    SELECT Price, Discount INTO item_price, discount FROM order_items WHERE ItemID = item_id;
    SET discounted_price = item_price - discount;
    RETURN discounted_price;
END //

DELIMITER ;

-- 3.
/* 
    Create and call a stored function named item_total_sf that calculates the total
    amount of an item in the Order_Items table (discount price multiplied by quantity). To
    do that, this function should accept one parameter for the item ID, it should use the
    discount_price_sf function that you created in Problem 2, and it should return the
    value of the total for that item.
*/
DELIMITER //

CREATE FUNCTION item_total_sf(item_id INT, quantity INT) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE total_amount DECIMAL(10, 2);

    SET total_amount = discount_price_sf(item_id) * quantity;
    RETURN total_amount;
END //

DELIMITER ;

-- 4.
/* 
    Create and call a stored procedure named update_product_discount_sp that
    updates the discount_percent column in the Products table. This procedure should
    have one parameter for the product ID and another for the discount percent.
    If the value for the discount_percent column is a negative number, the stored
    procedure should signal state indicating that the value for this column must be a
    positive number. Otherwise, do the update on the discount_percent column in the
    Products table.

    Code two calls to the stored function where the second call results in the signal state
    indicating that the value for the column discount_percent must be a positive number.
*/
DELIMITER //

CREATE PROCEDURE update_product_discount_sp(IN product_id INT, IN discount_percent DECIMAL(5, 2))
BEGIN
    IF discount_percent >= 0 THEN
        UPDATE Products SET discount_percent = discount_percent WHERE ProductID = product_id;
        SELECT 'Discount percent updated successfully.' AS Message;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discount percent must be a positive number.';
    END IF;
END //

DELIMITER ;

-- Call #1
CALL update_product_discount_sp(1001, 10);

-- Call #2
CALL update_product_discount_sp(1002, -5);

-- ================
-- Last Questions
-- ================
/*
    I definitely think that procedures and conditional checks are the main learning points in this assignment.
    It is important to implement a sanity check in any code you write in any language. I'm very shocked that it is do-able
    in SQL.
*/

/*
    This will make me learn more on how to do our final project with procedures and such.
*/
