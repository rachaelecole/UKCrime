--drop view dbo.vw_GenderRatiosbyArea
--go

create view dbo.vw_population as
select 
region
,sum([ALL AGES]) [Total Population]
from [dbo].[UKPopulation] 
group by Region

select * from dbo.vw_population


