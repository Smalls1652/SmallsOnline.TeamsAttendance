function Export-ExoTeamsAttendance {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendance[]]$MeetingAttendanceItem,
        [Parameter(Position = 1)]
        [string]$OutputDirectory = "./",
        [Parameter(Position = 2)]
        [switch]$AsCsv
    )

    begin {
        $outputDirResolvedPath = (Resolve-Path -Path $OutputDirectory -ErrorAction "Stop").Path

        if ([System.IO.FileAttributes]::Directory -notin (Get-Item -Path $outputDirResolvedPath).Attributes) {
            $PSCmdlet.ThrowTerminatingError(
                [System.Management.Automation.ErrorRecord]::new(
                    [System.IO.IOException]::new("The provided path, '$($outputDirResolvedPath)' is not a directory."),
                    "InvalidOutputDirectory",
                    [System.Management.Automation.ErrorCategory]::InvalidOperation,
                    $outputDirResolvedPath
                )
            )
        }
    }

    process {
        foreach ($meetingItem in $MeetingAttendanceItem) {
            $formattedAttendeeItems = foreach ($attendeeItem in ($meetingItem.Attendees | Sort-Object -Property "JoinTime")) {
                [pscustomobject]@{
                    "UserId"            = $attendeeItem.UserId;
                    "UserPrincipalName" = $attendeeItem.UserPrincipalName;
                    "DisplayName"       = $attendeeItem.DisplayName;
                    "JoinTime"          = $attendeeItem.JoinTime.ToString("MM/dd/yyyy hh:mm tt");
                    "LeaveTime"         = $attendeeItem.LeaveTime.ToString("MM/dd/yyyy hh:mm tt")
                }
            }

            $usernameRegex = [regex]::new("^(?'username'.+?)@.+$")
            $usernameRegexMatch = $usernameRegex.Match($meetingItem.UserId)
            $meetingOrganizerUsername = $usernameRegexMatch.Groups["username"].Value

            if ($AsCsv) {
                $outputFilePath = Join-Path -Path $outputDirResolvedPath -ChildPath "$($meetingOrganizerUsername)_$($meetingItem.StartTime.ToString("yyyy-MM-dd_HH-mm")).csv"
                $formattedAttendeeItems | Export-Csv -Path $outputFilePath
            }
            else {
                $outputFilePath = Join-Path -Path $outputDirResolvedPath -ChildPath "$($meetingOrganizerUsername)_$($meetingItem.StartTime.ToString("yyyy-MM-dd_HH-mm")).xlsx"
                $formattedAttendeeItems | Export-Excel -Path $outputFilePath -AutoSize -TableName "AttendanceTbl" -TableStyle "medium2"
            }
        }
    }
}