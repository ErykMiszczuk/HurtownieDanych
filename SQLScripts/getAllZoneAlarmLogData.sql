/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [id]
      ,[Zdarzenie]
      ,[Data]
      ,[Czas]
      ,[Source]
      ,[Destination]
      ,[Transport]
  FROM [HurtowniaLab].[dbo].[ZoneAlarmLog]

  /** TRUNCATE TABLE [HurtowniaLab].[dbo].[ZoneAlarmLog] **/
  SELECT COUNT(id) FROM [HurtowniaLab].[dbo].[ZoneAlarmLog]