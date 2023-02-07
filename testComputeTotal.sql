CREATE OR REPLACE PROCEDURE testComputeTotal(p_orderId varchar)
AS
l_taxAmount NUMBER;
l_discount NUMBER;
l_subtotal NUMBER;
l_total NUMBER;
l_shippingFee NUMBER;
l_orderId varchar(5);
BEGIN
l_orderId := p_orderId;
l_total := computeTotal(l_orderId, l_shippingFee, l_taxAmount, l_discount, l_subtotal);
dbms_output.put_line('OrderId: ' || l_orderId || chr(10) ||
					'Tax(in percent): ' || l_taxAmount || chr(10) ||
					'Shiping Fee: ' || l_shippingFee || chr(10) ||
					'Discount(In percent): ' || l_discount || chr(10) ||
					'Subtotal(Before Discount): ' || l_subtotal || chr(10) ||
					'Total: ' || l_total
);

END;
/
SHOW errors;
