--===========================================================================================
-- BUSCANDO TABELAS HEAP
--===========================================================================================

SELECT OBJECT_NAME(IDX.object_id)  Table_Name
      , IDX.name  Index_name
	  , PAR.rows  NumOfRows
	  , IDX.type_desc  TypeOfIndex
FROM sys.partitions PAR
INNER JOIN sys.indexes IDX ON PAR.object_id = IDX.object_id  AND PAR.index_id = IDX.index_id AND IDX.type = 0
INNER JOIN sys.tables TBL
ON TBL.object_id = IDX.object_id and TBL.type ='U'

--@ FOCAR NAS TABELAS COM GRANDE QUANTDADE DE DADOS (CRIAR UM �NDICE CLUSTERIZADO)

--===========================================================================================
-- DESFRAGMENTAR �NDICE
--===========================================================================================
DBCC INDEXDEFRAG (IndexDemoDB, 'STD_Evaluation', IX_STD_EVALUATION_COURSE_ID);

--===========================================================================================
-- REBUILD �NDEX (RECRIAR)	@ FRAGMENTA��O ACIMA DE 30% @
--===========================================================================================
ALTER INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation REBUILD PARTITION = ALL WITH (
	 PAD_INDEX = OFF
	,STATISTICS_NORECOMPUTE = OFF
	,SORT_IN_TEMPDB = OFF
	,ONLINE = OFF
	,ALLOW_ROW_LOCKS = ON
	,ALLOW_PAGE_LOCKS = ON)

--===========================================================================================
-- REORGANINZAR �NDEX	@ FRAGMENTA��O ENTRE 5% E 30% @
--===========================================================================================
GO

ALTER INDEX IX_COURSES_NAME ON Courses REORGANIZE WITH( LOB_COMPACTION = ON )


--===========================================================================================
-- REBUILD �NDEX (RECRIAR)	@ FRAGMENTA��O ACIMA DE 30% @ (TODOS OS �NDICES DA TABELA)
--===========================================================================================
ALTER INDEX ALL ON STD_Evaluation REBUILD PARTITION = ALL WITH (
	 PAD_INDEX = OFF
	,STATISTICS_NORECOMPUTE = OFF
	,SORT_IN_TEMPDB = OFF
	,ONLINE = OFF
	,ALLOW_ROW_LOCKS = ON
	,ALLOW_PAGE_LOCKS = ON)


--===========================================================================================
-- REORGANINZAR �NDEX	@ FRAGMENTA��O ENTRE 5% E 30% @ (TODOS OS �NDICES DA TABELA)
--===========================================================================================
ALTER INDEX ALL ON STD_Evaluation REORGANIZE

