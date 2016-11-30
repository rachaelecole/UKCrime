drop view vw_homelessnessethnicities
go


create view vw_homelessnessethnicities as

select 
	r.Region
	,sum(h.[Homelessness White])   [White]
	,sum(h.[Homelessness  Black or Black British]) [Black]
	,sum(h.[Homelessness  Asian or Asian British]) [Asian]
	,sum(h.[Homelessness  Mixed]) [Mixed]
	,sum(h.[Homelessness  Other ethnic origin]) [Other]
	,sum(h.[Homelessness  Ethnic Group not Stated]) [Not Stated]

from dbo.Homeless h

join dbo.GeographicArea g on h.GeographicArea = g.GeographicArea
join dbo.Region r on g.RegionID = r.RegionID

group by Region

select * from vw_homelessnessethnicities