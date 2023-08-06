DROP TABLE IF EXISTS T1

CREATE TABLE T1(
	id int IDENTITY(1, 1),
	ClearText nvarchar(100),
	EncryptData varbinary(max)
) 
GO

--�Í����֐��Ńf�[�^���Í������� INSERT
INSERT INTO T1 VALUES ( '�����̃f�[�^', EncryptByPassPhrase('P@$$w0rd', N'�Í����f�[�^') )
GO

-- �Í�������Ă��邱�Ƃ̊m�F
SELECT * FROM T1

-- �������֐��ňÍ������������ăf�[�^���擾
SELECT 
	ID, 
	ClearText,
	CONVERT( nvarchar, DecryptByPassPhrase( N'P@$$w0rd', EncryptData))
FROM T1
GO
