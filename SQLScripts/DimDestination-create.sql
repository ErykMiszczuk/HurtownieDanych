IF OBJECT_ID('DimDestination','U') IS NOT NULL 
DROP TABLE DimDestination;

CREATE TABLE DimDestination (DestinationKey VARCHAR(300) PRIMARY KEY, Destination VARCHAR(300), DestinationPort VARCHAR(300), DestinationType VARCHAR(300));

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