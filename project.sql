CREATE TABLE customers(
customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
is_active BOOLEAN NOT NULL,
created_at TIMESTAMP NOT NULL
);

CREATE TABLE categories(
category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE objects(
object_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
object_name VARCHAR(150) NOT NULL,
price NUMERIC(10,2) NOT NULL CHECK(price>=0),
category_id INTEGER NOT NULL, FOREIGN KEY(category_id) REFERENCES categories(category_id),
is_available BOOLEAN NOT NULL
);

CREATE TABLE orders(
order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
customer_id INTEGER NOT NULL, FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
order_date TIMESTAMP NOT NULL,
status VARCHAR(30) NOT NULL
);

CREATE TABLE order_item(
order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id BIGINT NOT NULL, FOREIGN KEY(order_id) REFERENCES orders(order_id),
object_id INTEGER NOT NULL, FOREIGN KEY(object_id) REFERENCES objects(object_id),
quantity INTEGER NOT NULL CHECK(quantity>0),
unit_price NUMERIC(10,2) NOT NULL CHECK(unit_price>=0)
);

ALTER TABLE customers
ADD COLUMN phone VARCHAR(25);

ALTER TABLE objects
ADD COLUMN description TEXT,
ADD COLUMN created_at TIMESTAMP;

ALTER TABLE customers
RENAME COLUMN customer_name TO full_name;

ALTER TABLE customers
ALTER COLUMN phone
TYPE VARCHAR(30);

ALTER TABLE customers 
ALTER COLUMN is_active SET DEFAULT TRUE;

ALTER TABLE objects
ALTER COLUMN is_available SET DEFAULT TRUE;

ALTER TABLE orders
ADD CHECK(status IN('pending','paid','shipped','cancelled'));

ALTER TABLE orders
ADD COLUMN notes TEXT;

ALTER TABLE orders
DROP COLUMN notes;

ALTER TABLE categories
RENAME TO product_categories;