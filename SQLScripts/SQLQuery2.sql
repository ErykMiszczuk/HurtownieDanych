/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct COUNT([id])
      ,[Zdarzenie]
FROM [HurtowniaLab].[dbo].[ZoneAlarmLog]
GROUP BY [Zdarzenie]