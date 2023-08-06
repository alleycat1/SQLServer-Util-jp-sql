-- �������p
USE master
GO
IF EXISTS (SELECT * FROM sys.certificates WHERE name = 'MyServerCert')
	DROP CERTIFICATE MyServerCert
GO
IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE symmetric_key_id = 101)  
    DROP MASTER KEY
GO  

-- master �f�[�^�x�[�X�Ƀ}�X�^�[�L�[���쐬
USE master
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<UseStrongPasswordHere>'
-- master �f�[�^�x�[�X�ɁA���[�U�[�f�[�^�x�[�X�ɍ쐬����f�[�^�x�[�X�}�X�^�[�L�[�̈Í����p�ؖ������쐬
CREATE CERTIFICATE MyServerCert WITH SUBJECT = 'My DEK Certificate';  
GO
-- �쐬�����ؖ����̃o�b�N�A�b�v���擾���� (�o�b�N�A�b�v���擾���Ă��Ȃ��ꍇ�A�f�[�^�x�[�X�Í����L�[�Ɏw�肵���ۂɌx�����o�͂����)
BACKUP CERTIFICATE MyServerCert 
TO FILE='C:\temp\MyServerCert.cer'
WITH PRIVATE KEY(
FILE = 'C:\temp\MyServerCertt.pvk',
ENCRYPTION BY PASSWORD = 'P@$$W0rd'
)
GO


-- ���[�U�[�f�[�^�x�[�X�Ƀf�[�^�x�[�X�Í����L�[���쐬
USE TEST
GO
IF EXISTS (SELECT * FROM sys.dm_database_encryption_keys WHERE database_id = DB_ID())
	DROP DATABASE ENCRYPTION KEY
GO

CREATE DATABASE ENCRYPTION KEY  
WITH ALGORITHM = AES_128  
ENCRYPTION BY SERVER CERTIFICATE MyServerCert
GO  


-- �Í����Ɏg�p���Ă���ؖ����̃o�b�N�A�b�v���擾����Ă��Ȃ��ƃf�[�^�G�[�X�Í����L�[�̍쐬���Ɍx������������
SELECT name,pvt_key_encryption_type_desc, issuer_name, subject, pvt_key_last_backup_date 
FROM master.sys.certificates


-- ���ߓI�f�[�^�Í����̗L����
ALTER DATABASE TEST SET ENCRYPTION ON

-- ���ߓI�f�[�^�Í����́A�G�f�B�V�����ɂ��@�\���ƂȂ邽�߁A�g�p����Ă��邩�ǂ����� DMV ����m�F�ł���
SELECT * FROM sys.dm_db_persisted_sku_features

-- ���ߓI�f�[�^�Í����̉���
ALTER DATABASE TEST SET ENCRYPTION OFF
