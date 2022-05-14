IF OBJECT_ID('DimSource','U') IS NOT NULL 
DROP TABLE DimSource;

CREATE TABLE DimSource (SourceKey VARCHAR(300) PRIMARY KEY, Source VARCHAR(300), SourcePort VARCHAR(300), SourceType VARCHAR(300));

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