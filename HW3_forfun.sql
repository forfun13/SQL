-- Отримання списку книг з іменами та прізвищами авторів
SELECT a.first_name, a.last_name, b.title
FROM authors a
INNER JOIN books b
ON a.id = b.author_id;
-- Отримання списку книг, опублікованих після 2010 року, з іменами та прізвищами авторів
SELECT b.title, a.first_name, a.last_name
FROM authors a
INNER JOIN books b
ON a.id = b.author_id
WHERE b.publication_year > 2010;
-- Отримання списку книг з ім'ям та прізвищем автора, де кількість сторінок у книзі більше 300
SELECT b.title, a.first_name, a.last_name
FROM authors a
INNER JOIN books b
ON a.id = b.author_id
WHERE b.page_count > 300;
-- Отримання списку книг, опублікованих автором із певним ім'ям
SELECT b.title
FROM authors a
INNER JOIN books b
ON a.id = b.author_id
WHERE a.first_name = 'Anna';
-- Отримання середньої кількості сторінок у книгах для кожного автора
SELECT a.first_name, a.last_name, AVG(b.page_count) AS average_page_count
FROM authors a
INNER JOIN books b ON a.id = b.author_id
GROUP BY a.first_name, a.last_name;
-- Отримання списку книг, які були опубліковані у 21 столітті (з 2000 року до теперішнього часу)
SELECT title
FROM books
WHERE publication_year > 2000;
-- Отримання списку авторів та кількості їх книг, відсортованих за кількістю книг за спаданням
SELECT a.first_name, a.last_name, COUNT(b.title) AS count_book
FROM authors a
INNER JOIN books b ON a.id = b.author_id
GROUP BY a.first_name, a.last_name
ORDER BY count_book;
-- Отримання списку книг, які не мають автора (автора з порожніми даними)
SELECT b.title
FROM authors a
RIGHT OUTER JOIN books b
ON a.id = b.author_id
WHERE a.first_name IS NULL;