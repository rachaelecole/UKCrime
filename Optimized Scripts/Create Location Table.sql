Use UKCRIME

create table dbo.Location
(
LocationID int identity not null primary key,
Location varchar(100),
)

insert into dbo.Location
(Location)
select distinct
	substring(Location,12,len(location))

from [dbo].[Crime]

--drop table dbo.Location

--SELECT * FROM dbo.Location

