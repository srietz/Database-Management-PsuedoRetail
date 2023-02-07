CREATE TABLE Customer(
		custId varchar(5) PRIMARY KEY, 
		name varchar(30), 
		email varchar(30) UNIQUE NOT NULL, 
		address varchar(50),
		custType varchar(7) check (custType in ('Regular', 'Gold')),
		dateJoined DATE DEFAULT NULL
);

CREATE TABLE StoreItems(
		itemId varchar(5) PRIMARY KEY,
		itemType varchar(5),
		price number(38,2)
);

CREATE TABLE Tshirt(
		itemId varchar(5),
		shirt_size varchar(11),
		num_in_inventory integer,
		CONSTRAINT t_fk
			FOREIGN KEY (itemId)
			REFERENCES StoreItems(itemId)
			ON DELETE CASCADE
);

CREATE TABLE ComicBook(
		itemId varchar(5),
		ISBN varchar(13) UNIQUE,
		title varchar(50),
		publishedDate DATE,
		num_of_copies integer check (num_of_copies >= 0),
		CONSTRAINT com_fk
			FOREIGN KEY (itemId)
			REFERENCES StoreItems(itemId)
			ON DELETE CASCADE
);

CREATE TABLE ItemOrders(
		orderId varchar(5) PRIMARY KEY,
		custId varchar(5),
		itemId varchar(5),
		date_of_order DATE,
		num_of_items integer,
		shipped_date DATE,
		shippingFee number(38,2),
		CONSTRAINT cust_fk 
			FOREIGN KEY (custId)
			REFERENCES Customer(custId) 
			ON DELETE CASCADE,
		CONSTRAINT item_fk 
			FOREIGN KEY (itemId)
			REFERENCES StoreItems(itemId) 
			ON DELETE CASCADE
);
