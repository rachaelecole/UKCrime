--DROP ALL TABLES
drop table
dbo.cases,
dbo.coordinates, 
dbo.crimetype, 
dbo.[date],
dbo.location,
dbo.outcome,
dbo.police,
dbo.LSOA,
dbo.region,
dbo.GeographicArea
GO


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
GO

CREATE TABLE dbo.CrimeType
(
CrimeTypeID int identity not null primary key,
CrimeType varchar(50)
)
INSERT dbo.CrimeType
(CrimeType)
SELECT DISTINCT
([Crime type])
FROM dbo.Crime
WHERE LEN([Crime type])!=0
GO

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
WHERE LEN([Month])!=0
GO

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
WHERE LEN(Location)!=0 
GO

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
WHERE LEN([Last outcome category])!=0
GO

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
WHERE LEN([Falls within])!=0 AND LEN([Reported by])!=0
GO

create table dbo.Region
(
RegionID int identity not null primary key,
Region varchar(50)
)
insert into dbo.Region
(Region)
select distinct
	Region
from [dbo].UKPopulation
WHERE LEN(Region)!=0
GO

create table dbo.GeographicArea
(
GeographicAreaID int identity not null primary key,
GeographicArea varchar(50),
RegionID int foreign key references dbo.Region(RegionID)
)
insert into dbo.GeographicArea
(GeographicArea, RegionID)
select distinct
	left(c.[LSOA Name], Len(c.[LSOA Name]) - 5)
	,r.RegionID
from [dbo].[Crime] c
JOIN dbo.UKPopulation p
ON p.geographicarea = left(c.[LSOA Name], Len(c.[LSOA Name]) - 5)
JOIN dbo.Region r
ON r.Region = p.Region
where LEN(c.[LSOA name]) != 0
GO

CREATE TABLE dbo.LSOA
  (
  LSOAID int identity not null primary key
  ,LSOACode char(9)
  ,LSOAName varchar(100)
  ,GeographicAreaID int foreign key references dbo.GeographicArea(GeographicAreaID)
  )
  INSERT INTO dbo.LSOA
  (LSOACode, LSOAName,GeographicAreaID)
  SELECT DISTINCT
	l.[LSOA Code], l.[LSOA Name], r.[GeographicAreaID]
	FROM dbo.Crime l
join dbo.GeographicArea r
	on r.GeographicArea = left(l.[LSOA Name], Len(l.[LSOA Name]) - 5)
WHERE l.[LSOA Code] != '' AND l.[LSOA Name] != '' AND LEN(l.[LSOA Name])!=0
GO

set identity_insert [dbo].[Coordinates] on
insert into [dbo].[Coordinates]
([CoordinateID])
values
(-1)
set identity_insert [dbo].[Coordinates] off
GO

set identity_insert [dbo].[CrimeType] on
insert into [dbo].[CrimeType]
([CrimeTypeID])
values
(-1)
set identity_insert [dbo].[CrimeType] off
GO

set identity_insert [dbo].[Date] on
insert into [dbo].[Date]
([DateID])
values
(-1)
set identity_insert [dbo].[Date] off
GO

set identity_insert [dbo].[Location] on
insert into [dbo].[Location]
([LocationID])
values
(-1)
set identity_insert [dbo].[Location] off
GO

set identity_insert [dbo].[LSOA] on
insert into [dbo].[LSOA]
([LSOAID])
values
(-1)
set identity_insert [dbo].[LSOA] off
GO

set identity_insert [dbo].[Outcome] on
insert into [dbo].[Outcome]
([OutcomeID])
values
(-1)
set identity_insert [dbo].[Outcome] off
GO

set identity_insert [dbo].[Police] on
insert into [dbo].[Police]
([PoliceID])
values
(-1)
set identity_insert [dbo].[Police] off
GO

set identity_insert [dbo].[Region] on
insert into [dbo].[Region]
([RegionID])
values
(-1)
set identity_insert [dbo].[Region] off
GO

set identity_insert [dbo].[GeographicArea] on
insert into [dbo].[GeographicArea]
([GeographicAreaID])
values
(-1)
set identity_insert [dbo].[GeographicArea] off
GO

Create table dbo.Cases
(
CaseID int identity not null primary key,
CrimeID varchar(64),
DateID int foreign key references dbo.[date](dateid),
PoliceID int foreign key references dbo.police(policeid),
LSOAID int foreign key references dbo.lsoa(LSOAID),
LocationID int foreign key references dbo.location(locationid),
CoordinateID int foreign key references dbo.coordinates(coordinateid),
CrimeTypeID int foreign key references dbo.crimetype(crimetypeid),
OutcomeID int foreign key references dbo.outcome(outcomeID)
)
Insert into dbo.Cases
(crimeid,dateid,policeid,LSOAID,locationid,CoordinateID,CrimeTypeID,OutcomeID)
select
case len(c.[Crime ID]) when 0 then null else c.[Crime ID] end
,d.DateID,p.PoliceID,ls.LSOAID,l.LocationID,o.CoordinateID,t.CrimeTypeID,u.OutcomeID
FROM dbo.Crime c
LEFT OUTER JOIN dbo.Police p ON p.ReportedBy = (CASE LEN(c.[Reported by]) WHEN 0 THEN NULL ELSE  c.[Reported By] END) AND p.FallsWithin = (CASE LEN(c.[Falls within]) WHEN 0 THEN NULL ELSE c.[Falls within] END)
LEFT OUTER JOIN dbo.[Date] d ON d.[Month] = (CASE LEN(c.[Month]) WHEN 0 THEN NULL ELSE RIGHT(c.[Month],2) END) AND d.[Year] = (CASE LEN(c.[Month]) WHEN 0 THEN NULL ELSE LEFT(c.[Month],4) END) 
LEFT OUTER JOIN dbo.Location l ON l.Location = (CASE LEN(c.[Location]) WHEN 0 THEN NULL ELSE  substring(c.Location,12,len(c.location)) END) 
LEFT OUTER JOIN dbo.LSOA ls ON ls.LSOACode = (CASE LEN(c.[LSOA code]) WHEN 0 THEN NULL ELSE  c.[LSOA code] END) 
LEFT OUTER JOIN dbo.CrimeType t ON t.CrimeType = (CASE LEN(c.[Crime type]) WHEN 0 THEN NULL ELSE  c.[Crime type] END) 
LEFT OUTER JOIN dbo.Coordinates o ON o.Latitude = (CASE LEN(c.[Latitude]) WHEN 0 THEN NULL ELSE  c.[Latitude] END) AND o.Longitude = (CASE LEN(c.[Longitude]) WHEN 0 THEN NULL ELSE c.[Longitude] END)
LEFT OUTER JOIN dbo.Outcome u ON u.[Last Outcome] = (CASE LEN(c.[Last outcome category]) WHEN 0 THEN NULL ELSE  c.[Last outcome category] END)
GO
