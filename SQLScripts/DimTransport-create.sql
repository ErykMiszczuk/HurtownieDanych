IF OBJECT_ID('DimTransport','U') IS NOT NULL 
DROP TABLE DimTransport;

CREATE TABLE DimTransport (TransportKey VARCHAR(300) PRIMARY KEY, Transport VARCHAR(300), TransportType VARCHAR(300), TransportSubType VARCHAR(300), TransportFlags VARCHAR(300));

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
			--LEFT([Transport], cast (CHARINDEX(':',Source)-1 as int))
			SUBSTRING([Transport], PATINDEX('%type:%',[Transport])+5, 1)
		END AS TransportType,
--transport sub type
	CASE (PATINDEX('%subtype:%',[Transport]))
		WHEN 0
		THEN
			' '
		ELSE
			--LEFT([Transport], cast (CHARINDEX(':',Source)-1 as int))
			SUBSTRING([Transport], PATINDEX('%subtype:%',[Transport])+8, 1)
		END AS TransportType,
--transport sub type
	CASE (PATINDEX('%flags:%',[Transport]))
		WHEN 0
		THEN
			' '
		ELSE
			--LEFT([Transport], cast (CHARINDEX(':',Source)-1 as int))
			SUBSTRING([Transport], PATINDEX('%flags:%',[Transport])+6, cast(LEN([Transport])-(PATINDEX('%flags:%',[Transport])+6) as int) )
		END AS TransportFlags
INTO [HurtowniaLab].[dbo].DimTransport
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];