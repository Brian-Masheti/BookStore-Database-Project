-- Active: 1743981475032@@127.0.0.1@3306@bookstore
-- Initialize the bookstore database with UTF-8 encoding
CREATE DATABASE IF NOT EXISTS bookstore
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

/*
    UTF-8 encoding ensures the database can handle a wide range of characters, which is important for a bookstore database where book titles, author names, or languages might include special characters (e.g., accents, non-Latin scripts, or emojis).
    The `utf8mb4_unicode_ci` collation ensures proper sorting and comparison of text, regardless of case.
*/

-- Switch to the bookstore database
USE bookstore;

-- Verify the database creation (optional)
SHOW VARIABLES LIKE 'character_set_database';
SHOW VARIABLES LIKE 'collation_database';

