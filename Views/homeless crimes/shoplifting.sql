drop view vw_shopliftingcrime
go
create view vw_shopliftingcrime as

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
having ct.CrimeType = 'shoplifting'
go

select * from vw_shopliftingcrime



--------------RATIOS-----------------

drop view vw_shopliftingratios
go

create view vw_shopliftingratios as

select 
	b.Region
	,cast(b.[Total] as float) /cast( p.[Total Population]as float) [No. of shoplifting crimes per person]
from vw_shopliftingcrime b
join dbo.vw_population p  on b.region = p.region
go
select * from vw_shopliftingratios