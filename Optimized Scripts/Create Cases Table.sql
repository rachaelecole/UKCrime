Use UKCRIME

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
c.[Crime ID],d.DateID,p.PoliceID,ls.LSOAID,l.LocationID,o.CoordinateID,t.CrimeTypeID,u.OutcomeID
FROM dbo.Crime c
LEFT OUTER JOIN dbo.Police p ON p.ReportedBy = (CASE LEN(c.[Reported by]) WHEN 0 THEN NULL ELSE  c.[Reported By] END) AND p.FallsWithin = (CASE LEN(c.[Falls within]) WHEN 0 THEN NULL ELSE c.[Falls within] END)
LEFT OUTER JOIN dbo.[Date] d ON d.[Month] = (CASE LEN(c.[Month]) WHEN 0 THEN NULL ELSE RIGHT(c.[Month],2) END) AND d.[Year] = (CASE LEN(c.[Month]) WHEN 0 THEN NULL ELSE LEFT(c.[Month],4) END) 
LEFT OUTER JOIN dbo.Location l ON l.Location = (CASE LEN(c.[Location]) WHEN 0 THEN NULL ELSE  substring(c.Location,12,len(c.location)) END) 
LEFT OUTER JOIN dbo.LSOA ls ON ls.LSOACode = (CASE LEN(c.[LSOA code]) WHEN 0 THEN NULL ELSE  c.[LSOA code] END) 
LEFT OUTER JOIN dbo.CrimeType t ON t.CrimeType = (CASE LEN(c.[Crime type]) WHEN 0 THEN NULL ELSE  c.[Crime type] END) 
LEFT OUTER JOIN dbo.Coordinates o ON o.Latitude = (CASE LEN(c.[Latitude]) WHEN 0 THEN NULL ELSE  c.[Latitude] END) AND o.Longitude = (CASE LEN(c.[Longitude]) WHEN 0 THEN NULL ELSE c.[Longitude] END)
LEFT OUTER JOIN dbo.Outcome u ON u.[Last Outcome] = (CASE LEN(c.[Last outcome category]) WHEN 0 THEN NULL ELSE  c.[Last outcome category] END)

--DROP TABLE dbo.cases

--SELect * from dbo.cases