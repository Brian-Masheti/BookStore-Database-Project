-- ===================================================
-- Example SQL Queries for the Bookstore Order System

-- ===================================================

-- View all customer orders with status and shipping method
SELECT 
    o.id AS order_id,
    o.order_date,
    s.status_name,
    m.name AS shipping_method,
    m.cost
FROM customer_order o
JOIN order_status s ON o.status_id = s.id
JOIN shipping_method m ON o.shipping_method_id = m.id;

-- View order line items for a specific order
SELECT 
    l.order_id,
    l.product_id,
    l.quantity,
    l.price,
    (l.quantity * l.price) AS total
FROM order_line l
WHERE l.order_id = 1;

-- View order status history
SELECT 
    h.order_id,
    s.status_name,
    h.changed_at
FROM order_history h
JOIN order_status s ON h.status_id = s.id
WHERE h.order_id = 1;

-- Calculate total amount of a customer's order
SELECT 
    o.id AS order_id,
    SUM(l.quantity * l.price) AS total_order_amount
FROM customer_order o
JOIN order_line l ON o.id = l.order_id
WHERE o.customer_id = 1
GROUP BY o.id;
