-- Знайти кількість книг, написаних кожним автором
SELECT a.first_name, a.last_name, (
    SELECT COUNT(*)
    FROM books b
    WHERE b.author_id = a.id
) AS book_count
FROM authors a;

-- Знайти назву книги з максимальною кількістю сторінок
SELECT title
FROM books
WHERE page_count = (
	SELECT MAX(page_count) 
	FROM books
);

-- Знайти середній рік видання книг автора з певним ідентифікатором
SELECT AVG(publication_year)
FROM books
WHERE author_id = (
	SELECT id
    FROM authors
    where last_name = 'Pypkin'
);

-- Знайти авторів, які мають понад 5 книг
SELECT a.first_name, a.last_name
FROM authors a
WHERE a.id IN (
    SELECT b.author_id
    FROM books b
    GROUP BY b.author_id
    HAVING COUNT(b.author_id) > 5
);

-- Знайти авторів, у яких всі книги видані після певного року
SELECT first_name, last_name
FROM authors
WHERE id IN (
	SELECT author_id
    FROM books
    WHERE publication_year > 2017
);

-- Знайти автора з найбільшою кількістю сторінок написаних книг
SELECT a.first_name, a.last_name
FROM authors a
WHERE a.id = (
    SELECT b.author_id
    FROM books b
    GROUP BY b.author_id
    ORDER BY SUM(b.page_count) DESC
    LIMIT 1
);

-- Знайти автора, у якого найбільше книг видано в останні 10 років
SELECT a.first_name, a.last_name
FROM authors a
WHERE a.id = (
	SELECT b.author_id
    FROM books b
    WHERE b.publication_year > YEAR(CURDATE()) - 10
    GROUP BY b.author_id
    ORDER BY COUNT(b.title) DESC
    LIMIT 1
);

-- Знайти середню кількість сторінок у книгах авторів з понад двома книгами
SELECT AVG(page_count) AS average_page_count
FROM books
WHERE author_id IN (
    SELECT author_id
    FROM books
    GROUP BY author_id
    HAVING COUNT(title) > 2
);