CREATE TABLE SERVICE
(SNUM NUMBER(3) NOT NULL,
SERVICENAME VARCHAR(255) NOT NULL,
PRICE INT NOT NULL,
PRIMARY KEY (SNUM)
);

CREATE TABLE PROVIDES
(BNO NUMBER(3) NOT NULL,
SERVICENAME VARCHAR(255) NOT NULL,
PRIMARY KEY (BNO)
);

CREATE TABLE CUSTOMER
(
SSN Number(9) PRIMARY KEY NOT NULL,
FNAME VARCHAR(255) NOT NULL,
MINIT VARCHAR(1),
LNAME VARCHAR(255) NOT NULL,
SEX VARCHAR(1) NOT NULL,
PHONE VARCHAR(12) NOT NULL,
ADDRESS VARCHAR(255) NOT NULL
);

CREATE TABLE SUPPLIER
(
SSN Number(9) PRIMARY KEY NOT NULL,
FNAME VARCHAR(255) NOT NULL,
MINIT VARCHAR(1),
LNAME VARCHAR(255) NOT NULL,
SEX VARCHAR(1) NOT NULL,
PHONE VARCHAR(12) NOT NULL,
ADDRESS VARCHAR(255) NOT NULL
);

CREATE TABLE REPRESENTATIVES
(
ID NUMBER(3) PRIMARY KEY NOT NULL,
FNAME VARCHAR(255) NOT NULL,
MINIT VARCHAR(1),
LNAME VARCHAR(255) NOT NULL,
SEX VARCHAR(1) NOT NULL,
PHONE VARCHAR(12) NOT NULL,
SalesLEVEL INT DEFAULT '1',
STARTDATE DATE NOT NULL
);

CREATE TABLE WORKS_ON(
BNO REFERENCES BRANCH(BNUM)
ID REFERENCES REPRESENTATIVES(ID)
PRIMARY KEY(BNO,ID)
);

CREATE TABLE BRANCH
(
BNUM NUMBER(3) PRIMARY KEY NOT NULL,
Address VARCHAR(255) NOT NULL,
MGRID REFERENCES REPRESENTATIVES(ID) ON DELETE SET NULL
);


CREATE TABLE VEHICLE(
Vin VARCHAR(17) PRIMARY KEY NOT NULL,
Model VARCHAR(255) NOT NULL,
Make VARCHAR(255) NOT NULL,
YEAR NUMBER(4) NOT NULL,
Mileage INT NOT NULL,
MSRP INT,
Bnum REFERENCES BRANCH(Bnum) ON DELETE SET NULL,
SupSsn REFERENCES SUPPLIER(SSN) ON DELETE SET NULL,
CusSsn REFERENCES CUSTOMER(SSN) ON DELETE SET NULL
);



CREATE TABLE BUYS(
RID REFERENCES REPRESENTATIVES(ID),
VIN REFERENCES VEHICLE(VIN),
CUSSSN  REFERENCES CUSTOMER(SSN),
PRICEOUT INT,
BDATE DATE,
PRIMARY KEY(RID,VIN,CUSSSN)
);

CREATE TABLE SUPPLIES(
RID REFERENCES REPRESENTATIVES(ID),
VIN REFERENCES VEHICLE(VIN),
SUPSSN  REFERENCES SUPPLIER(SSN),
PRICEIN INT,
SDATE DATE,
PRIMARY KEY(RID,VIN,SUPSSN)
);

CREATE TABLE MAINTAINS(
VIN REFERENCES VEHICLE(VIN),
SNUM REFERENCES SERVICE(SNUM),
SERDATE DATE,
PRIMARY KEY(VIN,SNUM)
);
