DROP TABLE IF EXISTS T1

IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'SymKey')
	DROP SYMMETRIC KEY SymKey
GO

CREATE TABLE T1(
	id int IDENTITY(1, 1),
	ClearText nvarchar(100),
	EncryptData varbinary(max)
) 
GO

-- �Ώ̃L�[�̍쐬
-- �Í����̓p�X���[�h�Ŏ��{���Ă��邽�߁A�}�X�^�[�L�[�̍쐬�͕s�v
CREATE SYMMETRIC KEY SymKey
WITH ALGORITHM =AES_256  
ENCRYPTION BY PASSWORD = 'P@$$w0rd'
GO

-- �ΏۃL�[�̃I�[�v��
OPEN SYMMETRIC KEY SymKey
DECRYPTION BY PASSWORD = 'P@$$w0rd'

--�Í����֐��Ńf�[�^���Í������� INSERT
INSERT INTO T1 VALUES ( '�����̃f�[�^', EncryptByKey(Key_GUID('SymKey'), N'�Í����f�[�^') )
GO

-- �Í�������Ă��邱�Ƃ̊m�F
SELECT * FROM T1


-- �������֐��ňÍ������������ăf�[�^���擾
SELECT 
	ID, 
	ClearText,
	CONVERT( nvarchar, DecryptByKey(EncryptData))
FROM T1
GO

-- �ΏۃL�[�̃N���[�Y
CLOSE SYMMETRIC KEY SymKey