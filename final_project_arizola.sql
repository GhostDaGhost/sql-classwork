-- 4a) Stored Procedure

DELIMITER //

CREATE PROCEDURE CalculateOrderTotal(IN customerID INT)
BEGIN
    DECLARE totalPrice DECIMAL(10,2);
    DECLARE breakLoop INT DEFAULT 0;
    DECLARE currentOrder CURSOR FOR
        SELECT Total FROM orders WHERE Customer_ID = customerID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET breakLoop = 1;

    SET totalPrice = 0;
    OPEN currentOrder;

    read_loop: LOOP
        FETCH currentOrder INTO totalPrice;
        IF breakLoop THEN
            LEAVE read_loop;
        END IF;
        SET totalPrice = totalPrice + 10;
    END LOOP;

    CLOSE currentOrder;
    SELECT totalPrice AS Total_Price;
END //

DELIMITER ;

-- 4b) Call Statement
CALL CalculateOrderTotal(1);

-- 5a) Stored Function
DELIMITER //

CREATE FUNCTION CalculateOrderDiscount(orderTotal DECIMAL(10,2)) RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE discount DECIMAL(10,2);
    IF orderTotal > 100 THEN
        SET discount = orderTotal * 0.1;
    ELSE
        SET discount = 0;
    END IF;

    RETURN discount;
END //

DELIMITER ;

-- 5b) Select Statement
SELECT Total, CalculateOrderDiscount(Total) AS Discount FROM Orders;

-- 6a) Indexes
ALTER TABLE `customers`
	ADD INDEX `Customer_ID` (`Customer_ID`);

ALTER TABLE `orders`
	ADD INDEX `Customer_ID` (`Customer_ID`);

-- Composite Index
ALTER TABLE `orders`
	ADD INDEX `Order_Date` (`Order_Date`, `Customer_ID`);
