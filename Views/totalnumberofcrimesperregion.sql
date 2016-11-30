drop view vw_crimetotalsbyregion
go
create view vw_CrimeTotalsbyRegion as

select
	count(CaseID) [Number of Crimes] 
	,Region
from dbo.Cases c
join dbo.LSOA l	on c.LSOAID = l.LSOAID
join dbo.GeographicArea g on l.GeographicAreaID = g.GeographicAreaID
join dbo.Region r on g.RegionID = r.RegionID 
group by Region

--select * from vw_CrimeTotalsbyRegion