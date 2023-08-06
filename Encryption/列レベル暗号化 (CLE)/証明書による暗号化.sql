DROP TABLE IF EXISTS T1

IF EXISTS (SELECT * FROM sys.certificates where name = 'CertEnc_Cert')
	DROP CERTIFICATE CertEnc_Cert
GO

IF EXISTS (SELECT * FROM sys.symmetric_keys WHERE symmetric_key_id = 101)  
    DROP MASTER KEY
GO  

-- �ؖ������쐬���Ă��邽�߁A�f�[�^�x�[�X�Ƀ}�X�^�[�L�[�̍쐬���K�v
CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = '23987hxJKL95QYV4369#ghf0%lekjg5k3fd117r$$#1946kcj$n44ncjhdlj'  

CREATE CERTIFICATE CertEnc_Cert  
   WITH SUBJECT = 'Certificate Encryption Certificate'  
GO  

CREATE TABLE T1(
	id int IDENTITY(1, 1),
	ClearText nvarchar(100),
	EncryptData varbinary(max)
) 
GO

--�Í����֐��Ńf�[�^���Í������� INSERT
INSERT INTO T1 VALUES ( '�����̃f�[�^', EncryptByCert(Cert_ID('CertEnc_Cert'), N'�Í����f�[�^') )
GO

-- �Í�������Ă��邱�Ƃ̊m�F
SELECT * FROM T1


-- �������֐��ňÍ������������ăf�[�^���擾
SELECT 
	ID, 
	ClearText,
	CONVERT( nvarchar,  DecryptByCert(Cert_ID('CertEnc_Cert'),EncryptData))
FROM T1
GO

-- �ȉ��͑����Ƀ��X�g�A����ꍇ�̍l��

/********************************************/
-- ���̊��Ŏ��{
-- �Í����Ŏg�p���Ă���ؖ������A���X�g�A��ŃC���|�[�g�ł���悤�Ƀo�b�N�A�b�v���擾
BACKUP CERTIFICATE SymKey_Cert
TO FILE= 'C:\temp\SymKey_Cert.cer'
WITH PRIVATE KEY
(
    FILE = 'C:\temp\SymKey_Cert_PrivateKey.pvk',
    ENCRYPTION BY PASSWORD = '$trongP@$$@gain'
)


-- �T�[�r�X�}�X�^�[�L�[�̃o�b�N�A�b�v 
SELECT * FROM master.sys.symmetric_keys
-- https://social.technet.microsoft.com/wiki/contents/articles/25483.cell-level-encryption-with-always-on-availability-groups.aspx
BACKUP SERVICE MASTER KEY
TO FILE = 'C:\temp\SMK.cer'
ENCRYPTION BY  PASSWORD = '$trongP@$$@gain'
GO

-- CLE �����s���Ă���f�[�^�x�[�X�Ŏ��s
USE TEST
GO
BACKUP MASTER KEY TO FILE='C:\temp\DMK.cer'
ENCRYPTION BY Password = '$trongP@$$@gain'
GO
/********************************************/


/********************************************/
-- ���X�g�A��ňÍ����Ɏg�p�����ؖ��������X�g�A

-- �}�X�^�[�L�[���㏑�����X�g�A���邱�ƂŁA���X�g�A��̃T�[�r�X�}�X�^�[�L�[�ŕی삵�ăA�N�Z�X�ł���悤�ɂ��Ă���
USE [TEST]
GO
RESTORE MASTER KEY   
    FROM FILE = 'C:\temp\DMK.cer'   
    DECRYPTION BY PASSWORD = '$trongP@$$@gain' 
    ENCRYPTION BY PASSWORD = '259087M#MyjkFkjhywiyedfgGDFD'
	FORCE 
GO  

-- �o�b�N�A�b�v���̃T�[�r�X�}�X�^�[�L�[�����X�g�A���邱�ƂŁA�f�[�^�x�[�X�}�X�^�[�L�[��ǂݎ�邱�Ƃ��\
-- (�����̊�����Í��������f�[�^�x�[�X�����X�g�A���Ă���ꍇ�A�T�[�r�X�}�X�^�[�L�[�����X�g�A����ƁA���� DB �̈Í����������ł��Ȃ��Ȃ�)
-- ALTER SERVICE MASTER KEY REGENERATE�@-- �e�X�g�p�ɃT�[�r�X�}�X�^�[�L�[���Đ������A�}�X�^�[�L�[��ς������ꍇ
RESTORE SERVICE MASTER KEY
FROM FILE = 'C:\temp\SMK.cer'
DECRYPTION BY PASSWORD = '$trongP@$$@gain'
FORCE
GO
