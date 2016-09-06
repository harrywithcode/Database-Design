/*1*/
CREATE OR REPLACE TRIGGER manager_candidate
  after  delete ON BRANCH
    FOR each row
DECLARE
  rid integer;
  num_sal INTEGER;
  num_rep INTEGER;
  CURSOR everyrid IS
    SELECT rid From serves
    FOR UPDATE;
BEGIN  
  LOOP
  fetch everyrid into num_rep;
  EXIT WHEN(everyrid%NOTFOUND);
  SELECT RID INTO num_sal FROM serves 
  group by RID
  having count(*)>5;
  DBMS_OUTPUT.PUT_LINE(RID || 'is a good candidate');
  end loop;
END;

/*2*/
CREATE OR REPLACE TRIGGER REPRESENTATIVES_count
  before insert or delete ON REPRESENTATIVES
    FOR EACH ROW
DECLARE
  n INTEGER;
BEGIN
  SELECT COUNT(*) INTO n FROM REPRESENTATIVES;
  DBMS_OUTPUT.PUT_LINE('There are now ' || n || ' representatives');
END;

/*3*/
CREATE OR REPLACE TRIGGER price_changes
  AFTER UPDATE ON SERVICE
    FOR EACH ROW
DECLARE
  price_CHANGE INTEGER;
BEGIN
  price_CHANGE:=:NEW.PRICE;
  DBMS_OUTPUT.PUT_LINE('Old PRICE:'|| :OLD.PRICE);
  DBMS_OUTPUT.PUT_LINE('New PRICE:'||price_CHANGE);
END;

/*4*/
CREATE OR REPLACE TRIGGER representatives_evaluate
  AFTER UPDATE ON SERVES
    FOR EACH ROW
DECLARE  
  num_sale INTEGER; 
BEGIN  
  SELECT COUNT(*) INTO num_sale FROM serves
  WHERE RID=:NEW.RID;
  IF (num_sale >5) THEN
  DBMS_OUTPUT.PUT_LINE('Good');
  ELSIF (num_sale>3) THEN
  DBMS_OUTPUT.PUT_LINE('Average');
  ELSIF (num_sale<4) THEN
  DBMS_OUTPUT.PUT_LINE('Bad');
  END IF;
END;
