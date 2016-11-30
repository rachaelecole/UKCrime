Use UKCRIME

create table dbo.Coordinates
(
CoordinateID int identity not null primary key,
Latitude float,
Longitude float

)

insert into dbo.Coordinates
(Latitude,Longitude)
select distinct
	Latitude
	,Longitude
from [dbo].[Crime]
where Latitude != '0'

--select * from dbo.Coordinates