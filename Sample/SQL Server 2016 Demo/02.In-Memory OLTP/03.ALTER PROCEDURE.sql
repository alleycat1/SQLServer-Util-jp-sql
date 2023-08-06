﻿
USE DemoDB
GO

IF OBJECT_ID('dbo.Procedure_Name','P') IS NOT NULL
   DROP PROCEDURE dbo.Procedure_Name
GO

CREATE PROCEDURE dbo.Procedure_Name
	@p1 int = 0, 
	@p2 int = 0
WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS BEGIN ATOMIC WITH
(
 TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'Japanese'
)
 SELECT @p1, @p2
END
GO

EXECUTE dbo.Procedure_Name
GO


ALTER PROCEDURE dbo.Procedure_Name
	@p1 int = 1, 
	@p2 nchar = 0
WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS BEGIN ATOMIC WITH
(
 TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'Japanese'
)
 SELECT @p1, @p2
END
GO


EXECUTE dbo.Procedure_Name
GO

