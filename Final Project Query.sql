CREATE DATABASE DWH_Project

USE DWH_Project

CREATE TABLE DimCustomer (
	IDCustomer int NOT NULL,
	CustomerName varchar(50) NOT NULL,
	Age int NOT NULL,
	Gender varchar(50) NOT NULL,
	City varchar(50) NOT NULL,
	No_hp varchar(50) NOT NULL,
	CONSTRAINT PK_DimCustomer PRIMARY KEY (IDCustomer)
)

CREATE TABLE DimProduct (
	IDProduct int NOT NULL,
	Product_name varchar(255) NOT NULL,
	Product_category varchar(255) NOT NULL,
	Product_unit_price int NULL,
	CONSTRAINT PK_DimProduct PRIMARY KEY (IDProduct)
)

CREATE TABLE DimStatusOrder (
	IDStatus int NOT NULL,
	Status_order varchar(50) NOT NULL,
	Status_order_desc varchar(50) NOT NULL,
	CONSTRAINT PK_DimStatusOrder PRIMARY KEY (IDStatus)
)

CREATE TABLE FactSalesOrder (
	IDOrder int NOT NULL,
	IDCustomer int NOT NULL,
	IDProduct int NOT NULL,
	IDStatus int NOT NULL,
	Quantity int NOT NULL,
	Amount int NOT NULL,
	Order_date date NOT NULL,
	CONSTRAINT PK_FactSalesOrder PRIMARY KEY (IDOrder),
	CONSTRAINT FK_CustomerOrder FOREIGN KEY (IDCustomer) REFERENCES DimCustomer (IDCustomer),
	CONSTRAINT FK_ProductOrder FOREIGN KEY (IDProduct) REFERENCES DimProduct (IDProduct),
	CONSTRAINT FK_StatusOrder FOREIGN KEY (IDStatus) REFERENCES DimStatusOrder (IDStatus)
)

SELECT * FROM DimCustomer

CREATE OR ALTER PROCEDURE summary_order_status
(@StatusID varchar(50)) AS
BEGIN
	SELECT 
		a.IDOrder,
		b.CustomerName,
		d.Product_name,
		a.Quantity, 
		c.Status_order
	FROM FactSalesOrder a
	INNER JOIN DimCustomer b on a.IDCustomer = b.IDCustomer
	INNER JOIN DimStatusOrder c on a.IDStatus = c.IDStatus
	INNER JOIN DimProduct d on a.IDProduct = d.IDProduct
	WHERE a.IDStatus = @StatusID
END

EXEC summary_order_status @StatusID = 1
EXEC summary_order_status @StatusID = 2
EXEC summary_order_status @StatusID = 3
EXEC summary_order_status @StatusID = 4
EXEC summary_order_status @StatusID = 5
