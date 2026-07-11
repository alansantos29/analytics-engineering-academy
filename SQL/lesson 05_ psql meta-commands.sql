-- Commnad to check for the current database / data in use
--SELECT current_database();

--Check the current user
--SELECT current_user;

--Check current Schema being used
--SELECT CURRENT_SCHEMA();

-- List all the columns in a table
/*SELECT *
FROM information_schema.columns
WHERE table_name = 'books';*/

--List all the tables on SQL
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';