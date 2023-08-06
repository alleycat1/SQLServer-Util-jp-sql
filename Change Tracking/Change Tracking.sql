-- �ύX�̒ǐՃe�X�g�p DB �̍쐬
CREATE DATABASE changetracking
go

-- �ύX�̒ǐՂ̗L����
USE changetracking
GO
CREATE TABLE CT_01(C1 int identity  primary key , C2 varchar(36), C3 varchar(36), C4 varchar(36))
CREATE TABLE CT_02(C1 int identity  primary key , C2 varchar(36), C3 varchar(36), C4 varchar(36))
GO
ALTER DATABASE [changetracking] SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 1 MINUTES)
GO
ALTER TABLE CT_01 ENABLE CHANGE_TRACKING  
ALTER TABLE CT_02 ENABLE CHANGE_TRACKING  
GO
ALTER TABLE CT_01 DISABLE CHANGE_TRACKING  
ALTER TABLE CT_02 DISABLE CHANGE_TRACKING  
GO

-- Change Tracking �̃e�[�u���̊m�F
SELECT * FROM sys.internal_tables
WHERE internal_type_desc IN('CHANGE_TRACKING', 'TRACKED_COMMITTED_TRANSACTIONS')
GO

-- �e�X�g�p�f�[�^�̓���
SET NOCOUNT ON
GO

DECLARE @cnt int = 1
-- BEGIN TRAN
WHILE(@cnt <= 100000)
BEGIN
	INSERT INTO CT_01 DEFAULT VALUES
	INSERT INTO CT_02 DEFAULT VALUES
	SET @cnt += 1
	DBCC FREEPROCCACHE WITH NO_INFOMSGS
END
UPDATE CT_01 SET C2 = NEWID()
UPDATE CT_02 SET C2 = NEWID()
-- COMMIT TRAN

DELETE FROM CT_01
DELETE FROM CT_02
CHECKPOINT
GO 1000



-- �f�[�^�����̊m�F
SELECT 
	object_name(p.object_id) as name, p.index_id, p.rows 
FROM 
	sys.partitions  AS p
	INNER JOIN sys.objects AS o
		ON o.object_id = p.object_id
WHERE 
	(p.object_id = object_id('sys.syscommittab') OR o.name LIKE 'change[_]tracking[_]%')
	AND p.index_id = 1

-- Water Mark �̊m�F
SELECT * FROM sys.change_tracking_tables

-- �蓮�N���[���A�b�v�p�X�g�A�h�v���V�[�W���̎��s
EXEC sys.sp_flush_commit_table_on_demand
EXEC dbo.sp_flush_CT_internal_table_on_demand @TableToClean = 'CT_01'

EXEC sp_helptext 'dbo.sp_flush_CT_internal_table_on_demand'
EXEC sp_helptext 'sys.sp_flush_commit_table_on_demand '


GO

-- Change Tracking �Ɋ֘A����N�G���̎擾
DBCC FREEPROCCACHE
go

select * from sys.dm_exec_query_stats
outer apply sys.dm_exec_sql_text(sql_handle)
outer apply sys.dm_exec_query_plan(plan_handle)
where text like '%flush%' or text like '%change%' 

select * from sys.dm_exec_procedure_stats
outer apply sys.dm_exec_sql_text(sql_handle)
outer apply sys.dm_exec_query_plan(plan_handle)
where text like '%flush%' or text like '%change%' 
