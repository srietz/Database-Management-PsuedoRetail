CREATE OR REPLACE TRIGGER custTypeChange_trig
AFTER UPDATE OF custType ON Customer
FOR EACH ROW
BEGIN
	IF UPPER(:NEW.custType) = UPPER('Gold') THEN
		UPDATE ItemOrders
		SET shippingFee = 0
		WHERE custId = :NEW.custId;
	END IF;
END;
/
SHOW Errors;
