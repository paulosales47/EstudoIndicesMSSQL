--============================================================================================
-- VERIFICANDO ÍNDICES EXISTENTES EM UMA TABELA (sp_helpindex)
--============================================================================================
USE IndexDemoDB
GO

EXEC sp_helpindex '[dbo].[STD_Evaluation]'
GO
EXEC sp_helpindex '[dbo].[Courses]'
GO
EXEC sp_helpindex '[dbo].[STD_Info]'

--============================================================================================
-- VERIFICANDO ÍNDICES EXISTENTES EM UMA TABELA (consulta)
--============================================================================================

SELECT  Tab.name  Table_Name 
			 ,IX.name  Index_Name
			 ,IX.type_desc Index_Type
			 ,Col.name  Index_Column_Name
			 ,IXC.is_included_column Is_Included_Column
			 ,IX.fill_factor 
			 ,IX.is_disabled
			 ,IX.is_primary_key
			 ,IX.is_unique
			 		  
           FROM  sys.indexes IX 
           INNER JOIN sys.index_columns IXC  ON  IX.object_id   =   IXC.object_id AND  IX.index_id  =  IXC.index_id  
           INNER JOIN sys.columns Col   ON  IX.object_id   =   Col.object_id  AND IXC.column_id  =   Col.column_id     
           INNER JOIN sys.tables Tab      ON  IX.object_id = Tab.object_id

--============================================================================================
-- PAD_INDEX E FILLFACOTOR (ÍNDICE DE TESTE)
--============================================================================================
GO

CREATE NONCLUSTERED INDEX IX_COURSES_NAME ON Courses(Course_Name)
WITH(ONLINE = ON, FILLFACTOR = 90, PAD_INDEX = ON, SORT_IN_TEMPDB = ON)


--============================================================================================
-- FRAGMENTAÇÃO DO ÍNDICE
--============================================================================================

SELECT  OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name, 
IDX.name AS Index_Name, 
IDXPS.index_type_desc AS Index_Type, 
IDXPS.avg_fragmentation_in_percent  Fragmentation_Percentage
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) IDXPS 
INNER JOIN sys.indexes IDX  ON IDX.object_id = IDXPS.object_id 
AND IDX.index_id = IDXPS.index_id 
ORDER BY Fragmentation_Percentage DESC

/*
TABELA				| FRAGMENTAÇÃO		| INDICE
----------------------------------------------------------------------
STD_Evaluation		| 28,5714285714286	| NULL (HEAP)
STD_Evaluation		| 8,11808118081181	| IX_STD_EVALUATION_COURSE_ID
Courses				| 7,14285714285714	| IX_COURSES_NAME
STD_Evaluation		| 6,6079295154185	| IX_STD_EVALUATION_STD_ID
Courses				| 3,02114803625378	| PK__Courses__37E005FBE5538576
STD_Info			| 1,64744645799012	| PK__STD_Info__40AB99974CBBE020

*/

/*
INSERIR 1000 REGISTROS EM CADA TABELA
*/

/*
TABELA				| FRAGMENTAÇÃO		| INDICE
----------------------------------------------------------------------
STD_Evaluation		| 28,5714285714286	| NULL (HEAP)
STD_Evaluation		| 8,11808118081181	| IX_STD_EVALUATION_COURSE_ID
Courses				| 7,14285714285714	| IX_COURSES_NAME
STD_Evaluation		| 15,7676348547718	| IX_STD_EVALUATION_STD_ID
Courses				| 3,28358208955224	| PK__Courses__37E005FBE5538576
STD_Info			| 1,79445350734095	| PK__STD_Info__40AB99974CBBE020

*/

/*
INSERIR 100.000 REGISTROS EM CADA TABELA
*/

/*
TABELA				| FRAGMENTAÇÃO		| INDICE
----------------------------------------------------------------------
STD_Evaluation		| 29,6703296703297	| NULL (HEAP)
STD_Evaluation		| 98,6342943854325	| IX_STD_EVALUATION_COURSE_ID
Courses				| 81,304347826087	| IX_COURSES_NAME
STD_Evaluation		| 81,6691505216095	| IX_STD_EVALUATION_STD_ID
Courses				| 3,15789473684211	| PK__Courses__37E005FBE5538576
STD_Info			| 1,72272354388843	| PK__STD_Info__40AB99974CBBE020

*/

--============================================================================================
-- ESTATISTICAS DE USO DO ÍNDICE
--===========================================================================================
SELECT OBJECT_NAME(IX.OBJECT_ID) Table_Name
	   ,IX.name AS Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
	   ,IXUS.user_seeks AS NumOfSeeks
	   ,IXUS.user_scans AS NumOfScans
	   ,IXUS.user_lookups AS NumOfLookups
	   ,IXUS.user_updates AS NumOfUpdates
	   ,IXUS.last_user_seek AS LastSeek
	   ,IXUS.last_user_scan AS LastScan
	   ,IXUS.last_user_lookup AS LastLookup
	   ,IXUS.last_user_update AS LastUpdate
FROM sys.indexes IX
INNER JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id AND IXUS.OBJECT_ID = IX.OBJECT_ID
INNER JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE OBJECTPROPERTY(IX.OBJECT_ID,'IsUserTable') = 1
GROUP BY OBJECT_NAME(IX.OBJECT_ID) ,IX.name ,IX.type_desc ,IXUS.user_seeks ,IXUS.user_scans ,IXUS.user_lookups,IXUS.user_updates ,IXUS.last_user_seek ,IXUS.last_user_scan ,IXUS.last_user_lookup ,IXUS.last_user_update

-- SEEKS - INDICA O NUMERO DE VEZES QUE O ÍNDICE É UTILIZADO PARA PROCURAR UMA LINHA ESPECIFICA
-- SCANS - INDICA O NUMERO DE VEZES QUE AS PÁGINAS FOLHA DO ÍNDICE SÃO VARRIDAS
-- LOOKUPS - INDICA O NUMERO DE VEZES QUE O ÍNDICE CLUSTERIZADO É UTILIZADO PELO ÍNDICE NÃO-CLUSTERIZADO PARA BUSCAR A LINHA COMPLETA
-- UPDATES - EXIBE O NUMERO DE VEZES QUE OS DADOS DO ÍNDICE FORAM MODIFICADOS MODIFICADOS


-- OBSERVAÇÕES:

--@ Todos os valores zero significam que a tabela não é usada ou o serviço do SQL Server foi reiniciado recentemente.

--@ Um índice com zero ou pequeno número de buscas, varreduras ou pesquisas e um grande número de atualizações é um índice inútil e deve ser removido , após verificar com o proprietário do sistema, pois o objetivo principal de adicionar o índice é acelerar as operações de leitura.

--@ Um índice que é escaneado(NumOfScans) pesadamente com zero ou pequeno número de buscas(NumOfSeeks) significa que o índice é mal utilizado e deve ser substituído por outro mais adequado.

--@ Um índice com grande número de pesquisas(NumOfLookups) significa que precisamos otimizar o índice adicionando as colunas pesquisadas com freqüência às colunas não principais de índice existentes usando a cláusula INCLUDE

--@ Uma tabela com um número muito grande de Varreduras(NumOfScans) indica que as consultas SELECT * são muito usadas, recuperando mais colunas do que o necessário ou as estatísticas de índice devem ser atualizadas.

--@ Um índice clusterizado com grande número de varreduras(NumOfScans) significa que um novo índice não clusterizado deve ser criado para cobrir uma consulta não coberta.

--@ Datas com valores NULL significam que esta ação ainda não ocorreu

--@ Varreduras grandes são aceitáveis ​​em tabelas pequenas.

--@ Seu índice não está aqui, então nenhuma ação é executada nesse índice ainda.


--============================================================================================
-- ESTATISTICAS DOS ÍNDICES (ATIVIDADE E/S)
--===========================================================================================
SELECT OBJECT_NAME(IXOS.OBJECT_ID)  Table_Name 
       ,IX.name  Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
       ,IXOS.LEAF_INSERT_COUNT NumOfInserts
       ,IXOS.LEAF_UPDATE_COUNT NumOfupdates
       ,IXOS.LEAF_DELETE_COUNT NumOfDeletes
	   
FROM   SYS.DM_DB_INDEX_OPERATIONAL_STATS (NULL,NULL,NULL,NULL ) IXOS 
INNER JOIN SYS.INDEXES AS IX ON IX.OBJECT_ID = IXOS.OBJECT_ID AND IX.INDEX_ID =    IXOS.INDEX_ID 
	INNER JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE  OBJECTPROPERTY(IX.[OBJECT_ID],'IsUserTable') = 1
GROUP BY OBJECT_NAME(IXOS.OBJECT_ID), IX.name, IX.type_desc,IXOS.LEAF_INSERT_COUNT, IXOS.LEAF_UPDATE_COUNT,IXOS.LEAF_DELETE_COUNT

--============================================================================================
-- ATUALIZAR ESTATÍSTICAS EM UMA TABELA
--===========================================================================================
USE IndexDemoDB
GO

UPDATE STATISTICS STD_Evaluation

--============================================================================================
-- ATUALIZAR ESTATÍSTICAS NO BANCO
--===========================================================================================
USE IndexDemoDB
GO

EXEC sp_updatestats

--============================================================================================
-- ATUALIZAR ESTATÍSTICAS UTILIZANDO AMOSTRA
--===========================================================================================
UPDATE STATISTICS STD_Evaluation WITH SAMPLE 50 PERCENT

--============================================================================================
-- ATUALIZAR ESTATÍSTICAS UTILIZANDO TODA TABELA
--===========================================================================================
UPDATE STATISTICS STD_Evaluation WITH FULLSCAN, NORECOMPUTE 

--NORECOMPUTE: Desativar a opção de atualização automática de estatísticas, AUTO_UPDATE_STATISTICS, para as estatísticas especificadas. Se essa opção for especificada, o otimizador de consulta conclui essa atualização de estatísticas e desabilita futuras atualizações.

