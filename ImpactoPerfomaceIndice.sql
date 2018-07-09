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
SEM �NDICE: 02:12
COM �NDICE(COBERTURA): 02:47

*/


--================================================================================================================================================================
-- UPDATE
--================================================================================================================================================================
DROP INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_INSERT_DEMO

UPDATE NONCLUSTERED_INSERT_DEMO SET NAME = 'NOME MODIFICADO' WHERE NAME LIKE '%L%'
/*
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 125 ms, tempo decorrido = 556 ms.
Tabela 'NONCLUSTERED_INSERT_DEMO'. N�mero de verifica��es 5, leituras l�gicas 115952, leituras f�sicas 2, leituras read-ahead 26260, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 655 ms, tempo decorrido = 1628 ms.

(64264 rows affected)
*/

GO
--================================================================================================================================================================
-- UPDATE  + �NDICE (COBERTURA)
--================================================================================================================================================================
CREATE NONCLUSTERED INDEX IX_NONCLUSTERED_NAME ON NONCLUSTERED_INSERT_DEMO(NAME)
INCLUDE(ID, TELEFONE, DT_NASCIMENTO, ENDERECO)
WITH(ONLINE = ON, FILLFACTOR = 90)

UPDATE NONCLUSTERED_INSERT_DEMO SET NAME = 'NOME MODIFICADO 2 ' WHERE NAME = N'NOME MODIFICADO'
/*
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 3 ms.
Tempo de an�lise e compila��o do SQL Server: 
   Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
Tabela 'NONCLUSTERED_INSERT_DEMO'. N�mero de verifica��es 1, leituras l�gicas 703142, leituras f�sicas 0, leituras read-ahead 266, leituras l�gicas lob 227510, leituras f�sicas lob 0, leituras read-ahead lob 100856.
Tabela 'Worktable'. N�mero de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras read-ahead 0, leituras l�gicas lob 0, leituras f�sicas lob 0, leituras read-ahead lob 0.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 4984 ms, tempo decorrido = 19759 ms.

(64264 rows affected)
*/



