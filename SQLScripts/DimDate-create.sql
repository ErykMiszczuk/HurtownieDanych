IF OBJECT_ID('DimSource','U') IS NOT NULL 
DROP TABLE DimDate;

CREATE TABLE DimDate (DataKEY DATETIME PRIMARY KEY, Year INT, Month INT, Day INT, DayOfWeek INT, Quarter INT);

SELECT distinct [Data] As DataKEY,
	DATEPART(year, [Data]) AS Year,
	DATEPART(month, [Data]) AS Month,
	DATEPART(day, [Data]) AS Day,
	DATEPART(weekday, [Data]) AS DayOfWeek,
	DATEPART(quarter, [Data]) AS Quarter
INTO [HurtowniaLab].[dbo].DimSource
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];