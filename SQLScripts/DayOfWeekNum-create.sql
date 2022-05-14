IF OBJECT_ID('DimDateDayOfWeekName','U') IS NOT NULL 
DROP TABLE DimDateDayOfWeekName;
-- create DimDataMonthName
CREATE TABLE DimDateDayOfWeekName (DayOfWeekNum INT PRIMARY KEY, DayOfWeekName VARCHAR(30));
INSERT INTO DimDateDayOfWeekName (DayOfWeekNum, DayOfWeekName) VALUES (1, 'Niedziela'),
	(2, 'Poniedzia³ek'),
	(3, 'Wtorek'),
	(4, 'Œroda'),
	(5, 'Czwartek'),
	(6, 'Pi¹tek'),
	(7, 'Sobota');