USE ESTUDO_INDICE

CREATE TABLE INDEX_TYPES_DEMO
(
	 ID INT IDENTITY(1,1) PRIMARY KEY
	,NAME VARCHAR(50)
	,ENDERECO NVARCHAR(MAX)
)

--================================================================================================================================================================
-- ÍNDICE FILTRADO (MUITAS LINHAS DA COLUNA COM VALORES NULOS)
--=================================================================================================================================================================
CREATE INDEX IX_INDEX_FILTRADO_NAME ON INDEX_TYPES_DEMO(NAME) WHERE NAME IS NOT NULL

ALTER INDEX IX_INDEX_FILTRADO_NAME ON INDEX_TYPES_DEMO REBUILD

INSERT INTO INDEX_TYPES_DEMO(NAME, ENDERECO) VALUES('Paulo Henrique', 'Praça primeiro de maio')

GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

SELECT NAME FROM INDEX_TYPES_DEMO WHERE NAME = 'Paulo Henrique'