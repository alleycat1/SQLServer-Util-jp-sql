USE [DemoDB]
GO

-- �����v�����̐���
ALTER DATABASE SCOPED CONFIGURATION  CLEAR PROCEDURE_CACHE  
GO
DECLARE @status varchar(1) = '2'
EXEC sp_executesql N'SELECT AVG(Flag) FROM T_Emp WHERE Status = @p1', N'@p1 varchar(1)', @status
GO 30

-- �v�����̑ލs
ALTER DATABASE SCOPED CONFIGURATION  CLEAR PROCEDURE_CACHE  
GO
DECLARE @status varchar(1) = '1'
EXEC sp_executesql N'SELECT AVG(Flag) FROM T_Emp WHERE Status = @p1', N'@p1 varchar(1)', @status
GO 

-- �ލs�����v�������g�p
DECLARE @status varchar(1) = '2'
EXEC sp_executesql N'SELECT AVG(Flag) FROM T_Emp WHERE Status = @p1', N'@p1 varchar(1)', @status
GO 30