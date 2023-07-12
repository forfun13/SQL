-- Створення бази даних
CREATE DATABASE book_library;

-- Підключення до бази даних
USE book_library;

-- Створення таблиці авторів
CREATE TABLE authors (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

-- Створення таблиці книг
CREATE TABLE books (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100),
  publication_year INT,
  page_count INT,
  author_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(id)
);
-- Тест