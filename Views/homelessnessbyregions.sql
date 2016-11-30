drop view vw_HomelessTotalsbyRegion
go
create view vw_HomelessTotalsbyRegion as

select
	r.Region
	,sum([Homelessness total]) [Total Number of Homeless]
from dbo.homeless h
left outer join dbo.GeographicArea g on h.GeographicArea = g.GeographicArea
left outer join dbo.Region r on g.RegionID = r.RegionID
group by Region

--select * from vw_HomelessTotalsbyRegion

select * from dbo.GeographicArea g
join dbo.Region r ON r.RegionID = g.RegionID
RIGHT OUTER join dbo.Homeless h ON h.GeographicArea = g.GeographicArea
 