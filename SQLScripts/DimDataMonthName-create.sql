IF OBJECT_ID('DimDataMonthName','U') IS NOT NULL 
DROP TABLE DimDataMonthName;
-- create DimDataMonthName
CREATE TABLE DimDataMonthName (MonthNum INT PRIMARY KEY, MonthName VARCHAR(30));
INSERT INTO DimDataMonthName (MonthNum, MonthName) VALUES (1, 'Stycze�'),
	(2, 'Luty'),
	(3, 'Marzec'),
	(4, 'Kwiecie�'),
	(5, 'Maj'),
	(6, 'Czerwiec'),
	(7, 'Lipiec'),
	(8, 'Sierpie�'),
	(9, 'Wrzesie�'),
	(10, 'Pa�dziernik'),
	(11, 'Listopad'),
	(12, 'Grudzie�');