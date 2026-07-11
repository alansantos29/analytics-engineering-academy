-- Creat Authors Table
/*
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);
*/

-- Create a bridge table

CREATE TABLE book_authors (
book_id INTEGER NOT NULL,
author_id INTEGER NOT NULL,

PRIMARY KEY (book_id, author_id),

FOREIGN KEY (book_id) REFERENCES books(book_id),
FOREIGN KEY (author_id) REFERENCES authors(author_id)
);