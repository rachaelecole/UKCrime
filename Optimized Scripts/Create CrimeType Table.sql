CREATE TABLE dbo.CrimeType
(
CrimeTypeID int identity not null primary key,
CrimeType varchar(50)
)
INSERT dbo.CrimeType
(CrimeType)
SELECT DISTINCT
([Crime type])
FROM dbo.Crime
	
--DROP TABLE dbo.CrimeType

--SELECT * FROM dbo.CrimeType