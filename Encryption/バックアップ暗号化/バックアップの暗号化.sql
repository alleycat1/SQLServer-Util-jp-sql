-- �o�b�N�A�b�v�Í����̏ؖ����� master �f�[�^�x�[�X��ɑ��݂��Ă���K�v������
USE master  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<master key p@$$w0rd>';  
GO  
CREATE CERTIFICATE MyTestDBBackupEncryptCert  
   WITH SUBJECT = 'MyTestDB Backup Encryption Certificate';  
GO
  
BACKUP DATABASE [TEST] TO  
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLENTERPRISE\MSSQL\Backup\TEST.bak' 
WITH FORMAT, INIT,  NAME = N'TEST-���S �f�[�^�x�[�X �o�b�N�A�b�v', SKIP, NOREWIND, NOUNLOAD, 
ENCRYPTION(ALGORITHM = AES_256, SERVER CERTIFICATE = [MyTestDBBackupEncryptCert]),  STATS = 10
GO

-- �Í����Ɏg�p���Ă���ؖ����̃o�b�N�A�b�v���擾����Ă��Ȃ��ƃo�b�N�A�b�v���Ɍx������������
SELECT name,pvt_key_encryption_type_desc, issuer_name, subject, pvt_key_last_backup_date 
FROM sys.certificates

BACKUP CERTIFICATE MyTestDBBackupEncryptCert 
TO FILE='C:\temp\MyTestDBBackupEncryptCert.cer'
WITH PRIVATE KEY(
FILE = 'C:\temp\MyTestDBBackupEncryptCert.pvk',
ENCRYPTION BY PASSWORD = 'P@$$W0rd'
)
GO

-- �Í����Ɏg�p�����ؖ����̃C���|�[�g
DROP CERTIFICATE MyTestDBBackupEncryptCert -- �e�X�g�p�ɏؖ������폜
GO

-- �ؖ����d��Ŕ��f���Ă��邽�߁A�C���|�[�g���̖��͈̂قȂ���̂ł����Ȃ�
CREATE CERTIFICATE MyTestDBBackupEncryptCert_2 
FROM FILE = 'C:\temp\MyTestDBBackupEncryptCert.cer'
WITH PRIVATE KEY( 
FILE = 'C:\temp\MyTestDBBackupEncryptCert.pvk',
DECRYPTION BY PASSWORD = 'P@$$W0rd'
)

-- �Í����Ɏg�p�����ؖ����Ɠ���̝d��̏ؖ������g�p���ĈÍ������������ꃊ�X�g�A���s����
USE [master]
GO
ALTER DATABASE [TEST] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

RESTORE DATABASE [TEST] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLENTERPRISE\MSSQL\Backup\TEST.bak' 
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 5
GO

-- EncryptorThumbprint �Ńo�b�N�A�b�v�̈Í����L�������f�ł���
RESTORE HEADERONLY   
FROM DISK =  N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLENTERPRISE\MSSQL\Backup\TEST.bak' 
WITH NOUNLOAD
GO