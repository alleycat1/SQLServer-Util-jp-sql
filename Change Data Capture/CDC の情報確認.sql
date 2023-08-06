-- CDC �L������Ԃ̊m�F
SELECT name, is_cdc_enabled FROM sys.databases
GO

-- CDC �̗L����
EXEC sys.sp_cdc_enable_db
GO 

-- CDC �̃I�u�W�F�N�g�̊m�F
SELECT s.name,s.schema_id,o.name,o.type_desc
FROM sys.schemas AS s
    INNER JOIN sys.all_objects AS o
        ON o.schema_id = s.schema_id
WHERE s.name = 'cdc'
ORDER BY o.type_desc ASC, o.name ASC


-- CDC �e�[�u���̏��
SELECT * FROM cdc.change_tables
SELECT * FROM cdc.lsn_time_mapping
SELECT * FROM cdc.cdc_jobs



-- CDC �̖����� (�Ώۃe�[�u���̐ݒ�)
EXEC sys.sp_cdc_disable_table  
@source_schema = N'dbo',  
@source_name   = N'orders',  
@capture_instance = N'dbo_orders'  
GO

-- CDC �̗L���� (�Ώۃe�[�u���̐ݒ�)
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  
@source_name   = N'orders',  
@role_name     = NULL ,
@supports_net_changes = 1  


-- CDC �̃W���u�̐ݒ�
SELECT * FROM cdc.cdc_jobs

-- �W���u�̕ύX (SQL DB �̏ꍇ�Asp_cdc_stop_job / sp_cdc_start_job �̖����I�ȍċN���͕s�v)
EXEC sys.sp_cdc_change_job @job_type = 'cleanup', @retention='30'
