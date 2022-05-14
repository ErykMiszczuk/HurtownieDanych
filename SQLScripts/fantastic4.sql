-- Dim MEGAZORD
USE [HurtowniaLab]
GO
-- day of week
IF OBJECT_ID('DimDateDayOfWeekName','U') IS NOT NULL 
DROP TABLE [DimDateDayOfWeekName];

CREATE TABLE DimDateDayOfWeekName (DayOfWeekNum INT PRIMARY KEY, DayOfWeekName VARCHAR(30));

INSERT INTO DimDateDayOfWeekName (DayOfWeekNum, DayOfWeekName) VALUES (1, 'Niedziela'),
	(2, 'Poniedzia³ek'),
	(3, 'Wtorek'),
	(4, 'Œroda'),
	(5, 'Czwartek'),
	(6, 'Pi¹tek'),
	(7, 'Sobota');

--month name
IF OBJECT_ID('DimDataMonthName','U') IS NOT NULL 
DROP TABLE [DimDataMonthName];

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


-- transport
IF OBJECT_ID('DimTransport','U') IS NOT NULL 
DROP TABLE [DimTransport];

--CREATE TABLE DimTransport (TransportKey VARCHAR(300) PRIMARY KEY, Transport VARCHAR(300), TransportType VARCHAR(300), TransportSubType VARCHAR(300), TransportFlags VARCHAR(300));

SELECT distinct [Transport] As TransportKey,
--transport
	CASE (CHARINDEX(' ',[Transport]))
		WHEN 0
		THEN
			[Transport]
		ELSE
			LEFT([Transport], cast (CHARINDEX(' ', [Transport])-1 as int))
		END AS Transport,
--transport type
	CASE (PATINDEX('%type:%',[Transport]))
		WHEN 0
		THEN
			' '
		ELSE
			SUBSTRING([Transport], PATINDEX('%type:%',[Transport])+5, 1)
		END AS TransportType,
--transport sub type
	CASE (PATINDEX('%subtype:%',[Transport]))
		WHEN 0
		THEN
			' '
		ELSE
			SUBSTRING([Transport], PATINDEX('%subtype:%',[Transport])+8, 1)
		END AS TransportSubType,
--transport sub type
	CASE (PATINDEX('%flags:%',[Transport]))
		WHEN 0
		THEN
			' '
		ELSE
			SUBSTRING([Transport], PATINDEX('%flags:%',[Transport])+6, cast(LEN([Transport])-(PATINDEX('%flags:%',[Transport])+6) as int) )
		END AS TransportFlags
INTO [HurtowniaLab].[dbo].DimTransport
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];


-- source
IF OBJECT_ID('DimSource','U') IS NOT NULL 
DROP TABLE [DimSource];

--CREATE TABLE DimSource (SourceKey VARCHAR(300) PRIMARY KEY, Source VARCHAR(300), SourcePort VARCHAR(300), SourceType VARCHAR(300));

SELECT distinct [Source] As SourceKey,
--ip albo program
		CASE (CHARINDEX(':',[Source]))
		WHEN 0
		THEN
			[Source]
	ELSE
		LEFT([Source], cast (CHARINDEX(':',Source)-1 as int))
		END AS Source,
--port
	CASE (CHARINDEX(':',[Source]))
		WHEN 0
		THEN
			[Source]
		ELSE
		RIGHT([Source], cast (LEN([Source]) - CHARINDEX(':', [Source]) as int))
		END AS SourcePort,
--jaki rodzaj Source
		CASE (CHARINDEX(':',[Source]))
		WHEN 0
		THEN
			'App'
		ELSE
			'IP'
		END AS SourceType
INTO [HurtowniaLab].[dbo].DimSource
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];


-- destination
IF OBJECT_ID('DimDestination','U') IS NOT NULL 
DROP TABLE [DimDestination];

--CREATE TABLE DimDestination (DestinationKey VARCHAR(300) PRIMARY KEY, Destination VARCHAR(300), DestinationPort VARCHAR(300), DestinationType VARCHAR(300));

SELECT distinct [Destination] As DestinationKey,
--ip albo program
	CASE (CHARINDEX(':',[Destination]))
		WHEN 0
		THEN
			[Destination]
		ELSE
		LEFT([Destination], cast (CHARINDEX(':', Destination)-1 as int))
		END AS Destination,
--port
	CASE (CHARINDEX(':',[Destination]))
		WHEN 0
		THEN
			[Destination]
		ELSE
		RIGHT([Destination], cast (LEN(Destination) - CHARINDEX(':', Destination) as int))
		END AS DestinationPort,
--jaki rodzaj Source
	CASE (CHARINDEX(':',[Destination]))
		WHEN 0
		THEN
			'App'
		ELSE
			'IP'
		END AS DestinationType
INTO [HurtowniaLab].[dbo].DimDestination
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];

-- date
IF OBJECT_ID('DimDate','U') IS NOT NULL 
DROP TABLE [DimDate];

--CREATE TABLE DimDate (DataKEY DATETIME PRIMARY KEY, Year INT, Month INT, Day INT, DayOfWeek INT, Quarter INT);

SELECT distinct [Data] As DataKEY,
	DATEPART(year, [Data]) AS Year,
	DATEPART(month, [Data]) AS Month,
	DATEPART(day, [Data]) AS Day,
	DATEPART(weekday, [Data]) AS DayOfWeek,
	DATEPART(quarter, [Data]) AS Quarter
INTO [HurtowniaLab].[dbo].DimDate
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];