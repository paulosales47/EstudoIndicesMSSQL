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
-- CONSULTA SEM �NDICE
--================================================================================================================================================================
SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 5, leituras l�gicas 25961, leituras f�sicas 0, leituras read-ahead 25800, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 45 ms, tempo decorrido = 573 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
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
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 1, leituras l�gicas 3, leituras f�sicas 3, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 119 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms..
*/

--================================================================================================================================================================
-- NAME / ID / ENDERE�O
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO
(
	NAME
) INCLUDE (ID, ENDERECO)

WITH(DROP_EXISTING = OFF, ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 1, leituras l�gicas 4, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 25 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- NAME / ID / ENDERE�O / TELEFONE / DT_NASCIMENTO (�NDICE DE COBERTURA) - TODAS AS COLUNAS DO SELECT
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, DT_NASCIMENTO, TELEFONE, ENDERECO)
WITH (DROP_EXISTING = ON, ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'

--================================================================================================================================================================
-- CRIANDO �NDICE CLUSTERIZADO
--================================================================================================================================================================

DROP INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO

CREATE UNIQUE CLUSTERED INDEX IX_NONCLUSTERED_ID ON NONCLUSTERED_DEMO(ID)
WITH(ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 5, leituras l�gicas 30599, leituras f�sicas 0, leituras read-ahead 35, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 94 ms, tempo decorrido = 58 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- �NDICE CLUSTERIZADO + N�O CLUSTERIZADO (NAME, ID, ENDERE�O)
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, ENDERECO)
WITH(ONLINE = ON, FILLFACTOR = 90)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 1, leituras l�gicas 4, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 32 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/

--================================================================================================================================================================
-- �NDICE CLUSTERIZADO + NAME / ID / ENDERE�O / TELEFONE / DT_NASCIMENTO (�NDICE DE COBERTURA) - TODAS AS COLUNAS DO SELECT
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_DEMO(NAME)
INCLUDE(ID, ENDERECO, TELEFONE, DT_NASCIMENTO)
WITH(ONLINE = ON, FILLFACTOR = 90, DROP_EXISTING = ON)

SELECT * FROM NONCLUSTERED_DEMO WHERE NAME = 'Paulo' AND ENDERECO LIKE '%12'
/*
(0 rows affected)
Tabela 'NONCLUSTERED_DEMO'. N�mero de verifica��es 1, leituras l�gicas 4, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

(1 row affected)

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 31 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
*/