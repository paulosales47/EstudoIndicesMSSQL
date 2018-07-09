USE ESTUDO_INDICE
GO

CREATE TABLE NONCLUSTERED_DEMO
(
	 ID INT IDENTITY(1,1) NOT NULL
	,NAME NVARCHAR(50) NULL
	,DT_NASCIMENTO DATETIME NULL
	,TELEFONE VARCHAR(20)
	,ENDERECO NVARCHAR(MAX)
)

--================================================================================================================================================================
-- CONSULTA SEM ÍNDICE
--================================================================================================================================================================
SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 5, leituras lógicas 25961, leituras físicas 0, leituras read-ahead 25800, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 45 ms, tempo decorrido = 573 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/


--================================================================================================================================================================
-- ATIVANDO ESTATISTICAS
--================================================================================================================================================================
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

--================================================================================================================================================================
-- NAME
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO
(
	NAME
) WITH(ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 1, leituras lógicas 3, leituras físicas 3, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 119 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms..
*/

--================================================================================================================================================================
-- NAME / ID / ENDEREÇO
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO
(
	NAME
) INCLUDE (ID, ENDERECO)

WITH(DROP_EXISTING = OFF, ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 1, leituras lógicas 4, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 25 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- NAME / ID / ENDEREÇO / TELEFONE / DT_NASCIMENTO (ÍNDICE DE COBERTURA) - TODAS AS COLUNAS DO SELECT
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, DT_NASCIMENTO, TELEFONE, ENDERECO)
WITH (DROP_EXISTING = ON, ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'

--================================================================================================================================================================
-- CRIANDO ÍNDICE CLUSTERIZADO
--================================================================================================================================================================

DROP INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO

CREATE UNIQUE CLUSTERED INDEX IX_NONCLUSTERED_ID ON NONCLUSTERED_DEMO(ID)
WITH(ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 5, leituras lógicas 30599, leituras físicas 0, leituras read-ahead 35, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 94 ms, tempo decorrido = 58 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- ÍNDICE CLUSTERIZADO + NÃO CLUSTERIZADO (NAME, ID, ENDEREÇO)
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, ENDERECO)
WITH(ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 1, leituras lógicas 4, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 32 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- ÍNDICE CLUSTERIZADO + NAME / ID / ENDEREÇO / TELEFONE / DT_NASCIMENTO (ÍNDICE DE COBERTURA) - TODAS AS COLUNAS DO SELECT
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, ENDERECO, TELEFONE, DT_NASCIMENTO)
WITH(ONLINE = ON, FILLFACTOR = 90, DROP_EXISTING = ON)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. Número de verificações 1, leituras lógicas 4, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 31 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/