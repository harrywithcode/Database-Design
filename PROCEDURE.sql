/*This procedure needs no parameter.It prints out the loss and vin of cars that are sold with a negative revenue.*/
CREATE OR REPLACE PROCEDURE loss
AS
  REVENUE INT;
  VINNUM  NUMBER(9);
  CURSOR C IS 
    SELECT B.PRICEOUT-S.PRICEIN as p, B.VIN
    FROM BUYS B
    JOIN SUPPLIES S ON B.VIN=S.VIN
    WHERE B.PRICEOUT IS NOT NULL;
BEGIN
  OPEN C;
  LOOP
    FETCH C INTO REVENUE, VINNUM;
    EXIT WHEN (C%NOTFOUND);
    IF (REVENUE<0) THEN
      dbms_output.put_line('Loss of '||REVENUE ||', whose VIN is ' || VINNUM);
    END IF;
  END LOOP;
  CLOSE C;
END;

/*This procedure needs two parameters: RepresentativeID and BranchNO. It assigns RID as the manager ID of branch whose branch number is BNO. And then, if the level of the representative is lower than 5, it promotes the representative to level 5 immediately(in order to reward representative who made an excellent contribute to the company). */
CREATE OR REPLACE PROCEDURE ASSIGNMGR(RID IN INT,BNO IN INT)
AS
LEVELNOW NUMBER(3);
BEGIN
  UPDATE BRANCH 
  SET MGRID=RID
  WHERE BNUM=BNUM;
  
  SELECT SALESLEVEL INTO LEVELNOW
  FROM REPRESENTATIVES
  WHERE ID=RID;
  
  IF (LEVELNOW<5) THEN
    UPDATE REPRESENTATIVES 
    SET SALESLEVEL=5
    WHERE ID=RID;
  END IF;
END;



/*Using cursor, once the start date and ending date are entered as arguements, the procedure will print out the cars that are sold during this period as well as its buyers, prices.*/
CREATE OR REPLACE PROCEDURE SALE(SDATE IN DATE, EDATE IN DATE)
AS
  MYROW BUYS%ROWTYPE;
  CURSOR C IS
    SELECT * From BUYS;
BEGIN
  OPEN C;
  LOOP
    FETCH C INTO MYROW;
    EXIT WHEN(C%NOTFOUND);
    IF(SYSDATE>SDATE AND SYSDATE < EDATE) THEN
      dbms_output.put_line(MYROW.VIN||' was sold at price of ' ||MYROW.PRICEOUT||' by Customer '||MYROW.CUSSSN);
    END IF;
  END LOOP;
  CLOSE C;
END;
