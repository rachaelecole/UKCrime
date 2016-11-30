drop view vw_HomelessnessRatiosByRegion
go

create view vw_HomelessnessRatiosByRegion as

select 
	h.Region
	,cast(h.[Total Number of Homeless] as float) /cast( p.[Total Population]as float) [No. of Homeless per person]
from [dbo].[vw_HomelessTotalsbyRegion] h
join vw_population p on h.Region = p.region

--select * from vw_HomelessnessRatiosByRegion
