Use UKCRIME

create table dbo.[Date]
(
DateID int identity not null primary key,
[Month] tinyint,
[Year] int
)
insert into dbo.Date
([Month],[Year])
select distinct
	RIGHT([Month],2)
	,Left([Month],4)
from [dbo].[Crime]

--DROP TABLE dbo.[Date]

--SELECT * FROM dbo.[Date]