SELECT distinct [Source] As SourceKey,
--ip albo program
		CASE (CHARINDEX(':',[Source]))
		WHEN 0
		THEN
			[Source]
	ELSE
		LEFT([Source], cast (CHARINDEX(':',Source)-1 as int))
		END AS Source,
--jaki rodzaj Source
		CASE (CHARINDEX(':',[Source]))
		WHEN 0
		THEN
			'App'
		ELSE
			'IP'
		END AS SourceType
--into [HurtowniaLab].[dbo].DimSource
FROM HurtowniaLab.[dbo].[ZoneAlarmLog];