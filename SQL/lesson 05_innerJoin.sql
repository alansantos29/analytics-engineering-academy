--Inner join so it brings similar data in books and auhtors author_id columnn
/*SELECT
    Books.title,
    Authors.name
FROM Books
INNER JOIN Authors
ON Books.author_id = Authors.author_id; */

-- Inner join with 3 tables 
/*SELECT
    b.title,
    a.name,
    p.publisher_name
FROM Books AS b
INNER JOIN Authors AS a
ON b.author_id = a.author_id
INNER JOIN Publishers AS p
ON b.publisher_id = p.publisher_id; */

