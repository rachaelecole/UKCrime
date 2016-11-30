drop view vw_bicycletheftcrime
go
create view vw_bicycletheftcrime as

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
having ct.CrimeType = 'bicycle theft'
go

select * from vw_bicycletheftcrime


----------------RATIOS-------------------
drop view vw_bikecrimeratios
go

create view vw_bikecrimeratios as

select 
	b.Region
	,cast(b.[Total] as float) /cast( p.[Total Population]as float) [No. of Bike Thefts per person]
from vw_bicycletheftcrime b
join dbo.vw_population p  on b.region = p.region
go
select * from vw_bikecrimeratios