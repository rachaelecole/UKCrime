drop view vw_alltheftcrime
go
create view vw_alltheftcrime as

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
group by  r.Region, ct.CrimeType
having ct.CrimeType in ('Bicycle theft','Other theft', 'Theft from the person')
go

select * from vw_alltheftcrime



----------SUM-------------

drop view vw_alltheftsum
go
create view vw_alltheftsum as
select
	Region
	,sum(Total) [All theft]

from [dbo].[vw_alltheftcrime]
group by Region
go
select * from vw_alltheftsum



--------------RATIOS-----------------

drop view vw_alltheftratios
go

create view vw_alltheftratios as

select 
	b.Region
	,cast(b.[All theft] as float) /cast( p.[Total Population]as float) [No. of Theft crimes per person]
from vw_alltheftsum b
join dbo.vw_population p  on b.region = p.region
go
select * from vw_alltheftratios