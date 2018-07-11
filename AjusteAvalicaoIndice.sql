USE IndexDemoDB
GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT * FROM STD_Evaluation WHERE STD_ID < 1350
/*
Table 'STD_Evaluation'. Scan count 1, logical reads 317, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 63 ms,  elapsed time = 357 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

--============================================================================================
-- INDICE STD_ID (NÃO CLUSTERIZADO)
--============================================================================================
CREATE NONCLUSTERED INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation(STD_ID)

SELECT * FROM STD_Evaluation WHERE STD_ID < 1350
/*
Table 'STD_Evaluation'. Scan count 1, logical reads 317, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 47 ms,  elapsed time = 346 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

*/

--============================================================================================
-- EXIBE ÍNDICES AUSENTES
--============================================================================================
SELECT * FROM sys.dm_db_missing_index_details


--============================================================================================
-- ÍNDICE NÃO CLUSTERIZADO (COBERTURA)
--============================================================================================
DROP INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation

CREATE NONCLUSTERED INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation(STD_ID)
INCLUDE(EV_ID, COURSE_ID, STD_Course_Grade)
WITH(FILLFACTOR = 90)

SELECT * FROM STD_Evaluation WHERE STD_ID < 1350
/*
Table 'STD_Evaluation'. Scan count 1, logical reads 420, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 47 ms,  elapsed time = 361 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'STD_Evaluation'. Scan count 1, logical reads 420, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 15 ms,  elapsed time = 344 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@ TERCEIRA EXECUÇÃO

Table 'STD_Evaluation'. Scan count 1, logical reads 420, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 16 ms,  elapsed time = 395 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

*/

--============================================================================================
-- ÍNDICE CLUSTERIZADO(EV_ID) + ÍNDICE NÃO CLUSTERIZADO (COBERTURA)
--============================================================================================
DROP INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation

CREATE CLUSTERED INDEX IX_STD_EVALUATION_EV_ID ON STD_Evaluation(EV_ID)

CREATE NONCLUSTERED INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation(STD_ID)
INCLUDE(EV_ID, Course_ID, STD_Course_Grade)
WITH(DROP_EXISTING = OFF)

SELECT * FROM STD_Evaluation WHERE STD_ID < 1350
/*
Table 'STD_Evaluation'. Scan count 1, logical reads 278, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 31 ms,  elapsed time = 342 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@ SEGUNDA EXECUÇÃO

Table 'STD_Evaluation'. Scan count 1, logical reads 278, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 31 ms,  elapsed time = 390 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@ TERCEIRA EXECUÇÃO 

Table 'STD_Evaluation'. Scan count 1, logical reads 278, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 378 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.


*/

--============================================================================================
-- ÍNDICE CLUSTERIZADO (STD_ID)
--============================================================================================
DROP INDEX IX_STD_EVALUATION_EV_ID ON STD_Evaluation

DROP INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation

CREATE CLUSTERED INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation(STD_ID)

SELECT * FROM STD_Evaluation WHERE STD_ID < 1350
/*
Table 'STD_Evaluation'. Scan count 1, logical reads 418, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 344 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'STD_Evaluation'. Scan count 1, logical reads 418, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 16 ms,  elapsed time = 401 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@TERCEIRA EXECUÇÃO

Table 'STD_Evaluation'. Scan count 1, logical reads 418, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 31 ms,  elapsed time = 349 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

*/

--============================================================================================
-- AJUSTES EM CONSULTAS COMPLEXAS
--============================================================================================
DROP INDEX IX_STD_EVALUATION_EV_ID ON STD_Evaluation

DROP INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation


SELECT 
		ST.[STD_Name] 
	,C.[Course_Name]
	,C.[Course_MaxGrade]
	,EV.[STD_Course_Grade]
FROM 
	[dbo].[STD_Info] ST
JOIN
	[dbo].[STD_Evaluation] EV
	ON ST.STD_ID =EV.[STD_ID]
JOIN 
	[dbo].[Courses] C 
	ON C.Course_ID= EV.Course_ID
WHERE
	ST.[STD_ID] > 1500 
AND 
	C.Course_ID >320

/*
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 413, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 83 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 413, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 20 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@TERCEIRA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 413, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 68 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

--============================================================================================
-- EXECUÇÃO APÓS CRIAÇÃO DO ÍNDICE
--============================================================================================

--GERADO PELO DATABASE ENGINE TUNING ADVISOR
CREATE CLUSTERED INDEX [_dta_index_STD_Evaluation_c_5_965578478__K2_K3] ON [dbo].[STD_Evaluation]
(
	[STD_ID] ASC,
	[Course_ID] ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]

SELECT 
	 ST.[STD_Name] 
	,C.[Course_Name]
	,C.[Course_MaxGrade]
	,EV.[STD_Course_Grade]
FROM 
	[dbo].[STD_Info] ST
JOIN
	[dbo].[STD_Evaluation] EV
	ON ST.STD_ID =EV.[STD_ID]
JOIN 
	[dbo].[Courses] C 
	ON C.Course_ID= EV.Course_ID
WHERE
	ST.[STD_ID] > 1500 
AND 
	C.Course_ID >320


/*
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 16 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
*/

--============================================================================================
-- CRIAÇÃO DE ESTATISTICAS
--============================================================================================

--GERADO PELO DATABASE ENGINE TUNING ADVISOR
CREATE STATISTICS [_dta_stat_965578478_3_2] ON [dbo].[STD_Evaluation]([Course_ID], [STD_ID])

--============================================================================================
-- BACKWARD (LEITURA INVERSA DO ÍNDICE)
--============================================================================================
SELECT 
	 ST.[STD_Name] 
	,C.[Course_Name]
	,C.[Course_MaxGrade]
	,EV.[STD_Course_Grade]
FROM 
	[dbo].[STD_Info] ST
JOIN
	[dbo].[STD_Evaluation] EV
	ON ST.STD_ID =EV.[STD_ID]
JOIN 
	[dbo].[Courses] C 
	ON C.Course_ID= EV.Course_ID
WHERE
	ST.[STD_ID] > 1500 
AND 
	C.Course_ID >320
ORDER BY
	ST.[STD_ID] DESC,C.[Course_ID] DESC

/*
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 72 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 17 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@TERCEIRA EXECUÇÃO
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 77 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

*/

--============================================================================================
-- SORT
--============================================================================================

SELECT 
	 ST.[STD_Name] 
	,C.[Course_Name]
	,EV.[STD_Course_Grade]
FROM 
	[dbo].[STD_Info] ST
JOIN
	[dbo].[STD_Evaluation] EV
	ON ST.STD_ID =EV.[STD_ID]
JOIN 
	[dbo].[Courses] C 
	ON C.Course_ID= EV.Course_ID
WHERE
	ST.[STD_ID] > 1500 
AND 
	C.Course_ID >320
ORDER BY
	ST.[STD_ID] ASC,C.[Course_ID] DESC
	

/*
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 80 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 19 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@TERCEIRA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 3, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 16 ms,  elapsed time = 78 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.
*/


--============================================================================================
-- CRIAÇÃO DE ÍNDICES INDIVIDUAIS PARA AS COLUNAS - NESTE EXEMPLO APARENTEMENTE MELHOROU, MAS ATENÇÃO
--============================================================================================
DROP INDEX _dta_index_STD_Evaluation_c_5_965578478__K2_K3 ON STD_Evaluation

CREATE NONCLUSTERED INDEX IX_STD_EVALUATION_STD_ID ON STD_Evaluation(STD_ID)
GO
CREATE NONCLUSTERED INDEX IX_STD_EVALUATION_COURSE_ID ON STD_Evaluation(Course_ID)
WITH(ONLINE = ON, FILLFACTOR = 90, SORT_IN_TEMPDB = ON, DROP_EXISTING = OFF)

SELECT 
	 ST.[STD_Name] 
	,C.[Course_Name]
	,EV.[STD_Course_Grade]
FROM 
	[dbo].[STD_Info] ST
JOIN
	[dbo].[STD_Evaluation] EV
	ON ST.STD_ID =EV.[STD_ID]
JOIN 
	[dbo].[Courses] C 
	ON C.Course_ID= EV.Course_ID
WHERE
	ST.[STD_ID] > 1500 
AND 
	C.Course_ID >320

/*
Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 15 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@SEGUNDA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 19 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.

@@TERCEIRA EXECUÇÃO

Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'STD_Evaluation'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 16 ms.
SQL Server parse and compile time: 
   CPU time = 0 ms, elapsed time = 0 ms.

 SQL Server Execution Times:
   CPU time = 0 ms,  elapsed time = 0 ms.


*/