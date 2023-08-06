USE [DemoDB]
GO

SELECT 
	r.reason, 
	score,
    JSON_VALUE(details, '$.implementationDetails.script') script,
    planState.*,
	planForceDetails.*
FROM 
	sys.dm_db_tuning_recommendations r
CROSS APPLY OPENJSON (Details, '$.planForceDetails')
WITH (
	[query_id] int '$.queryId',
	[new plan_id] int '$.regressedPlanId',
	[recommended plan_id] int '$.forcedPlanId'
	) as planForceDetails
CROSS APPLY OPENJSON (state)
WITH
	(
	[currentValue] nvarchar(100) '$.currentValue',
	[reason] nvarchar(100) '$.reason'
    ) as planState
GO

-- �N�G���X�g�A�̏��̎擾
SELECT * FROM sys.query_store_plan
WHERE plan_forcing_type <> 0
