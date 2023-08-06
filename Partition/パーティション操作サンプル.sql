/*******************************************************************/
-- ������

DROP TABLE IF EXISTS TEST
DROP TABLE IF EXISTS TEST_Archive
GO

IF EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = 'TEST_PS')
	DROP PARTITION SCHEME TEST_PS
IF EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = 'TEST_PF')
	DROP PARTITION FUNCTION TEST_PF
IF EXISTS (SELECT 1 FROM sys.partition_schemes WHERE name = 'TEST_Archive_PS')
	DROP PARTITION SCHEME TEST_Archive_PS
IF EXISTS (SELECT 1 FROM sys.partition_functions WHERE name = 'TEST_Archive_PF')
	DROP PARTITION FUNCTION TEST_Archive_PF
GO
 
CREATE PARTITION FUNCTION TEST_PF(date) AS RANGE RIGHT FOR VALUES('2016/1/1', '2017/1/1','2018/1/1','2019/1/1','2020/1/1') 
GO
CREATE PARTITION SCHEME TEST_PS AS PARTITION TEST_PF ALL TO ([PRIMARY])
GO
CREATE PARTITION FUNCTION TEST_Archive_PF(date) AS RANGE RIGHT FOR VALUES('2016/1/1', '2017/1/1','2018/1/1','2019/1/1','2020/1/1') 
GO
CREATE PARTITION SCHEME TEST_Archive_PS AS PARTITION TEST_Archive_PF ALL TO ([PRIMARY])
GO
/*******************************************************************/


/*******************************************************************/
-- �p�[�e�B�V���j���O����Ă��Ȃ��q�[�v�e�[�u���̍쐬

CREATE TABLE TEST(
	C1 int  NOT NULL,
	C2 date NOT NULL, 
	C3 uniqueidentifier,
	C4 AS CASE WHEN C2 >= '2012/1/1' THEN 1 ELSE 2 END, -- ����I�łȂ��v�Z�� (����I�łȂ����� PERSISTED �͎w��ł��Ȃ�)
	C5 AS Month(C2), -- �i��������Ă��Ȃ��v�Z�� (����I�ł���΃C���f�b�N�X��Ƃ��Ă͎g���邪�p�[�e�B�V����������Ƃ��Ă͎g���Ȃ�)
	C6 AS Month(C2) PERSISTED -- �i��������Ă���v�Z�� (�i��������Ă���΃p�[�e�B�V����������Ƃ��Ďg����)
)
GO
-- �v�Z�񂪌���I���ǂ����̊m�F (�v�Z����g��������ƌ����āA�K���񌈒�I�ƂȂ�킯�ł͂Ȃ�)
SELECT COLUMNPROPERTY(OBJECT_ID('TEST'), N'C4', 'IsDeterministic')
SELECT COLUMNPROPERTY(OBJECT_ID('TEST'), N'C5', 'IsDeterministic')
SELECT COLUMNPROPERTY(OBJECT_ID('TEST'), N'C6', 'IsDeterministic')
/*******************************************************************/


/*******************************************************************/
-- �q�[�v�e�[�u���̃p�[�e�B�V���j���O

CREATE TABLE TEST(
	C1 int  NOT NULL,
	C2 date NOT NULL, 
	C3 uniqueidentifier,
	C4 AS CASE WHEN C2 >= '2012/1/1' THEN 1 ELSE 2 END, -- ����I�łȂ��v�Z�� (����I�łȂ����� PERSISTED �͎w��ł��Ȃ�)
	C5 AS Month(C2), -- �i��������Ă��Ȃ��v�Z�� (����I�ł���΃C���f�b�N�X��Ƃ��Ă͎g���邪�p�[�e�B�V����������Ƃ��Ă͎g���Ȃ�)
	C6 AS Month(C2) PERSISTED -- �i��������Ă���v�Z�� (�i��������Ă���΃p�[�e�B�V����������Ƃ��Ďg����)
)ON TEST_PS(C2)
GO
/*******************************************************************/

/*******************************************************************/
-- �N���X�^�[���C���f�b�N�X�̃p�[�e�B�V���j���O
CREATE TABLE TEST(
	C1 int NOT NULL,
	C2 date NOT NULL, 
	C3 uniqueidentifier,
	C4 AS CASE WHEN C2 >= '2012/1/1' THEN 1 ELSE 2 END, -- ����I�łȂ��v�Z�� (����I�łȂ����� PERSISTED �͎w��ł��Ȃ�)
	C5 AS Month(C2), -- �i��������Ă��Ȃ��v�Z�� (����I�ł���΃C���f�b�N�X��Ƃ��Ă͎g���邪�p�[�e�B�V����������Ƃ��Ă͎g���Ȃ�)
	C6 AS Month(C2) PERSISTED -- �i��������Ă���v�Z�� (�i��������Ă���΃p�[�e�B�V����������Ƃ��Ďg����)
)
GO
CREATE CLUSTERED INDEX CIX_TEST ON TEST (C2) ON TEST_PS(C2)
/******************************************************************/


/******************************************************************/
-- ���b�N�G�X�J���[�V�����̃��[�h�̕ύX

ALTER TABLE TEST SET ( LOCK_ESCALATION = AUTO )
/******************************************************************/


/******************************************************************/
-- �x�[�X�e�[�u���ɌŒ肵�Ȃ��C���f�b�N�X�̍쐬

-- �x�[�X�e�[�u���ɌŒ肳��Ă��Ȃ��C���f�b�N�X�����݂��Ă���ꍇ�A
-- �p�[�e�B�V�����̃X�C�b�` / Truncate �͂ł��Ȃ�
ALTER TABLE TEST ADD CONSTRAINT PK_TEST PRIMARY KEY NONCLUSTERED (C1) ON [PRIMARY]
GO
/******************************************************************/

/******************************************************************/
-- �x�[�X�e�[�u���ɌŒ肵���C���f�b�N�X

-- �e�[�u���Ɠ���̃p�[�e�B�V�����\���ō쐬�����
CREATE INDEX NCIX_TEST_C3 ON TEST(C3) 

-- �v�Z����g�p���ăp�[�e�B�V���j���O�����{����ꍇ�A����I�Ȏ��łȂ�����p�[�e�B�V������Ƃ��Ďw��ł��Ȃ�
-- https://technet.microsoft.com/ja-jp/library/ms191250(v=sql.105).aspx
DROP INDEX IF EXISTS NCIX_TEST_CALC ON TEST
CREATE INDEX NCIX_TEST_CALC ON TEST(C4) 

-- ����I�ȗ�ɂ��Ă̓C���f�b�N�X���쐬�ł��� (PERSISITED �łȂ��Ă�����I�ł���΍쐬�ł���A�������p�[�e�B�V������Ƃ��Ă͎g�p�ł��Ȃ�)
DROP INDEX IF EXISTS NCIX_TEST_CALC ON TEST
CREATE INDEX NCIX_TEST_CALC ON TEST(C5) 

-- �p�[�e�B�V�����L�[���ȗ����č쐬���Ă��邪�A�����I�ɂ̓p�[�e�B�V�����L�[�������I�Ɋ܂܂�Ă��� (�f�[�^�}����Ɋm�F)
SELECT OBJECT_NAME(pa.object_id) AS object_name, i.name, i.type_desc ,pa.allocation_unit_type_desc,pa.is_iam_page, partition_id, allocated_page_file_id,allocated_page_page_id
FROM sys.dm_db_database_page_allocations(DB_ID(), OBJECT_ID('TEST'), NULL, NULL, 'LIMITED') pa
LEFT JOIN sys.indexes AS i ON i.object_id = pa.object_id AND i.index_id = pa.index_id
WHERE pa.is_iam_page = 0
ORDER BY pa.index_id, pa.partition_id


DBCC TRACEON(3604)
DBCC PAGE(N'PartitionTest', 1, 1931, 3)
/******************************************************************/


/****************************************************/
-- ��Ӑ���̍쐬 (�N���X�^�[���C���f�b�N�X)

-- �p�[�e�B�V�����e�[�u���ɑ΂��Ă̈�Ӑ���̍쐬�̂��߁A�p�[�e�B�V�����L�[���C���f�b�N�X�L�[�Ɋ܂߂�K�v������
-- �p�[�e�B�V��������܂�ł��Ȃ����߁A�G���[�ƂȂ�
ALTER TABLE TEST ADD CONSTRAINT PK_TEST PRIMARY KEY CLUSTERED (C1) ON TEST_PS(C2)

-- �p�[�e�B�V�����L�[��ݒ肵�Ă���ꍇ�͐���I��
ALTER TABLE TEST ADD CONSTRAINT PK_TEST PRIMARY KEY CLUSTERED (C1, C2) ON TEST_PS(C2)
GO
/****************************************************/

/****************************************************/
-- ��Ӑ���̍쐬 (��N���X�^�[���C���f�b�N�X)

-- �p�[�e�B�V�����e�[�u���ɑ΂��Ă̈�Ӑ���̍쐬�̂��߁A�p�[�e�B�V�����L�[���C���f�b�N�X�L�[�Ɋ܂߂�K�v������
-- �p�[�e�B�V��������܂�ł��Ȃ����߁A�G���[�ƂȂ�
ALTER TABLE TEST ADD CONSTRAINT PK_TEST PRIMARY KEY NONCLUSTERED (C1)
GO

-- ���j�[�N�L�[�����l�ɃG���[�ƂȂ�
ALTER TABLE TEST ADD CONSTRAINT UK_TEST UNIQUE(C1)

-- �p�[�e�B�V�����L�[��ݒ肵�Ă���ꍇ�͐���I��
ALTER TABLE TEST ADD CONSTRAINT PK_TEST PRIMARY KEY NONCLUSTERED (C1, C2)
GO
/****************************************************/

/******************************************************************/
-- �e�X�g�f�[�^�̑}��

SET NOCOUNT ON
GO
DECLARE @cnt int = 1
DECLARE @start date = '2015/1/1'
BEGIN TRAN
WHILE (@cnt <= 50000)
BEGIN
	INSERT INTO TEST(C1, C2, C3) VALUES(@cnt, DATEADD(d, @cnt, @start), NEWID())
	SET @cnt += 1
END
COMMIT TRAN
GO
/******************************************************************/

/******************************************************************/
-- �p�[�e�B�V������ Truncate

TRUNCATE TABLE TEST WITH (PARTITIONS(1))
TRUNCATE TABLE TEST WITH (PARTITIONS(1,4))
TRUNCATE TABLE TEST WITH (PARTITIONS(1 TO 3))
GO
/******************************************************************/


/******************************************************************/
-- �A�[�J�C�u�e�[�u���̍쐬

-- ����̃p�[�e�B�V�����\�����g�p���Ă��܂��ƁA�}�[�W�����ۂɃA�[�J�C�u�e�[�u���ɂ��e����^���邽�߁A
-- �X�C�b�`���ƈقȂ�p�[�e�B�V�����\�����g�p
CREATE TABLE TEST_Archive(
	C1 int NOT NULL,
	C2 date NOT NULL, 
	C3 uniqueidentifier,
	C4 AS CASE WHEN C2 >= '2012/1/1' THEN 1 ELSE 2 END,
	C5 AS Month(C2)
)
CREATE CLUSTERED INDEX CIX_TEST_Archive ON TEST_Archive (C2) ON TEST_Archive_PS(C2)

-- �p�[�e�B�V�����ɌŒ艻���ꂽ�C���f�b�N�X������ꍇ�́A�A�[�J�C�u��ł��ݒ肵�C���f�b�N�X���܂߂ăX�C�b�`����
CREATE INDEX NCIX_TEST_Archive_C3 ON TEST_Archive(C3) 
/******************************************************************/


/******************************************************************/
-- �p�[�e�B�V�����̃X�C�b�`

-- �x�[�X�e�[�u���ŃX�C�b�`�����p�[�e�B�V�����̃f�[�^���ǉ�����Ȃ��悤�ɐ����ǉ�
BEGIN TRAN
ALTER TABLE TEST SWITCH PARTITION 1 TO TEST_Archive PARTITION 1
ALTER TABLE TEST ADD CONSTRAINT CHK_PARTITION CHECK(C2 >= '2016/1/1')
--ALTER TABLE TEST ADD CONSTRAINT CHK_PARTITION CHECK(C1 >= 1)
ALTER PARTITION FUNCTION TEST_PF() MERGE RANGE('2016-01-01')
COMMIT TRAN

-- �p�[�e�B�V�����̃X�C�b�` (��Ӑ���𖳌�)
BEGIN TRAN
ALTER INDEX PK_TEST ON TEST DISABLE
ALTER TABLE TEST SWITCH PARTITION 1 TO TEST_Archive PARTITION 1
ALTER TABLE TEST ADD CONSTRAINT CHK_PARTITION CHECK(C2 >= '2016/1/1')
ALTER PARTITION FUNCTION TEST_PF() MERGE RANGE('2016-01-01')
ALTER INDEX PK_TEST ON TEST REBUILD WITH (ONLINE = ON)
COMMIT TRAN
/******************************************************************/


/******************************************************************/
-- �x�[�X�e�[�u���ɐ��񂪐ݒ肵�Ă����Ԃ̊m�F

-- �A�[�J�C�u�����f�[�^��߂����Ƃ���ƃG���[
ALTER TABLE TEST_Archive SWITCH PARTITION 1 TO TEST PARTITION 1 
-- �G���[
-- �A�[�J�C�u�e�[�u���Ɋi�[����Ă���f�[�^�� 2016/1/1 �ȑO�̃f�[�^���܂܂�Ă��Ȃ��Ƃ����ۏ؂��Ȃ�����
-- �p�[�e�B�V�����̐؂�ւ���ɐ��񂪐ݒ肳��Ă���ꍇ�́A���̐���Ɉᔽ���Ȃ��f�[�^�ɂȂ��Ă���Ƃ����ۏ؂��x�[�X�e�[�u���ɂ��K�v
-- �p�[�e�B�V���������� NULL ���e�̏ꍇ�ANULL �o�Ȃ��Ƃ���������K�v�ƂȂ�
/******************************************************************/

