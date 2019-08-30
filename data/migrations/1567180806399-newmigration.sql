-- Step 1: Create a new database using the following command:
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;


-- Step 2: Create a second table in labe14_normal  called bookshelves
CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Step 3: Retrieve unique bookshelf values from the books tables and insert them into the bookshelves table

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

-- Step 4: Add a column to the books tables named bookshelf_id.  This connects each book to a specific bookshelf form the other table.

ALTER TABLE books ADD COLUMN bookshelf_id INT;

-- Step 5: Prepare a connection between the two tables.  This command will run a subquery on every row in books.  The subquery then finds matching names for the current bookshelf value. The id of that value will then be set to the value of the bookshelf_id in the current book row.

UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;


-- Step 6:  Modify the books table by removing the column named bookshelf.  This is no longer needed because it contains the bookshelf_id column.

ALTER TABLE books DROP COLUMN bookshelf;

-- Step 7: Modify the data type of bookshelf_id in the books table and set it as a foreign key that references the primary key in the bookshelves table.
ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);