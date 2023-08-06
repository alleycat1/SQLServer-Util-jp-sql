USE [master]
GO
DROP DATABASE IF EXISTS DMVTEST
CREATE DATABASE DMVTEST
GO
ALTER DATABASE DMVTEST SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO

BACKUP DATABASE DMVTEST TO DISK=N'NUL'

-- modified_extent_page_count �ɂ��ADB �P�ʂŊ��S�o�b�N�A�b�v�ȍ~�ɕύX���ꂽ Extent ���擾�ł���
SELECT * FROM DMVTEST.sys.dm_db_file_space_usage

-- ���O�̓��v���擾
SELECT 
	name,
	ls.*
FROM 
	sys.databases
	CROSS APPLY
	sys.dm_db_log_stats(database_id) AS ls

-- VLF �̏����擾
SELECT
	name, 
	li.*
FROM
	sys.databases
	CROSS APPLY 
	sys.dm_db_log_info(database_id) li

-- DB �P�ʂ̃o�[�W�����X�g�A�̎g�p�󋵂̎擾
SELECT * FROM sys.dm_tran_version_store_space_usage 

-- CPU �\�P�b�g�̏�񂪒ǉ�
SELECT * FROM sys.dm_os_sys_info
