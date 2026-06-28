CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    publication_year INTEGER, 
    author TEXT,
    genre TEXT,
    publishing_company TEXT,
    isbn varchar(13) UNIQUE NOT NULL,
    language TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);