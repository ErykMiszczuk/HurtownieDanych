IF OBJECT_ID('DimDataMonthName','U') IS NOT NULL 
DROP TABLE DimDataMonthName;
-- create DimDataMonthName
CREATE TABLE DimDataMonthName (MonthNum INT PRIMARY KEY, MonthName VARCHAR(30));
INSERT INTO DimDataMonthName (MonthNum, MonthName) VALUES (1, 'Styczeñ'),
	(2, 'Luty'),
	(3, 'Marzec'),
	(4, 'Kwiecieñ'),
	(5, 'Maj'),
	(6, 'Czerwiec'),
	(7, 'Lipiec'),
	(8, 'Sierpieñ'),
	(9, 'Wrzesieñ'),
	(10, 'PaŸdziernik'),
	(11, 'Listopad'),
	(12, 'Grudzieñ');