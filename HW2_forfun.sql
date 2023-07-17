-- Запит, який заповнить таблицю авторів даними (5+ записів)
INSERT INTO authors (first_name, last_name)
VALUES
  ('Dima', 'Pypkin'),
  ('Vasya', 'Popov'),
  ('Miha', 'Koval'),
  ('Anna', 'German'),
  ('Bogdan', 'Bada'),
  ('Kostya', 'Kostul');

-- Запит, який заповнить таблицю книг даними (15+ записів)
INSERT INTO books (title, publication_year, page_count, author_id)
VALUES
  ('Book 1', 2020, 400, 1),
  ('Book 2', 2015, 150, 2),
  ('Book 3', 2018, 300, 3),
  ('Book 4', 2012, 250, 4),
  ('Book 5', 2019, 180, 5),
  ('Book 6', 2014, 220, 6),
  ('Book 7', 2017, 270, 1),
  ('Book 8', 2016, 190, 2),
  ('Book 9', 2013, 230, 3),
  ('Book 10', 2021, 260, 4),
  ('Book 11', 2011, 210, 5),
  ('Book 12', 2018, 240, 6),
  ('Book 13', 2015, 170, 1),
  ('Book 14', 2019, 290, 2),
  ('Book 15', 2016, 320, 3),
  ('Book 16', 1998, 140, 4),
  ('Book 17', 2001, 60, 5),
  ('Book 18', 2004, 240, 6),
  ('Book 1', 2020, 400, 4);

-- Запит, який вибирає книги, у яких кількість сторінок більша за середню кількість сторінок по всіх книгах
SELECT * 
FROM books 
WHERE page_count > (SELECT AVG(page_count) FROM books);

-- Запит, який змінює кількість сторінок у вказаної книги
UPDATE books 
SET page_count = 300 
WHERE id = 1;

-- Запит, який видаляє автора за ідентифікатором (оскільки в таблиці FOREIGN KEY (author_id) REFERENCES authors(id) то спочатку видаляємо всі книги цього автора)
DELETE FROM books 
WHERE author_id = 6;
DELETE FROM authors 
WHERE id = 6;

-- Запит, який вибирає кількість книг у заданого автора (за ідентифікатором)
SELECT COUNT(*) 
FROM books 
WHERE author_id = 2;

-- Запит, який видаляє книгу за ідентифікатором
DELETE FROM books 
WHERE id = 16;

-- Запит, який вибирає книгу з найдовшою назвою;
SELECT * 
FROM books 
ORDER BY LENGTH(title) DESC LIMIT 1;

-- Запит, який видаляє усі книги, у яких кількість сторінок менша, ніж середня кількість сторінок;
CREATE TEMPORARY TABLE temp_avg_page_count
SELECT CAST(AVG(page_count) AS FLOAT) AS average_page_count
FROM books;

DELETE FROM books 
WHERE page_count < (SELECT average_page_count FROM temp_avg_page_count);

DROP TABLE temp_avg_page_count;

-- Запит, який додає нову книгу, але якщо книга цього автора з такою назвою вже існує, оновлює кількість сторінок;
INSERT INTO books (title, publication_year, page_count, author_id)
VALUES ('Book 20', 2022, 280, 3) 
AS new_book
ON DUPLICATE KEY UPDATE page_count = new_book.page_count;

-- Запит, який вибирає книги, у яких рік видання між двома вказаними датами;
SELECT * 
FROM books 
WHERE publication_year BETWEEN 2015 AND 2020;

-- Запит, який оновлює рік видання книги на поточний рік;
UPDATE books 
SET publication_year = YEAR(CURRENT_DATE()) 
WHERE id = 4;

-- Запит, який видаляє книгу з найдовшою назвою;
CREATE TEMPORARY TABLE temp_longest_title
SELECT title 
FROM books 
ORDER BY LENGTH(title) 
DESC LIMIT 1;

DELETE FROM books 
WHERE title = (SELECT title FROM temp_longest_title);

DROP TABLE temp_longest_title;

-- Напишіть запит, щоб дізнатися, чи є книги, написані більш ніж одним автором (за ідентифікатором).
SELECT title
FROM books
WHERE title IN (
    SELECT title
    FROM books
    GROUP BY title
    HAVING COUNT(*) > 1
)
AND author_id = 4
GROUP BY title;
