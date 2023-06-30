---
external help file: SmallsOnline.TeamsAttendance.Pwsh-help.xml
Module Name: SmallsOnline.TeamsAttendance.Pwsh
online version:
schema: 2.0.0
---

# Get-ExoTeamsAttendance

## SYNOPSIS
Get Teams meeting attendance records from audit logs.

## SYNTAX

### TimeZoneInfoType (Default)
```
Get-ExoTeamsAttendance [-MeetingOrganizerUpn] <String> [-StartDate] <DateOnly> [-EndDate] <DateOnly>
 [[-TimeZone] <TimeZoneInfo>] [<CommonParameters>]
```

### TimeZoneInfoById
```
Get-ExoTeamsAttendance [-MeetingOrganizerUpn] <String> [-StartDate] <DateOnly> [-EndDate] <DateOnly>
 [-TimeZoneId] <String> [<CommonParameters>]
```

## DESCRIPTION
Get Teams meeting attendance records based off of audit log entries in Microsoft 365's "Unified Audit Log".

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Connect-ExchangeOnline
PS C:\> Connect-MgGraph
PS C:\> Get-ExoTeamsAttendance -MeetingOrganizerUpn "jwinger1@greendalecc.edu" -StartDate "2023-06-01" -EndDate "2023-06-10"
```

Get the meetings organized by 'jwinger1@greendalecc.edu' and the attendees of the meetings between 2023-06-01 to 2023-06-10.
Meeting join/leave times will be converted to the local system's timezone.

### EXAMPLE 2
```powershell
PS C:\> Connect-ExchangeOnline
PS C:\> Connect-MgGraph
PS C:\> Get-ExoTeamsAttendance -MeetingOrganizerUpn "jwinger1@greendalecc.edu" -StartDate "2023-06-01" -EndDate "2023-06-10" -TimeZoneId "Pacific Standard Time"
```

Get the meetings organized by 'jwinger1@greendalecc.edu' and the attendees of the meetings between 2023-06-01 to 2023-06-10.
Meeting join/leave times will be converted to 'Pacific Standard Time'.

## PARAMETERS

### -MeetingOrganizerUpn
The UserPrincipalName of the user who organized the meetings.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
The start date for the search.

```yaml
Type: DateOnly
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
The end date for the search.

```yaml
Type: DateOnly
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZone
The TimeZoneInfo object to convert the output times to.
Defaults to your local system's timezone.

```yaml
Type: TimeZoneInfo
Parameter Sets: TimeZoneInfoType
Aliases:

Required: False
Position: 4
Default value: [System.TimeZoneInfo]::Local
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZoneId
The ID of the timezone to convert the output times to.

```yaml
Type: String
Parameter Sets: TimeZoneInfoById
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendance[]
## NOTES
You will need to run 'Connect-ExchangeOnline' and 'Connect-MgGraph' before running this command, otherwise it will immediately throw an error.

## RELATED LINKS
