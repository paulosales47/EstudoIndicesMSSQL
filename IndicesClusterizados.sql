USE ESTUDO_INDICE
GO

CREATE TABLE CLUSTERED_DEMO
(
	 ID INT IDENTITY(1,1) NOT NULL
	,GUID UNIQUEIDENTIFIER NOT NULL
	,NAME NVARCHAR(200) NOT NULL
	,DT_NASCIMENTO DATETIME NOT NULL
	,ENDERECO NVARCHAR(MAX),
	CONSTRAINT PK_CLUSTERED_DEMO_GUID PRIMARY KEY NONCLUSTERED(GUID)
)

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

--================================================================================================================================================================
-- ID
--================================================================================================================================================================
DROP INDEX IX_CLUSTERED_DT_NASCIMENTO ON CLUSTERED_DEMO
CREATE UNIQUE CLUSTERED INDEX IX_CLUSTERED_ID ON dbo.CLUSTERED_DEMO
(
	ID ASC
) WITH( SORT_IN_TEMPDB = ON, DROP_EXISTING = OFF, FILLFACTOR = 90, ONLINE = ON) ON [PRIMARY]

SELECT * FROM CLUSTERED_DEMO WHERE ID > 1000 AND ENDERECO LIKE '%12'
/*
(72 rows affected)
Tabela 'CLUSTERED_DEMO'. Número de verificações 5, leituras lógicas 27330, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 308006, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 41687 ms, tempo decorrido = 11364 ms.
*/

--================================================================================================================================================================
-- GUID
--================================================================================================================================================================
DROP INDEX IX_CLUSTERED_ID ON CLUSTERED_DEMO
GO
CREATE UNIQUE CLUSTERED INDEX IX_CLUSTERED_GUID ON CLUSTERED_DEMO
(
	GUID ASC
)WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, FILLFACTOR = 90, ONLINE = ON) ON [PRIMARY]


SELECT * FROM CLUSTERED_DEMO WHERE GUID <> 'CB2F45A0-185F-9884-88EB-B7C497AB61EA' AND ENDERECO LIKE '%12'
/*
(73 rows affected)
Tabela 'CLUSTERED_DEMO'. Número de verificações 8, leituras lógicas 27931, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 311201, leituras físicas lob 143, leituras read-ahead lob 0.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 41140 ms, tempo decorrido = 11633 ms.
*/

--================================================================================================================================================================
DROP INDEX IX_CLUSTERED_GUID ON CLUSTERED_DEMO
CREATE UNIQUE CLUSTERED INDEX IX_CLUSTERED_NAME ON CLUSTERED_DEMO
(
	NAME ASC
)WITH( SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, FILLFACTOR = 90, ONLINE = ON) ON [PRIMARY]
GO

SELECT * FROM CLUSTERED_DEMO WHERE NAME <> 'Sofia' AND ENDERECO LIKE '%12'
/*
(73 rows affected)
Tabela 'CLUSTERED_DEMO'. Número de verificações 7, leituras lógicas 28010, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 311212, leituras físicas lob 0, leituras read-ahead lob 0.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 40002 ms, tempo decorrido = 11345 ms.
*/
--================================================================================================================================================================
DROP INDEX IX_CLUSTERED_NAME ON CLUSTERED_DEMO
CREATE UNIQUE CLUSTERED INDEX IX_CLUSTERED_DT_NASCIMENTO ON CLUSTERED_DEMO
(
	DT_NASCIMENTO ASC

)WITH( SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, FILLFACTOR = 90, ONLINE = ON) ON [PRIMARY]

SET DATEFORMAT YMD
SELECT * FROM CLUSTERED_DEMO WHERE DT_NASCIMENTO BETWEEN '2000-01-01' AND '2000-12-31' AND ENDERECO LIKE '%12'
/*
(3 rows affected)
Tabela 'CLUSTERED_DEMO'. Número de verificações 1, leituras lógicas 409, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 4886, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 625 ms, tempo decorrido = 731 ms.
*/