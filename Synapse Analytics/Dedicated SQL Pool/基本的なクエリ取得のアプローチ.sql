/*
https://docs.microsoft.com/ja-jp/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-manage-monitor
https://docs.microsoft.com/ja-jp/azure/synapse-analytics/sql-data-warehouse/cheat-sheet
https://docs.microsoft.com/ja-jp/azure/synapse-analytics/sql-data-warehouse/memory-concurrency-limits



https://sqlbitscontent.blob.core.windows.net/sessioncontent/5777/0384e476-bac7-4927-90d7-f15f165761e6.pdf
https://www.sqlsaturday.com/SessionDownload.aspx?suid=27543 
*/



-- ���s����N�G���Ƀ��x����t�^���ăg���[�T�r���e�B���グ��
/* TPC_H Query 7 - Volume Shipping */
SELECT 
    SUPP_NATION,
    CUST_NATION,
    L_YEAR,
    SUM(VOLUME) AS REVENUE
FROM
(
    SELECT 
        N1.N_NAME AS SUPP_NATION,
        N2.N_NAME AS CUST_NATION,
        DATEPART(yy,L_SHIPDATE) AS L_YEAR,
        L_EXTENDEDPRICE * (1 - L_DISCOUNT) AS VOLUME
    FROM 
         SUPPLIER
         LEFT JOIN LINEITEM ON S_SUPPKEY = L_SUPPKEY
         LEFT JOIN ORDERS ON O_ORDERKEY = L_ORDERKEY
         LEFT JOIN CUSTOMER ON C_CUSTKEY = O_CUSTKEY
         LEFT JOIN NATION AS N1 ON S_NATIONKEY = N1.N_NATIONKEY
         LEFT JOIN NATION AS N2 ON C_NATIONKEY = N2.N_NATIONKEY
    WHERE((N1.N_NAME = 'FRANCE'
           AND N2.N_NAME = 'GERMANY')
          OR (N1.N_NAME = 'GERMANY'
              AND N2.N_NAME = 'FRANCE'))
         AND L_SHIPDATE BETWEEN '1995-01-01' AND '1996-12-31'
) AS SHIPPING
GROUP BY 
    SUPP_NATION,
    CUST_NATION,
    L_YEAR
ORDER BY 
    SUPP_NATION,
    CUST_NATION,
    L_YEAR
    OPTION (LABEL = 'TPC H Query 7')


-- �Y���̃��x�������N�G���� Request ID ���擾
SELECT  *FROM sys.dm_pdw_exec_requests WHERE [label] IN( 'Normal', 'High' ) and status in('Running', 'Suspended') ORDER BY submit_time DESC

-- �擾���� Request Id ��ݒ�
DECLARE @request_id nvarchar(32)	= 'QID5407'

-- �N�G���v���� (�|�[�^���Ŋm�F�ł�����) ���擾
-- ����ɂ��S�̓I�ȃN�G���v�����̑I�����m�F�ł���
SELECT * FROM sys.dm_pdw_request_steps WHERE request_id = @request_id order by step_index ASC

--  �e�X�e�b�v�̏ڍׂȃN�G���̏������
SELECT * FROM sys.dm_pdw_sql_requests WHERE request_id = @request_id ORDER BY step_index ASC

-- DMS ���g�p����Ă���ꍇ (�f�[�^�̈ړ�) �̓����
SELECT * FROM sys.dm_pdw_dms_workers WHERE request_id = @request_id order by step_index ASC, pdw_node_id ASC, distribution_id

-- �O���t�@�C���̃��[�h�����s���Ă���ꍇ�� DMS �̊����󋵂̎擾
SELECT * FROM sys.dm_pdw_dms_external_work WHERE request_id = @request_id 

-- ���s���̃N�G���̓���̃f�B�X�g���r���[�^�[�Ŏ��s����Ă��� SQL �̏ڍ׏��̎擾 (������ Distribution ID , Session ID)
DBCC PDW_SHOWEXECUTIONPLAN ( 1, 126 )
-- ������ł�����
select pdw_node_id, session_id,REPLACE(query_plan,'''','''''') from sys.dm_pdw_nodes_exec_query_statistics_xml order by session_id ASC
