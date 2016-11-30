drop view vw_crimeratiosbyregion
go

create view vw_CrimeRatiosByRegion as

select 
	c.Region
	,cast(c.[Number of Crimes] as float) /cast( p.[Total Population]as float) [No. of crimes per person]
from [dbo].[vw_CrimeTotalsbyRegion] c
join vw_population p on c.Region = p.region

--select * from vw_CrimeRatiosByRegion
