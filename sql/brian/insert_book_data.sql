-- Active: 1743981475032@@127.0.0.1@3306@bookstore
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
    (7, 7), (8, 8), (9, 9),  (10, 10), (1, 2),(2, 3);

-- Verify the Data
SELECT * FROM book_language;
SELECT * FROM publisher;
SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM book_author;