-- Insert Customers
	-- Regular Customers
INSERT INTO Customer VALUES('a0001','Kathleen Casey','kmcasey11@gmail.com','1461 Creekside Dr., Walnut Creek, CA','Regular',NULL);
INSERT INTO Customer VALUES('b1234', 'Mary Sue', 'msue21@gmail.com', '541 Mountain Rd., Draper, UT','Regular', NULL);
INSERT INTO Customer VALUES('c9876', 'Chip and Joanna Gains', 'cjgains99@gmail.com', '75 Old Town Rd., Fort Worth, TX','Regular', NULL);
	-- Gold Customers
INSERT INTO Customer Values('d1209','Sam Rietz','srietz@scu.edu','1461 Creekside Dr., Walnut Creek, CA','Gold','07-Jan-1997');
INSERT INTO Customer VALUES('excel','Stan Lee','slee@gmail.com','74 High Life Dr., Syracuse, NY','Gold','16-Feb-2021'); 

--INSERT ITEMS
INSERT INTO StoreItems VALUES('b0000','comic',10.99);
INSERT INTO StoreItems VALUES('s0000','shirt' ,25.55);
INSERT INTO StoreItems VALUES('b1111','comic',12.99);
INSERT INTO StoreItems VALUES('b2222','comic',13.55);
INSERT INTO StoreItems VALUES('s1212','shirt',35.50);
INSERT INTO StoreItems VALUES('b9066','comic',26.90);
-- Detail Comic Books
INSERT INTO ComicBook VALUES('b0000','19-41-7859-90','Raiders of the Found Ark','12-Apr-1966',56);
INSERT INTO ComicBook VALUES('b1111','18-4111-89-01','Luke Strikes Back','16-Jul-1969',12);
INSERT INTO ComicBook VALUES('b2222','851-1-21-0-40','Fly You Fools','28-Sep-2001',18);
INSERT INTO ComicBook VALUES('b9066','463-452-110-9','Singing In the Rain','12-Jun-12',80);
-- Detail Shirts
INSERT INTO Tshirt VALUES('s0000','M',12);
INSERT INTO Tshirt VALUES('s1212','XS',4);
INSERT INTO Tshirt VALUES('s1212','M',13);
