SELECT 
	*
FROM 
	distribution.dbo.MSsysservers_replservers WITH(NOLOCK)
OPTION (RECOMPILE, MAXDOP 1)


-- ���v���P�[�V�����̍폜�Ɏ��s���āA���̕s���������������ꍇ�̑Ή�
-- https://sqlaj.wordpress.com/2012/03/23/cannot-drop-server-repl_distributor-because-it-is-used-as-a-distributor/
SELECT 
	* 
FROM
	master.dbo.sysservers 
WHERE 
	pub <> 0 or sub <> 0 or dist <> 0