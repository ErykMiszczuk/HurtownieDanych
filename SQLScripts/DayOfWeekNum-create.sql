IF OBJECT_ID('DimDateDayOfWeekName','U') IS NOT NULL 
DROP TABLE DimDateDayOfWeekName;
-- create DimDataMonthName
CREATE TABLE DimDateDayOfWeekName (DayOfWeekNum INT PRIMARY KEY, DayOfWeekName VARCHAR(30));
INSERT INTO DimDateDayOfWeekName (DayOfWeekNum, DayOfWeekName) VALUES (1, 'Niedziela'),
	(2, 'Poniedzia�ek'),
	(3, 'Wtorek'),
	(4, '�roda'),
	(5, 'Czwartek'),
	(6, 'Pi�tek'),
	(7, 'Sobota');