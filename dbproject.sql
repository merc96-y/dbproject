
CREATE DATABASE Tech_Pack_Bookstore;
USE Tech_Pack_Bookstore;


-- creating tables for languages
CREATE TABLE book_language (
language_id INT PRIMARY KEY,
language_name VARCHAR(50) NOT NULL,
language_code VARCHAR (3) NOT NULL
 );
 INSERT INTO book_language (language_id, language_name, language_code) VALUES
(1, 'English', 'EN'),
(2, 'Kiswahili', 'KIS');


-- Create the publisher table
 CREATE TABLE publisher (
publisher_id INT PRIMARY KEY,
publisher_name VARCHAR(100) NOT NULL
 );
INSERT INTO Publisher (publisher_id, publisher_name) VALUES
(1, 'Moran Publishers'),
(2, 'StoryMoja Publishers'),
(3, 'Signal Publishers'),
(4, 'Focus Publishers'),
(5, 'Jomo Kenyatta Foundation Publishers'),
(6, 'Kenya Literature Bureau Publishers'),
(7, 'Oxford Publishers'),
(8, 'Longhorn Publishers'),
(9, 'Phoenix Publishers'),
(10, 'Mountain Top Publishers');


-- Create the book table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    title VARCHAR(255) NOT NULL,
    publication_date DATE,
    language_id INT,
    publisher_id INT,
    pages INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
INSERT INTO Books (book_id, isbn, title, publication_date, language_id, publisher_id, pages) VALUES
    (1, '978-0321765723', 'The River Between', '1991-07-29', 1, 1, 378),
    (2, '978-0747532743', 'Hakuna Matata', '1997-06-26', 1, 2, 223),
    (3, '978-0141439518', 'When The Sun Goes Down', '2013-01-28', 1, 3, 279),
    (4, '978-0451524935', 'River and The Source', '1985-06-08', 1, 4, 328),
    (5, '978-0061120084', 'Siku Njema', '1986-07-11', 1, 5, 281),
    (6, '978-0421524930', 'The Promise Land', '1994-06-08', 1, 4, 138),
    (7, '978-04015249325', 'Out Of Africa', '2003-06-08', 1, 4, 48),
    (8, '978-0421524835', 'Son Of A Woman', '2010-06-08', 1, 4, 316),
    (9, '978-0411525935', 'Kidagaa', '1999-06-08', 1, 4, 213),
    (10, '978-0471523935', 'Dust', '2015-06-08', 1, 4, 128);


-- Create the author table
CREATE TABLE Author (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
INSERT INTO author (author_id, first_name, last_name) VALUES
    (1, 'Jeff', 'Koinange'),
    (2, 'Joan', 'Thatiah'),
    (3, 'Ken', 'walibora'),
    (4, 'Francis', 'Imbuga'),
    (5, 'Prof. Ngugi wa', 'Thiongo'),
    (6, 'Meja', 'Mwangi'),
    (7, 'Rebbeca', 'Nandwa');


-- Create the book_author table (for the many-to-many relationship between book and author)
CREATE TABLE book_author (
    book_author_id INT PRIMARY KEY,
    book_id INT,
    author_id INT,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
INSERT INTO book_author (book_author_id, book_id, author_id) VALUES
    (1, 1, 1),  
    (2, 2, 2),  
    (3, 3, 3),  
    (4, 4, 4),  
    (5, 5, 5),
    (6, 6, 6); 


-- Create the country table
CREATE TABLE county (
    county_id INT PRIMARY KEY,
    county_name VARCHAR(100) NOT NULL
);
INSERT INTO county (county_id, county_name) VALUES
    (1, 'Nairobi'),
    (2, 'Eldoret'),
    (3, 'Nakuru'),
    (4, 'Kisumu'),
    (5, 'Thika'),
    (6, 'Mombasa'),
    (7, 'Kajiado'); 


-- Create the address table
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    zip_code VARCHAR(20),
    county_id INT,
    FOREIGN KEY (county_id) REFERENCES county(county_id)
);
INSERT INTO address (address_id, street, city, state, zip_code, county_id) VALUES
    (1, '123 Main St', 'Anytown', 'NK', '12345', 1),
    (2, '456 Oak Ave', 'Sometown', 'NK', '67890', 1),
    (3, '789 Swara Ln', 'Eldoret', NULL, 'SW1A 0AA', 2),
    (4, '10 Thika Road', 'Thika', NULL, 'SW1A 2AA', 2),
    (5, '1 Rue de Rivoli', 'Nakuru', NULL, '75001', 3),
    (6, 'Mombasa Road 1', 'Nairobi', NULL, '10117', 4),
    (7, '1-Moi-Ave', 'Kisumu', NULL, '100-0014', 5);


-- Create the customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
INSERT INTO customer (customer_id, first_name, last_name, email, phone_number, address_id) VALUES
    (1, 'John', 'Kiriamiti', 'john.kiriamiti1@example.com', '0100-555-1234', 1),
    (2, 'Jane', 'Kihara', 'jane.kiharah@example.com', '01-555-5678', 2),
    (3, 'Ole', 'Lenku', 'Lenku.ole@example.fr', NULL, 5),
    (4, 'Hansa', 'Kajwang', 'hans.kajwang@example.de', '1234 5678', 6),
    (5, 'Abby', 'Tunu', 'Abby.tunua@example.jp', '07-1234-5678', 7),
    (6, 'El', 'Chapoo', 'el.chapz@example.fr', NULL, 5);


-- Create the customer_address table (to allow one customer to have multiple addresses)
CREATE TABLE customer_address (
    customer_address_id INT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    is_default BOOLEAN,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
INSERT INTO customer_address (customer_address_id, customer_id, address_id, is_default) VALUES
    (1, 1, 1, TRUE),
    (2, 2, 2, TRUE),
    (3, 2, 1, FALSE),
    (4, 3, 5, TRUE),
    (5, 4, 6, TRUE),
    (6, 5, 7, TRUE); 


-- Create the shipping_method table
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL
);
INSERT INTO shipping_method (shipping_method_id, method_name, shipping_cost) VALUES
    (1, 'Standard', 5.99),
    (2, 'Express', 12.99),
    (3, 'Overnight', 24.99),
    (4, 'Ground', 7.50),
    (5, 'Priority', 9.99);


Create the order_status table
CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);
INSERT INTO order_status (order_status_id, status_name) VALUES
    (1, 'Pending'),
    (2, 'Processing'),
    (3, 'Shipped'),
    (4, 'Delivered'),
    (5, 'Cancelled'),
    (6, 'Returned');


-- Create the order_header table
CREATE TABLE order_header (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    shipping_address_id INT,
    billing_address_id INT,
    shipping_method_id INT,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id),
    FOREIGN KEY (billing_address_id) REFERENCES address(address_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
INSERT INTO order_header (order_id, customer_id, order_date, shipping_address_id, billing_address_id, shipping_method_id, order_status_id) VALUES
    (1, 1, '2025-01-15', 1, 1, 1, 1),
    (2, 2, '2025-01-20', 2, 2, 2, 3),
    (3, 3, '2025-02-01', 5, 5, 3, 4),
    (4, 4, '2024-12-05', 6, 6, 4, 5),
    (5, 5, '2025-02-10', 7, 7, 5, 2);


-- Create the order_item table
CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES order_header(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO order_item (order_item_id, order_id, book_id, quantity, price) VALUES
    (1, 1, 1, 1, 525.99), 
    (2, 1, 3, 2, 812.50),
    (3, 2, 2, 3, 619.99),
    (4, 3, 5, 1, 315.75),
    (5, 4, 4, 1, 710.00);


-- Create the cart_item table
CREATE TABLE cart_item (
    cart_item_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    quantity INT NOT NULL,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO cart_item (cart_item_id, customer_id, book_id, quantity) VALUES
    (1, 1, 1, 4),
    (2, 1, 3, 6),
    (3, 2, 2, 2),
    (4, 3, 4, 4), 
    (5, 5, 4, 3);


-- Create the order_history table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY,
    order_id INT,
    order_status_id INT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES order_header(order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);
INSERT INTO order_history (history_id, order_id, order_status_id, change_date) VALUES
    (1, 1, 1, '2025-01-15 08:00:00'),
    (2, 2, 3, '2025-01-20 10:30:00'),
    (3, 3, 4, '2025-02-01 14:15:00'),
    (4, 4, 5, '2024-12-05 09:00:00'), 
    (5, 5, 2, '2025-02-10 11:00:00');


