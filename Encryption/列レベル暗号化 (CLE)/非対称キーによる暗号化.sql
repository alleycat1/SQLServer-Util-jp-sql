DROP TABLE IF EXISTS T1

IF EXISTS (SELECT * FROM sys.asymmetric_keys WHERE name = 'AsymKey')
	DROP ASYMMETRIC KEY AsymKey
GO

CREATE TABLE T1(
	id int IDENTITY(1, 1),
	ClearText nvarchar(100),
	EncryptData varbinary(max)
) 
GO

-- ��Ώ̃L�[�̍쐬
CREATE ASYMMETRIC KEY AsymKey
WITH ALGORITHM =RSA_2048  
ENCRYPTION BY PASSWORD = 'P@$$w0rd'
GO

--�Í����֐��Ńf�[�^���Í������� INSERT
INSERT INTO T1 VALUES ( '�����̃f�[�^', EncryptByAsymKey(AsymKey_ID('AsymKey'), N'�Í����f�[�^') )
GO

-- �Í�������Ă��邱�Ƃ̊m�F
SELECT * FROM T1

-- �������֐��ňÍ������������ăf�[�^���擾
SELECT 
	ID, 
	ClearText,
	CONVERT( nvarchar, DecryptByAsymKey(AsymKey_ID('AsymKey'), EncryptData, N'P@$$w0rd'))
FROM T1
GO
