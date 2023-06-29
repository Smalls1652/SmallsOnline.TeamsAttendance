function Get-ExoMeetingParticipantDetailRecords {
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

    $meetingParticipantDetailProgressSplat = @{
        "Id"       = 0;
        "Activity" = "Getting 'MeetingParticipantDetail' audit entries";
        "Status"   = "Progress->";
    }
    Write-Progress @meetingParticipantDetailProgressSplat -CurrentOperation "Initializing..." -PercentComplete 0

    $meetingParticipantDetailRecords = [System.Collections.Generic.List[SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingParticipantDetailRecord]]::new()

    $meetingParticipantDetailLoopCount = 0;
    for ($currentLoopDate = $StartDate; $currentLoopDate -le $EndDate; $currentLoopDate = $currentLoopDate.AddDays(1)) {
        $meetingParticipantDetailCompletionPercentage = 0
        try {
            $meetingParticipantDetailCompletionPercentage = ($meetingParticipantDetailLoopCount / $totalDays) * 100
        }
        catch {
            $meetingParticipantDetailCompletionPercentage = 0
        }

        Write-Progress @meetingParticipantDetailProgressSplat -CurrentOperation "Getting 'MeetingParticipantDetail' audit entries for '$($currentLoopDate.ToString("yyyy-MM-dd"))'" -PercentComplete $meetingParticipantDetailCompletionPercentage

        $dailyProgressSplat = @{
            "Id"       = 1;
            "Activity" = "$($currentLoopDate.ToString("yyyy-MM-dd"))";
            "Status"   = "Progress->";
            "ParentId" = 0;
        }
        Write-Progress @dailyProgressSplat -CurrentOperation "Initializing..." -PercentComplete 0

        for ($sixHourLoopCount = 0; $sixHourLoopCount -le 3; $sixHourLoopCount++) {
            $dailyCompletionPercent = ($sixHourLoopCount / 3) * 100

            $loopStartDate = [datetime]::Parse("$($currentLoopDate.ToString("yyyy-MM-dd")) 00:00 -4:00").AddHours(6 * $sixHourLoopCount)
            $loopEndDate = $loopStartDate.AddHours(6).AddMinutes(-1)

            Write-Progress @dailyProgressSplat -CurrentOperation "Getting 'MeetingParticipantDetail' audit entries between '$($loopStartDate.ToString("yyyy-MM-dd HH:mm"))' and '$($loopEndDate.ToString("yyyy-MM-dd HH:mm"))'" -PercentComplete $dailyCompletionPercent
            Write-Verbose "Getting 'MeetingParticipantDetail' audit entries between '$($loopStartDate.ToString("yyyy-MM-dd HH:mm"))' and '$($loopEndDate.ToString("yyyy-MM-dd HH:mm"))'"

            $foundMeetingParticipantDetailRecords = Search-UnifiedAuditLog -StartDate $loopStartDate -EndDate $loopEndDate -UserIds $MeetingOrganizerUpn -Operations "MeetingParticipantDetail" -SessionCommand "ReturnLargeSet" -ResultSize 5000

            foreach ($foundRecordItem in $foundMeetingParticipantDetailRecords) {
                $meetingParticipantDetailRecords.Add(
                    [SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingParticipantDetailRecord]@{
                        "CreationDate" = $foundRecordItem.CreationDate;
                        "RecordType"   = $foundRecordItem.RecordType;
                        "Operations"   = $foundRecordItem.Operations;
                        "UserIds"      = $foundRecordItem.UserIds;
                        "Identity"     = $foundRecordItem.Identity;
                        "AuditData"    = [SmallsOnline.TeamsAttendance.Lib.Models.ExchangeOnline.ExoMeetingParticipantDetailAuditData]::FromJson($foundRecordItem.AuditData);
                    }
                )
            }
        }
        Write-Progress @dailyProgressSplat -Completed

        $meetingParticipantDetailLoopCount++
    }
    Write-Progress @meetingParticipantDetailProgressSplat -Completed

    return $meetingParticipantDetailRecords
}