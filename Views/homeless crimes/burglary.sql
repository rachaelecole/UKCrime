drop view vw_burglarycrime
go
create view vw_burglarycrime as

select
	ct.crimetype
	,count(c.CaseID) [Total]
	,r.region
from dbo.Cases c
join dbo.CrimeType ct on c.CrimeTypeID = ct.CrimeTypeID
join dbo.LSOA l on c.LSOAID = l.LSOAID
join dbo.GeographicArea g on l.GeographicAreaID = g.GeographicAreaID
join dbo.Region r on g.RegionID = r.RegionID
join vw_population p on r.Region = p.region
group by ct.CrimeType, r.Region
having ct.CrimeType = 'burglary'
go

select * from vw_burglarycrime

-------------RATIOS----------------


drop view vw_burglaryratios
go

create view vw_burglaryratios as

select 
	b.Region
	,cast(b.[Total] as float) /cast( p.[Total Population]as float) [No. of Burglaries per person]
from vw_burglarycrime b
join dbo.vw_population p  on b.region = p.region
go
select * from vw_burglaryratios