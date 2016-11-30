use UKCRIME

DROP TABLE dbo.HomelessnessTotals

CREATE TABLE dbo.HomelessnessTotals
(
HomlessnessID int identity not null primary key,
GeographicAreaID int foreign key references dbo.geographicarea(geographicareaID),
[2014 Household Projections (thousands)] int,
[Homelessness:White] int,
[Homelessness:Black/Black British] int,
[Homelessness:Asian/Asian British] int,
[Homelessness:Mixed] int,
[Homelessness:OtherEthnicOrigin] int,
[Homelessness:Ethnicitynotstated] int,
[HomelessnessTotal] int,
[HomelessnessNo.per1000households] float
)
INSERT INTO dbo.HomelessnessTotals
(GeographicAreaID,
[2014 Household Projections (thousands)] ,
[Homelessness:White],[Homelessness:Black/Black British],
[Homelessness:Asian/Asian British],
[Homelessness:Mixed],
[Homelessness:OtherEthnicOrigin],
[Homelessness:Ethnicitynotstated],
[HomelessnessTotal],
[HomelessnessNo.per1000households])
SELECT 
	g.RegionID
	,h.[Thousands of households 2012-based interim projections for 2014]
	,h.[Homelessness White]
	,h.[Homelessness  Black or Black British]
	,h.[Homelessness  Asian or Asian British]
	,h.[Homelessness  Mixed]
	,h.[Homelessness  Other ethnic origin]
	,h.[Homelessness  Ethnic Group not Stated]
	,[Homelessness total]
	,[Homelessness Number per 1000 households]

FROM dbo.Homeless h
JOIN dbo.GeographicArea g
ON g.GeographicArea = h.GeographicArea

select * from dbo.HomelessnessTotals


