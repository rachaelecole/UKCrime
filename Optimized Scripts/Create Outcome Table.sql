Use UKCRIME

create table dbo.Outcome
(
OutcomeID int identity not null primary key,
[Last Outcome] varchar(100),
)
insert into dbo.Outcome
([Last Outcome])
select distinct
	[Last outcome category]
from [dbo].[Crime]

--DROP TABLE dbo.Outcome

--SELECT * FROM dbo.Outcome
