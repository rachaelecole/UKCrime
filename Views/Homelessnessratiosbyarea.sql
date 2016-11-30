drop view vw_homelessnessTotalsbyArea
go

create view vw_homelessnessTotalsbyArea
as

select
	g.GeographicArea
	,sum(h.[Homelessness total]) [Total Number of Homeless]
from dbo.Homeless h
left outer join dbo.GeographicArea g on h.GeographicArea = g.GeographicArea
group by g.GeographicArea
go

select * from vw_homelessnessTotalsbyArea


/***************************************/


create view vw_homelessnessratiosbyarea
as

select
	h.GeographicArea
	,cast(h.[Total Number of Homeless] as float) / cast(p.Population as float) [Homeless per person]
from vw_homelessnessTotalsbyArea h
join vw_PopulationDataByArea p on p.county = h.GeographicArea
go

select * from vw_homelessnessratiosbyarea