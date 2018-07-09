USE ESTUDO_INDICE
GO

CREATE TABLE MEDICOS
(
	 ID INT IDENTITY(1,1) PRIMARY KEY
	,CRA INT NOT NULL UNIQUE
)

SELECT * FROM MEDICOS WHERE CRA = 1234546

ALTER INDEX [UQ__MEDICOS__C1F8870B627BCDD8] ON MEDICOS DISABLE

SELECT * FROM MEDICOS WHERE CRA = 1234546



ALTER INDEX PK__MEDICOS__3214EC273DD8B847 ON MEDICOS DISABLE

SELECT * FROM MEDICOS --O processador de consultas n�o consegue produzir um plano porque o �ndice 'PK__MEDICOS__3214EC273DD8B847' na tabela ou exibi��o 'MEDICOS' est� desabilitado.

ALTER INDEX PK__MEDICOS__3214EC273DD8B847 ON MEDICOS REBUILD
SELECT * FROM MEDICOS


CREATE UNIQUE INDEX [UQ__MEDICOS__C1F8870B627BCDD8] ON MEDICOS (CRA) WITH (DROP_EXISTING = ON)
SELECT * FROM MEDICOS WHERE CRA = 123456

EXEC sp_rename N'MEDICOS.UQ__MEDICOS__C1F8870B627BCDD8', N'IDX_UQ_CRA', N'INDEX'

DROP INDEX UQ__MEDICOS__C1F8870B627BCDD8 ON MEDICOS

SELECT * FROM sys.indexes WHERE name = 'IX_EST_PN_UN'

