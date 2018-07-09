USE ESTUDO_INDICE
GO

CREATE TABLE NONCLUSTERED_INSERT_DEMO
(
	 ID INT IDENTITY(1,1) NOT NULL
	,NAME NVARCHAR(50) NULL
	,DT_NASCIMENTO DATETIME NULL
	,TELEFONE VARCHAR(20)
	,ENDERECO NVARCHAR(MAX)
)

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_INSERT_DEMO(NAME)
INCLUDE(ID, ENDERECO, TELEFONE, DT_NASCIMENTO)
WITH(ONLINE = ON, FILLFACTOR = 90, DROP_EXISTING = OFF)

/*
INSERIR 200.000 REGISTROS:
SEM ÍNDICE: 02:12
COM ÍNDICE(COBERTURA): 02:47

*/


--================================================================================================================================================================
-- UPDATE
--================================================================================================================================================================
DROP INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_INSERT_DEMO

UPDATE NONCLUSTERED_INSERT_DEMO SET NAME = 'NOME MODIFICADO' WHERE NAME LIKE '%L%'
/*
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 125 ms, tempo decorrido = 556 ms.
Tabela 'NONCLUSTERED_INSERT_DEMO'. Número de verificações 5, leituras lógicas 115952, leituras físicas 2, leituras read-ahead 26260, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 655 ms, tempo decorrido = 1628 ms.

(64264 rows affected)
*/

GO
--================================================================================================================================================================
-- UPDATE  + ÍNDICE (COBERTURA)
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_INSERT_DEMO(NAME)
INCLUDE(ID, TELEFONE, DT_NASCIMENTO, ENDERECO)
WITH(ONLINE = ON, FILLFACTOR = 90)

UPDATE NONCLUSTERED_INSERT_DEMO SET NAME = 'NOME MODIFICADO 2 ' WHERE NAME = N'NOME MODIFICADO'
/*
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 3 ms.
Tempo de análise e compilação do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
Tabela 'NONCLUSTERED_INSERT_DEMO'. Número de verificações 1, leituras lógicas 703142, leituras físicas 0, leituras read-ahead 266, leituras lógicas lob 227510, leituras físicas lob 0, leituras read-ahead lob 100856.
Tabela 'Worktable'. Número de verificações 0, leituras lógicas 0, leituras físicas 0, leituras read-ahead 0, leituras lógicas lob 0, leituras físicas lob 0, leituras read-ahead lob 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 4984 ms, tempo decorrido = 19759 ms.

(64264 rows affected)
*/



