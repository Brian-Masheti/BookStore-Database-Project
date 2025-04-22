-- ===================================================
-- Order Management SQL Schema

-- Description: Defines order-related tables for the bookstore system
-- ===================================================

-- ====================================
-- Table: shipping_method
-- ====================================
CREATE TABLE shipping_method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    estimated_delivery_days INT
);

-- ====================================
-- Table: order_status
-- ====================================
CREATE TABLE order_status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- ====================================
-- Table: customer_order
-- ====================================
CREATE TABLE customer_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);

-- ====================================
-- Table: order_line
-- ====================================
CREATE TABLE order_line (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES customer_order(id)
);

-- ====================================
-- Table: order_history
-- ====================================
CREATE TABLE order_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES customer_order(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id)
);

-- ====================================
-- User and Permission Setup
-- ====================================
CREATE USER 'bookstore_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON your_database_name.* TO 'bookstore_user'@'localhost';
FLUSH PRIVILEGES;
