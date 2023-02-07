CREATE OR REPLACE PROCEDURE setShippingDate(p_orderId IN varchar, p_shippingDate in DATE)
AS
BEGIN
	UPDATE ItemOrders SET shipped_date = p_shippingdate WHERE orderId = p_orderId;
END;
/
SHOW ERRORS;
