-- �]���̏��̎擾���@
EXEC master.dbo.xp_msver

-- SQL Server 2017 �� OS ���̎擾���@
SELECT * FROM sys.dm_os_host_info
 
-- Linux �֘A�̏��
SELECT * FROM sys.dm_linux_proc_all_stat
SELECT * FROM sys.dm_linux_proc_cpuinfo
SELECT * FROM sys.dm_linux_proc_meminfo
SELECT * FROM sys.dm_linux_proc_sql_maps
SELECT * FROM sys.dm_linux_proc_sql_threads
