-- Examples queries for common bookstore operations using book-related tables
-- Ensure the database is selected
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