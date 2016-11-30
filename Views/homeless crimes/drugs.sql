drop view vw_drugscrime
go
create view vw_drugscrime as

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
having ct.CrimeType = 'drugs'
go

select * from vw_drugscrime



--------------RATIOS-----------------

drop view vw_drugsratios
go

create view vw_drugsratios as

select 
	b.Region
	,cast(b.[Total] as float) /cast( p.[Total Population]as float) [No. of Drug crimes per person]
from vw_drugscrime b
join dbo.vw_population p  on b.region = p.region
go
select * from vw_drugsratios