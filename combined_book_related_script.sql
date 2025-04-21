/*
    Book-Related Setup Script
    This script consolidates all SQL operations related to book tables for the BookStore-Database-Project on the brian branch.
    It includes database initialization, creation of book-related tables, test data insertion, example queries, and a data manipulation query.
    These operations are specific to book-related entities to avoid overlap with teammates' tasks (e.g., customer and order tables).
    A final combined script (bookstoreDB.sql) will be created after merging with team contributions.
*/

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

/*
Create book-related tables
Tables are created in an order that respects foreign key dependencies:
- book_language and publisher first, as they’re referenced by book.
- author next, as it’s referenced by book_author.
- book after book_language and publisher, due to its foreign keys.
- book_author last, as it references book and author.
*/

-- Create the book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(200) NOT NULL
);

-- Create the publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(200) NOT NULL
);

-- Create the author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Create the book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    isbn VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Create the book_author table (junction table for book-author many-to-many relationship)
CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

/*
Insert test data into book-related tables
This section populates the book-related tables with at least 10 records each to provide a realistic dataset for testing queries.
The data is inserted in an order that respects foreign key dependencies.
*/

USE bookstore;

-- Insert into book_language
INSERT INTO book_language (language_name) 
VALUES
    ('English'), ('Spanish'), ('French'), ('German'), ('Italian'),
    ('Portuguese'), ('Russian'), ('Chinese'), ('Japanese'), ('Arabic');

-- Insert into publisher
INSERT INTO publisher (publisher_name) 
VALUES
    ('Penguin Books'), ('HarperCollins'), ('Simon & Schuster'), ('Hachette Book Group'), ('Macmillan Publishers'),
    ('Bloomsbury'), ('Random House'), ('Scholastic'), ('Oxford University Press'), ('Cambridge University Press');

-- Insert into author
INSERT INTO author (first_name, last_name) 
VALUES
    ('Jane', 'Austen'), ('Gabriel', 'García Márquez'), ('Victor', 'Hugo'), ('Franz', 'Kafka'), ('Dante', 'Alighieri'),
    ('Leo', 'Tolstoy'), ('Fyodor', 'Dostoevsky'), ('Haruki', 'Murakami'), ('Chinua', 'Achebe'), ('Naguib', 'Mahfouz');

-- Insert into book
INSERT INTO book (title, isbn, price, language_id, publisher_id) 
VALUES
    ('Pride and Prejudice', '978-0141439518', 12.99, 1, 1),
    ('One Hundred Years of Solitude', '978-0060883287', 14.99, 2, 2),
    ('Les Misérables', '978-0451419439', 18.99, 3, 3),
    ('The Metamorphosis', '978-0553213690', 9.99, 4, 4),
    ('The Divine Comedy', '978-0142437223', 15.99, 5, 5),
    ('War and Peace', '978-0199232765', 20.99, 7, 6),
    ('Crime and Punishment', '978-0140449136', 13.99, 7, 7),
    ('Norwegian Wood', '978-0375704024', 11.99, 9, 8),
    ('Things Fall Apart', '978-0385474542', 10.99, 1, 9),
    ('The Cairo Trilogy', '978-0385498357', 22.99, 10, 10);

-- Insert into book_author
INSERT INTO book_author (book_id, author_id) 
VALUES
    (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), 
    (7, 7), (8, 8), (9, 9), (10, 10), (1, 2), (2, 3);

-- Verify the inserted data
SELECT * FROM book_language;
SELECT * FROM publisher;
SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM book_author;

/*
Example queries for common bookstore operations
This section includes queries to demonstrate typical operations on the book-related tables,
such as listing books, finding books by author, and counting books per language.
*/

USE bookstore;

-- Query 1: List all books with their titles, languages, and publishers
SELECT b.book_id, b.title, bl.language_name, p.publisher_name, b.price
    FROM book b
    JOIN book_language bl ON b.language_id = bl.language_id
    JOIN publisher p ON b.publisher_id = p.publisher_id
    ORDER BY b.book_id;

-- Query 2: Find all books written by a specific author (e.g., Jane Austen, author_id = 1)
SELECT b.book_id, b.title, a.first_name, a.last_name
    FROM book b
    JOIN book_author ba ON b.book_id = ba.book_id
    JOIN author a ON ba.author_id = a.author_id
    WHERE a.author_id = 1;

-- Query 3: List authors who have written books in a specific language (e.g., English, language_id = 1)
SELECT DISTINCT a.first_name, a.last_name, bl.language_name
    FROM author a
    JOIN book_author ba ON a.author_id = ba.author_id
    JOIN book b ON ba.book_id = b.book_id
    JOIN book_language bl ON b.language_id = bl.language_id
    WHERE bl.language_id = 1;

-- Query 4: Find books published by a specific publisher (e.g., Penguin Books, publisher_id = 1)
SELECT b.book_id, b.title, p.publisher_name
    FROM book b
    JOIN publisher p ON b.publisher_id = p.publisher_id
    WHERE p.publisher_id = 1;

-- Query 5: Count the number of books per language
SELECT bl.language_name, COUNT(b.book_id) AS book_count
    FROM book_language bl
    LEFT JOIN book b ON bl.language_id = b.language_id
    GROUP BY bl.language_name
    ORDER BY book_count DESC;

/*
Explanation:
    Query 1: Joins book, book_language, and publisher to display each book’s title, language, publisher, and price.
    Query 2: Uses the book_author junction table to find all books by a specific author (Jane Austen, author_id = 1).
    Query 3: Identifies authors who have written books in a specific language (English, language_id = 1), using DISTINCT to avoid duplicates.
    Query 4: Lists books published by a specific publisher (Penguin Books, publisher_id = 1).
    Query 5: Counts the number of books in each language, using a LEFT JOIN to include languages with zero books.
*/

/*
Data manipulation query
This section updates the price of English books and verifies the change with formatted price output.
*/

USE bookstore;

/*
Explanation:
    SELECT 1: Displays books in English (language_id = 1) with prices formatted with $ sign before update.
    UPDATE: Increases price of English books by 10% to simulate market adjustment.
    SELECT 2: Displays updated prices of English books with $ sign to verify the change.
*/

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