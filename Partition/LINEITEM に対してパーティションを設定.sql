/*****************************************************************/
-- �p�[�e�B�V�����̂��߂̒�`
/*****************************************************************/
-- �p�[�e�B�V�����֐��̍쐬
CREATE PARTITION FUNCTION LINEITEM_PF (date)
AS RANGE RIGHT FOR VALUES ('1993/1/1','1994/1/1','1995/1/1','1996/1/1','1997/1/1','1998/1/1')
GO

-- �p�[�e�B�V�����X�L�[�}�̍쐬
CREATE PARTITION SCHEME LINEITEM_PS
AS PARTITION LINEITEM_PF
ALL TO ([PRIMARY])
GO


/*****************************************************************/
-- �s�x�[�X�̃f�[�^�̃p�[�e�B�V���j���O
/*****************************************************************/

-- �q�[�v�̃e�[�u�����p�[�e�B�V������
CREATE CLUSTERED INDEX [ClusteredIndex_on_LINEITEM_PS_636163560028609030] ON [dbo].[LINEITEM]
(
	[L_SHIPDATE]
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [LINEITEM_PS]([L_SHIPDATE])


-- �f�[�^���p�[�e�B�V���������ꂽ���߁A�ꎞ�I�ɕt�^����CIX ���폜
DROP INDEX [ClusteredIndex_on_LINEITEM_PS_636163560028609030] ON [dbo].[LINEITEM]


-- �p�[�e�B�V����������
ALTER TABLE LINEITEM
ADD CONSTRAINT PK_LINEITEM PRIMARY KEY (L_ORDERKEY,L_LINENUMBER) 
ON [PRIMARY]
GO


-- �p�[�e�B�V������
ALTER TABLE LINEITEM
ADD CONSTRAINT PK_LINEITEM PRIMARY KEY CLUSTERED (L_ORDERKEY,L_LINENUMBER, L_SHIPDATE) 
WITH (STATISTICS_INCREMENTAL = OFF)
ON [LINEITEM_PS]([L_SHIPDATE])
GO

-- �������v�̐ݒ�
ALTER INDEX PK_LINEITEM ON LINEITEM REBUILD WITH(STATISTICS_INCREMENTAL = ON)

/*****************************************************************/
-- ��X�g�A�C���f�b�N�X�̃p�[�e�B�V���j���O
/*****************************************************************/
-- �N���X�^�[����X�g�A�C���f�b�N�X�̓x�[�X�e�[�u���ɌŒ艻����K�v������

-- ��x�x�[�X�e�[�u���ɃN���X�^�[���C���f�b�N�X���쐬
CREATE CLUSTERED INDEX [CCIX_LINEITEM] ON [dbo].[LINEITEM]
([L_ORDERKEY] ASC,[L_LINENUMBER] ASC)
ON LINEITEM_PS(L_SHIPDATE)
GO

-- ���̌�A�N���X�^�[����X�g�A�C���f�b�N�X�� DROP EXISTING �ō쐬
CREATE CLUSTERED COLUMNSTORE INDEX [CCIX_LINEITEM] ON [dbo].[LINEITEM]
WITH (DROP_EXISTING = ON)
ON LINEITEM_PS(L_SHIPDATE)
GO

-- ��N���X�^�[����X�g�A�C���f�b�N�X�̍쐬
CREATE NONCLUSTERED COLUMNSTORE INDEX [NCCIX_LINEITEM] ON [dbo].[LINEITEM]
(
	[L_ORDERKEY],
	[L_PARTKEY],
	[L_SUPPKEY],
	[L_LINENUMBER],
	[L_QUANTITY],
	[L_EXTENDEDPRICE],
	[L_DISCOUNT],
	[L_TAX],
	[L_RETURNFLAG],
	[L_LINESTATUS],
	[L_SHIPDATE],
	[L_COMMITDATE],
	[L_RECEIPTDATE],
	[L_SHIPINSTRUCT],
	[L_SHIPMODE],
	[L_COMMENT]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) 
ON LINEITEM_PS(L_SHIPDATE)
GO

-- �s�X�g�A�Ŋi�[����Ă���f�[�^������s���ɒB���Ȃ��Ă����k
ALTER INDEX [NCCIX_LINEITEM] ON [dbo].[LINEITEM] REORGANIZE PARTITION = 1 WITH (COMPRESS_ALL_ROW_GROUPS =ON)
GO

-- �p�[�e�B�V�����̍č\��
ALTER INDEX [NCCIX_LINEITEM] ON [dbo].[LINEITEM] REORGANIZE PARTITION = 1
GO

-- �p�[�e�B�V�����̍č\�z
ALTER INDEX [NCCIX_LINEITEM] ON [dbo].[LINEITEM] REBUILD PARTITION = 1
GO

ALTER INDEX [NCCIX_LINEITEM] ON [dbo].[LINEITEM] REBUILD PARTITION = 1 WITH (DATA_COMPRESSION = COLUMNSTORE_ARCHIVE)
GO

-- �p�[�e�B�V�����P�ʂ̌������擾
SELECT $PARTITION.LINEITEM_PF(L_SHIPDATE), COUNT(*) 
FROM LINEITEM GROUP BY $PARTITION.LINEITEM_PF(L_SHIPDATE)