drop view vw_crimetypes
go


create view vw_crimetypes as

select
	ct.CrimeType
	,count(c.CaseID) [Total]
	,r.region
from dbo.Cases c

--tables need to be joined for r.region to be in the select query
join dbo.CrimeType ct on c.CrimeTypeID = ct.CrimeTypeID
join dbo.LSOA l on c.LSOAID = l.LSOAID
join dbo.GeographicArea g on l.GeographicAreaID = g.GeographicAreaID
join dbo.Region r on g.RegionID = r.RegionID
--as the select query contains an aggragate function, need a group by statement	
group by ct.CrimeType, r.Region

