CREATE OR REPLACE PROCEDURE showItemOrders(p_custId IN varchar, p_date IN DATE)
AS
l_name Customer.name%TYPE;
l_email Customer.email%TYPE;
l_address Customer.address%TYPE;
l_custType Customer.custType%TYPE;
l_itemId StoreItems.itemId%TYPE;
l_itemType StoreItems.itemType%TYPE;
l_title ComicBook.title%TYPE;
l_price StoreItems.price%TYPE;
l_dateOrdered ItemOrders.date_of_order%TYPE;
l_dateShipped ItemOrders.shipped_date%TYPE;
l_shippingFee ItemOrders.shippingFee%TYPE;
l_numOrders ItemOrders.num_of_items%TYPE;
l_subtotal NUMBER(32,2);
l_orderTotal NUMBER(32,2);
l_grandTotal NUMBER(32,2);
l_tax NUMBER(5,2);
l_discount NUMBER(5,2);

CURSOR c_itemOrder IS
	SELECT * FROM ItemOrders WHERE custId = p_custId AND p_date <= date_of_order;
l_itemOrder c_itemOrder%ROWTYPE;

TYPE v_itemPriceArray IS TABLE OF NUMBER(32,2) INDEX BY PLS_INTEGER;
v_itemPriceTotal v_itemPriceArray;
i_orderNum PLS_INTEGER;

BEGIN
-- Get Customer Details
SELECT name, email, address, custType INTO l_name, l_email, l_address, l_custType FROM Customer WHERE custId = p_custId;
dbms_output.put_line(chr(10)||'----Customer Info----');
dbms_output.put_line('CustomerId: '|| p_custId || chr(10) ||
					 'Name: '|| l_name || chr(10) ||
					 'Customer Type: ' || l_custType || chr(10) ||
					 'Contact Info: '|| l_email || chr(10) ||
					 'Address: '|| l_address || chr(10)
);

-- Get details of orders place
dbms_output.put_line(chr(10)||'----Information regarding Orders Placed----'||chr(10));
l_grandTotal := 0;
FOR l_itemOrder IN c_itemOrder
LOOP
	dbms_output.put_line('** Order: ' || l_itemOrder.orderId || ' **');
	l_itemId := l_itemOrder.itemId;

	--SELECT date_of_order, shipped_date, num_of_items INTO l_dateOrdered, l_dateShipped, l_numOrdered
	--FROM ItemOrders WHERE itemId = l_itemId AND orderId = l_itemOrder.orderId;

	SELECT price, itemType INTO l_price, l_itemType FROM StoreItems WHERE itemId = l_itemId;

	IF UPPER(l_itemType) = UPPER('comic') THEN
		SELECT title INTO l_title FROM ComicBook WHERE itemId = l_itemId;
	ELSE
		l_title := '*Item Exception! Not a comic book*';
	END IF;
	l_orderTotal := computeTotal(l_itemOrder.orderId, l_shippingFee, l_tax, l_discount, l_subtotal);

	dbms_output.put_line('OrderId: '|| l_itemOrder.orderId || chr(10) ||
						 'ItemId: ' || l_itemId || chr(10) ||
						 'Title: ' || l_title || chr(10) ||
						 'Price: ' || l_price || chr(10) ||
						 'Quantity: ' || l_itemOrder.num_of_items || chr(10) ||
						 'Date Ordered: ' || l_itemOrder.date_of_order || chr(10) ||
						 'Date Shipped: ' || l_itemOrder.shipped_date || chr(10)
	);
	
	
	
	dbms_output.put_line('Payment Details of Item: ' || l_itemOrder.orderId || chr(10) ||
						'Subtotal For Item ' || l_itemOrder.orderId || ' Before Tax, Shipping, and Discounts: ' || l_subtotal || chr(10) ||
						'Tax: ' || l_tax || chr(10) ||
						'Shipping Fee: ' || l_shippingFee || chr(10) ||
						'Total After Tax, Shipping and Discounts: ' || l_orderTotal || chr(10)
	);
	l_grandTotal := l_grandTotal + l_orderTotal;
END LOOP;

dbms_output.put_line('=> Grand Total: ' || l_grandTotal);

-- Payment Details

END;
/
SHOW ERRORS;
