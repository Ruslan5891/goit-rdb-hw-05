-- =====================================================================
-- Завдання 1.
-- Скриншот: p1_subquery_in_select.png
-- =====================================================================
USE mydb;

SELECT o.id, o.order_id, o.product_id, o.quantity,
       (SELECT c.customer_id FROM orders AS c WHERE c.id = o.order_id) AS customer_id
FROM order_details AS o;

-- =====================================================================
-- Завдання 2.
-- Скриншот: p2_subquery_in_where.png
-- =====================================================================
SELECT o.id, o.order_id, o.product_id, o.quantity
  FROM order_details AS o
WHERE o.order_id IN (SELECT id FROM orders WHERE shipper_id = 3);

-- =====================================================================
-- Завдання 3.
-- Скриншот: p3_subquery_in_from.png
-- =====================================================================
SELECT t.order_id, AVG(t.quantity) AS avg_quantity
  FROM (SELECT * FROM order_details WHERE quantity > 10) AS t
GROUP BY t.order_id;

-- =====================================================================
-- Завдання 4.
-- Скриншот: p4_with_temp_table.png
-- =====================================================================
WITH temp AS (
    SELECT * FROM order_details WHERE quantity > 10
)

SELECT t.order_id, AVG(t.quantity) AS avg_quantity
  FROM temp AS t
GROUP BY t.order_id;

-- =====================================================================
-- Завдання 5.
-- Скриншот: p5_divide_function.png
-- =====================================================================
DROP FUNCTION IF EXISTS DivideNumbers;

DELIMITER //

CREATE FUNCTION DivideNumbers(first_number FLOAT, second_number FLOAT)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = first_number / second_number;
    RETURN result;
END //

DELIMITER ;

SELECT id, order_id, quantity, DivideNumbers(quantity, 2) AS quantity_divided FROM order_details;
