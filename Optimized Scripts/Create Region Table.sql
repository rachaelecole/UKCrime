Use UKCRIME

create table dbo.Region
(
RegionID int identity not null primary key,
Region varchar(50)

)

insert into dbo.Region
(Region)
select distinct
	left([LSOA Name], Len([LSOA Name]) - 5)
from [dbo].[Crime_Oct15_Sep16]
where LEN([LSOA name]) != 0

--drop table dbo.Region

--select * from dbo.Region