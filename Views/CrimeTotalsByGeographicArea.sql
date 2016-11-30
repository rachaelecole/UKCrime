drop view vw_CrimeTotalsbyGeographicArea
go

create view vw_CrimeTotalsbyGeographicArea
as

select
	count(c.CaseID) [Number of Crimes]
	,g.GeographicArea
from dbo.Cases c
join LSOA l on c.LSOAID = l.LSOAID
join dbo.GeographicArea g on l.GeographicAreaID = g.GeographicAreaID
group by g.GeographicArea

go

select * from vw_CrimeTotalsbyGeographicArea

/*************************************/

create view vw_crimeratiosbyGeographicArea
as

select
	c.GeographicArea
	,CAST(c.[Number of Crimes] as float) / cast(p.Population as float) [Crime per person]
from vw_CrimeTotalsbyGeographicArea c
join vw_PopulationDataByArea p on p.county = c.GeographicArea
go

select * from vw_crimeratiosbyGeographicArea