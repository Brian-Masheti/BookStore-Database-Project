-- Active: 1743981475032@@127.0.0.1@3306@bookstore
-- Data manipulation query for the bookstore database
-- Ensure the database is selected
USE bookstore;

-- Display prices before the update with $ sign (for verification)
SELECT book_id, title, 
    CONCAT('$', FORMAT(price, 2)) AS price, language_id
FROM book
WHERE language_id = 1;

-- Update the price of all books in English (language_id = 1) by increasing it by 10%
UPDATE book
SET price = price * 1.10
WHERE language_id = 1;

-- Display prices after the update with $ sign (for verification)
SELECT book_id, title, 
    CONCAT('$', FORMAT(price, 2)) AS price, language_id
FROM book
WHERE language_id = 1;

