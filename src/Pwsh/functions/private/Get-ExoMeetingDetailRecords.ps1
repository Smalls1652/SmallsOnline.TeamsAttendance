function Get-ExoMeetingDetailRecords {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$MeetingOrganizerUpn,
        [Parameter(Position = 1, Mandatory)]
        [System.DateOnly]$StartDate,
        [Parameter(Position = 2, Mandatory)]
        [System.DateOnly]$EndDate
    )

    $meetingDetailProgressSplat = @{
        "Id"       = 0;
        "Activity" = "Getting 'MeetingDetail' audit entries";
        "Status"   = "Progress->";
    }
    Write-Progress @meetingDetailProgressSplat -CurrentOperation "Initializing..." -PercentComplete 0
    
    $meetingDetailRecords = [System.Collections.Generic.List[SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingDetailRecord]]::new()

    $totalDays = $EndDate.DayNumber - $StartDate.DayNumber

    $meetingDetailLoopCount = 0;
    for ($currentLoopDate = $StartDate; $currentLoopDate -le $EndDate; $currentLoopDate = $currentLoopDate.AddDays(1)) {
        $meetingDetailCompletionPercentage = 0
        try {
            $meetingDetailCompletionPercentage = ($meetingDetailLoopCount / $totalDays) * 100
        }
        catch {
            $meetingDetailCompletionPercentage = 0
        }

        $loopStartDate = [datetime]::Parse("$($currentLoopDate.ToString("yyyy-MM-dd")) 00:00 -4:00")
        $loopEndDate = [datetime]::Parse("$($currentLoopDate.ToString("yyyy-MM-dd")) 23:59 -4:00")

        Write-Progress @meetingDetailProgressSplat -CurrentOperation "Getting audit entries for '$($currentLoopDate.ToString("yyyy-MM-dd"))'" -PercentComplete $meetingDetailCompletionPercentage
        Write-Verbose "Getting audit entries between '$($loopStartDate.ToString("yyyy-MM-dd HH:mm"))' and '$($loopEndDate.ToString("yyyy-MM-dd HH:mm"))'."

        $foundMeetingDetailRecords = Search-UnifiedAuditLog -StartDate $loopStartDate -EndDate $loopEndDate -UserIds $MeetingOrganizerUpn -Operations "MeetingDetail" -ResultSize 5000

        $foundMeetingDetailRecordsCount = ($foundMeetingDetailRecords | Measure-Object).Count
        Write-Verbose "Found $($foundMeetingDetailRecordsCount) 'MeetingDetail' entries for '$($currentLoopDate.ToString("yyyy-MM-dd"))'."

        foreach ($foundRecordItem in $foundMeetingDetailRecords) {
            $meetingDetailRecords.Add(
                [SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingDetailRecord]@{
                    "CreationDate" = $foundRecordItem.CreationDate;
                    "RecordType"   = $foundRecordItem.RecordType;
                    "Operations"   = $foundRecordItem.Operations;
                    "UserIds"      = $foundRecordItem.UserIds;
                    "Identity"     = $foundRecordItem.Identity;
                    "AuditData"    = [SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingDetailAuditData]::FromJson($foundRecordItem.AuditData);
                }
            )
        }

        $meetingDetailLoopCount++
    }

    Write-Progress @meetingDetailProgressSplat -Completed

    return $meetingDetailRecords
}