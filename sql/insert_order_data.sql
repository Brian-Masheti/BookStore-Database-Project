-- ===================================================
-- Sample Data for Order Management Tables

-- ===================================================

-- Insert shipping methods
INSERT INTO shipping_method (name, cost, estimated_delivery_days)
VALUES 
    ('Standard Shipping', 5.99, 5),
    ('Express Shipping', 12.99, 2);

-- Insert order statuses
INSERT INTO order_status (status_name)
VALUES 
    ('Pending'),
    ('Shipped'),
    ('Delivered'),
    ('Cancelled');

-- Insert a customer order
INSERT INTO customer_order (customer_id, shipping_method_id, status_id)
VALUES (1, 1, 1);

-- Insert order lines
INSERT INTO order_line (order_id, product_id, quantity, price)
VALUES 
    (1, 101, 2, 14.99),
    (1, 102, 1, 29.99);

-- Insert order history
INSERT INTO order_history (order_id, status_id)
VALUES (1, 1);
