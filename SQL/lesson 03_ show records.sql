/*
Alan, show me all the books in our database.
SELECT * FROM books;*/


/*
Alan... I don't want every column
SELECT title, publication_year FROM books;*/


/*
Only show me books where the language is English.
SELECT *
FROM books
WHERE language = 'English';*/


/*
Alan, I only want to see the title
and publication year of books published after 2015.
SELECT *
FROM books
WHERE publication_year>2015; */


/* Show the title and publication 
year of books published after 2015, 
ordered from newest to oldest.

SELECT title, publication_year
FROM books
WHERE publication_year>2015
ORDER BY publication_year ASC; */


/*Can you show me only the titles of 
books written in English, ordered 
alphabetically (A → Z)?
SELECT title
FROM books
WHERE language = 'English'
ORDER BY title ASC; */



