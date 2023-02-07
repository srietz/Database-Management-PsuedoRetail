CREATE OR REPLACE FUNCTION computeTotal(p_orderId IN varchar, l_shippingFee OUT NUMBER, l_tax OUT NUMBER, l_discount OUT NUMBER, l_subtotal OUT NUMBER) RETURN NUMBER
AS
l_custId Customer.custId%TYPE;
l_custType Customer.custType%TYPE;
l_itemId StoreItems.itemId%type;
l_price StoreItems.price%TYPE;
l_quantity ItemOrders.num_of_items%TYPE;
BEGIN
	l_tax := 5;
	
	SELECT custid, itemId, num_of_items, shippingFee INTO l_custId, l_itemId, l_quantity, l_shippingFee 
	FROM ItemOrders WHERE orderId = p_orderId;
	SELECT custType INTO l_custType FROM Customer WHERE custId = l_custId;
	SELECT price INTO l_price FROM StoreItems WHERE itemId = l_itemId;
	
	IF UPPER(l_custType) = UPPER('gold') THEN
		l_discount := 10;
		l_shippingFee := 0;
		l_subtotal := (l_price*l_quantity);
		IF l_subtotal < 100 THEN
			RETURN l_subtotal*(1+(0.01*l_tax));
		ELSE
			RETURN l_subtotal*(1+(0.01*l_tax))*(1-(0.01*l_discount));
		END IF;
	ELSE 
		l_discount := 0;
		l_shippingFee := 10;
		l_subtotal := l_price*l_quantity;
		RETURN (l_subtotal + l_shippingFee)*(1+(0.01*l_tax));
	END IF;
END;
/
SHOW ERRORS;
