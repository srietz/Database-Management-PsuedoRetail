CREATE OR REPLACE PROCEDURE addItemOrder(p_orderId IN varchar, p_custId IN varchar, p_itemId IN varchar, p_itemType IN varchar, p_date_ordered IN DATE, p_num_ordered IN INTEGER, p_shipped_date DATE, p_shirt_size IN varchar)
AS
	l_inventory_available INTEGER;
	l_custType Customer.custType%TYPE;
BEGIN
	-- determine if item ordered is a comic book
	IF UPPER(p_itemType) = UPPER('ComicBook') THEN
		--And Number of Books ordered doesn't exceed inventory available
		Select num_of_copies INTO l_inventory_available FROM ComicBook WHERE itemId = p_itemId;
		IF p_num_ordered > l_inventory_available THEN
			--If not enought inventory available, exit
			RAISE_APPLICATION_ERROR(-20000, '# of items ordered exceeds inventory');
		ELSE
			--If we have enough inventory, add an order to the ItemOrders table	
			INSERT INTO ItemOrders 
				VALUES(p_orderId, p_custId, p_itemId, p_date_ordered, p_num_ordered, p_shipped_date, NULL);
			-- update inventory
			UPDATE ComicBook
			SET num_of_copies = (num_of_copies - p_num_ordered) 
			WHERE itemId = p_itemId;
		END IF;
	-- If we ordered a shirt
	ELSIF UPPER(p_itemType) = UPPER('Tshirt') THEN
		-- And Number of Shirts ordered doesn't exceed inventory available
		Select num_in_inventory INTO l_inventory_available FROM Tshirt WHERE itemId = p_itemId AND shirt_size = p_shirt_size;
			
		If p_num_ordered > l_inventory_available THEN
			RAISE_APPLICATION_ERROR(-20000, '# of items ordered exceeds inventory');
		ELSE
			--If we have enough inventory, add an order to the ItemOrders table				
			INSERT INTO ItemOrders VALUES(p_orderId, p_custId, p_itemId, p_date_ordered, p_num_ordered, p_shipped_date, NULL);
			UPDATE Tshirt
				SET num_in_inventory = (num_in_inventory - p_num_ordered) 
				WHERE itemId = p_itemId AND p_shirt_size = shirt_size;
		END IF;
	END IF;
	
	-- Set shipping fee
	SELECT custType into l_custType FROM Customer WHERE custID = p_custId;
	IF UPPER(l_custType) = UPPER('regular') THEN
		UPDATE ItemOrders SET shippingFee = 10 WHERE orderId = p_orderId;
	ELSIF UPPER(l_custType) = UPPER('gold') THEN
		UPDATE ItemOrders SET shippingFee = 0 WHERE orderId = p_orderId;
	END IF;
END;
/
SHOW Errors;
--CREATES or REPLACES PROCEDURE addItemOrder
--Inserts order details into table
--	ItemOrders(orderId PK, custId FK, itemId FK, date_of_order, num_of_items, shipped_date, shippingFee)
--Parameters:
--	OrderId PrimaryKey, CustId, ItemId, Date_Ordered, 
--	Num_Ordered, Shipped_Date, shirtSize (Null if buying comic book)
--  inventory_available (default null), dateJoined (default NUll)

-- I (gold, custId: d1209) decide to buy all the copies of comic(itemid: b1111)
-- addItemOrder('00001','d1209','b1111', 'ComicBook','12-Mar-2021',12,NULL,NULL)
-- My girlfriend Kathleen (custId: a0001) tries to buy a copy of the comic I just bought
-- addItemOrder('00002','a0001','b1111', 'ComicBook','12-Mar-2021',12,NULL,NULL)
-- She is unable due to the constraints on the table
-- I purchase 1 shirt (itemId: s0000) in a size Medium(M)
-- addItemOrder('00003','d1209','s0000','Tshirt','13-Mar-2021',1,NULL,'M')
-- addItemOrder('00004','a0001','s1212','Tshirt','13-Mar-2021',1,Null,'XS')

--declare local variables
