---
external help file: SmallsOnline.TeamsAttendance.Pwsh-help.xml
Module Name: SmallsOnline.TeamsAttendance.Pwsh
online version:
schema: 2.0.0
---

# Export-ExoTeamsAttendance

## SYNOPSIS
Export gathered Teams attendance reports.

## SYNTAX

```
Export-ExoTeamsAttendance [-MeetingAttendanceItem] <MeetingAttendance[]> [[-OutputDirectory] <String>] [-AsCsv]
 [<CommonParameters>]
```

## DESCRIPTION
Export Teams attendance reports collected with `Get-ExoTeamsAttendance` to CSV or XLSX files.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-ExchangeOnline
PS C:\> Connect-MgGraph
PS C:\> $meetingRecords = Get-ExoTeamsAttendance -MeetingOrganizerUpn "jwinger1@greendalecc.edu" -StartDate "2023-06-01" -EndDate "2023-06-10"
PS C:\> $meetingRecords | Export-ExoTeamsAttendance -OutputDirectory ".\jwinger1-meetings\"
```

Get the meetings organized by 'jwinger1@greendalecc.edu' and the attendees of the meetings between 2023-06-01 to 2023-06-10.
Then export the reports to the directory `.\jwinger1-meetings\` as XLSX files.

### Example 2
```powershell
PS C:\> Connect-ExchangeOnline
PS C:\> Connect-MgGraph
PS C:\> $meetingRecords = Get-ExoTeamsAttendance -MeetingOrganizerUpn "jwinger1@greendalecc.edu" -StartDate "2023-06-01" -EndDate "2023-06-10"
PS C:\> $meetingRecords | Export-ExoTeamsAttendance -OutputDirectory ".\jwinger1-meetings\" -AsCsv
```

Get the meetings organized by 'jwinger1@greendalecc.edu' and the attendees of the meetings between 2023-06-01 to 2023-06-10.
Then export the reports to the directory `.\jwinger1-meetings\` as CSV files.

## PARAMETERS

### -AsCsv
Export the reports as CSV files instead of XLSX files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MeetingAttendanceItem
Meeting attendance items returned from `Get-ExoTeamsAttendance`.

```yaml
Type: MeetingAttendance[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -OutputDirectory
The directory to output the files to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendance[]

## OUTPUTS

## NOTES

## RELATED LINKS
