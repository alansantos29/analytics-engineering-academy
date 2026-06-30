-- Question 1
-- Show all books

SELECT *
FROM books;

-- Question 2
-- Show only the title and language

SELECT title, language
FROM books;

--Question 3
--Show all English books
SELECT *
FROM books
WHERE language='English';

--Question 4
--Show books published after 2015
SELECT *
FROM books
WHERE publication_year>2015;

--Question 5
--Show English books published after 2015
SELECT *
FROM books
WHERE language='English' and publication_year>2015;

--Question 6
--Show English books or books published after 2015
SELECT *
FROM books
WHERE language='English' or publication_year>2015;

--Question 7
--Show the newest books first
SELECT *
FROM books
ORDER BY publication_year DESC;

--Question 8
--Show the oldest three English books
SELECT *
FROM books
WHERE language='English'
ORDER BY publication_year ASC
LIMIT 3;

--Question 9
--Show the neswest five English books
SELECT *
FROM books
WHERE language='English'
ORDER BY publication_year DESC
LIMIT 5;

--Question 10
/*Show only the title and ISBN of English books 
published after 2010, ordered alphabetically by title*/
SELECT title, isbn 
FROM books
WHERE language ='English' and publication_year>2010
ORDER BY title ASC;

