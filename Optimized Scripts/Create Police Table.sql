Use UKCRIME

create table dbo.Police
(
PoliceID int identity not null primary key,
FallsWithin varchar(50),
ReportedBy varchar(50)
)

insert into dbo.Police
(FallsWithin,ReportedBy)
select distinct
	[Falls within]
	,[Reported by]
from [dbo].[Crime]

--DROP TABLE dbo.Police

--SELECT * FROM dbo.Police

