use my_guitar_shop;

-- 1.
/* 
    Write a SQL statement that returns the same result set as the following SELECT statement. Adjust
    the SQL Statement so that it does not use a join. To do so, adjust the Select statement to use a
    subquery that has a WHERE clause using the IN keyword.
*/
SELECT DISTINCT product_name FROM products WHERE product_id IN (
    SELECT product_id FROM order_items
) ORDER BY product_name;

-- 2.
/* 
    Write a SQL statement that returns the following information: Which item_id in the order_item
    table has a discount_amount that’s smaller than the average discount_amount for all items in the
    order_items table.

    Return the item_id and discount_amount columns for each item.

    Sort the results by the discount_amount column in descending sequence.

    Do not use any joins.
*/
SELECT item_id, discount_amount FROM order_items WHERE discount_amount < (
    SELECT AVG(discount_amount) FROM order_items
) ORDER BY discount_amount DESC;

-- 3.
/* 
    Write a SELECT statement that finds the products names that were never purchased.

    Return one row for each product that is not present in the order_items table. To do that, use a
    subquery introduced with the NOT EXISTS operator

    The Select statement should return product_id and product_name columns.

    Do not do a join, instead, create a correlated query

    Note: You don’t need to use the Distinct operator

    Hint: running the following 2 queries should give guidance

    SELECT DISTINCT product_id FROM order_items;

    SELECT product_id FROM products;
*/
SELECT product_id, product_name FROM products p WHERE NOT EXISTS (
    SELECT 1 FROM order_items o WHERE o.product_id = p.product_id
);

-- 4.
/* 
    Write a SQL statement that finds orders with unique card_types. In other words, don’t include
    orders that have the same card_type as another order.
    Make sure to use a subquery to solve this problem, not a join
    Sort the results by the card_type column in ascending order.
    Return the 2 columns: order_id, card_type
    Hint: see “better question 6” in ExerciseSolutionsChapter7.sql as listed under our Week 5 Module in
    Canvas
*/
SELECT order_id, card_type FROM orders o WHERE NOT EXISTS (
    SELECT 1 FROM orders WHERE card_type = o.card_type AND order_id <> o.order_id
) ORDER BY card_type ASC;

-- 5.
/* 
    Write a SQL statement that uses correlated subquery to return one row per category, representing
    the categories cheapest product (smallest list price). Each row should include these three columns:
    product_name, category_name and list_price.
*/
SELECT 
    (
        SELECT product_name FROM products WHERE category_id = c.category_id ORDER BY list_price ASC LIMIT 1
    ) AS product_name,
    c.category_name,
    (
        SELECT list_price FROM products WHERE category_id = c.category_id ORDER BY list_price ASC LIMIT 1
    ) AS list_price
FROM categories c;

-- 6.
/* 
    Create a query that will NOT use JOINS but only use a subquery.
    The Query should return Average_List_Price of products in the Category Name.
    Hints: use correlated subquery in the SELECT Clause, not in the Where Clause
    In the main query use the CATEGOREIS table
    The Subquery should use the PRODUCTS table.
*/
SELECT category_name, (
    SELECT AVG(list_price) FROM products WHERE category_id = c.category_id
) AS Average_List_Price FROM categories c;
