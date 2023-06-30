function Get-ExoTeamsAttendance {
    [CmdletBinding(DefaultParameterSetName = "TimeZoneInfoType")]
    param(
        [Parameter(Position = 0, Mandatory, ParameterSetName = "TimeZoneInfoType")]
        [Parameter(Position = 0, Mandatory, ParameterSetName = "TimeZoneInfoById")]
        [ValidateNotNullOrEmpty()]
        [string]$MeetingOrganizerUpn,
        [Parameter(Position = 1, Mandatory, ParameterSetName = "TimeZoneInfoType")]
        [Parameter(Position = 1, Mandatory, ParameterSetName = "TimeZoneInfoById")]
        [System.DateOnly]$StartDate,
        [Parameter(Position = 2, Mandatory, ParameterSetName = "TimeZoneInfoType")]
        [Parameter(Position = 2, Mandatory, ParameterSetName = "TimeZoneInfoById")]
        [System.DateOnly]$EndDate,
        [Parameter(Position = 3, ParameterSetName = "TimeZoneInfoType")]
        [System.TimeZoneInfo]$TimeZone = [System.TimeZoneInfo]::Local,
        [Parameter(Position = 3, Mandatory, ParameterSetName = "TimeZoneInfoById")]
        [ValidateNotNullOrEmpty()]
        [string]$TimeZoneId
    )

    $timezoneInfo = $null

    if ($PSCmdlet.ParameterSetName -eq "TimeZoneInfoType") {
        $timezoneInfo = $TimeZone
    }
    else {
        try {
            $timezoneInfo = [System.TimeZoneInfo]::FindSystemTimeZoneById($TimeZoneId)
        }
        catch {
            $errorDetails = $PSItem
            $PSCmdlet.ThrowTerminatingError($errorDetails)
        }
    }

    Write-Verbose "Times will be converted from 'UTC' to '$($timezoneInfo.Id)'."

    if (!(Test-ExchangeOnlineModuleConnectivity)) {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                [System.Exception]::new("Could not find 'Search-UnifiedAuditLog' in the current PowerShell session. Either you don't have permissions to run the command or you need to run 'Connect-ExchangeOnline' before running."),
                "NoExchangeOnlineConnectivity",
                [System.Management.Automation.ErrorCategory]::ResourceUnavailable,
                "Search-UnifiedAuditLog"
            )
        )
    }

    if (!(Test-MicrosoftGraphConnectivity)) {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                [System.Exception]::new("Could not find a context for the 'Microsoft.Graph' module. Please run 'Connect-MgGraph' before running."),
                "NoMicrosoftGraphConnectivity",
                [System.Management.Automation.ErrorCategory]::ResourceUnavailable,
                $null
            )
        )
    }
    
    $meetingDetailRecords = Get-ExoMeetingDetailRecords -MeetingOrganizerUpn $MeetingOrganizerUpn -StartDate $StartDate -EndDate $EndDate -TimeZone $timezoneInfo
    $meetingParticipantDetailRecords = Get-ExoMeetingParticipantDetailRecords -MeetingOrganizerUpn $MeetingOrganizerUpn -StartDate $StartDate -EndDate $EndDate -TimeZone $timezoneInfo

    Write-Verbose "Merging collected data."

    foreach ($meetingRecordItem in $meetingDetailRecords) {
        $meetingParticipants = $meetingParticipantDetailRecords | Where-Object { $PSItem.AuditData.MeetingDetailId -eq $meetingRecordItem.Identity }

        $meetingParticipantsEnriched = [System.Collections.Generic.List[SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendee]]::new()
        foreach ($meetingParticipantItem in $meetingParticipants) {
            $userData = $null
            
            try {
                $retrievedUserData = Get-MgUser -UserId $meetingParticipantItem.AuditData.Attendees[0].UserObjectId -ErrorAction "Stop"
                $userData = [SmallsOnline.TeamsAttendance.Lib.Models.UserData]@{
                    "UserId"            = $retrievedUserData.Id;
                    "UserPrincipalName" = $retrievedUserData.UserPrincipalName;
                    "DisplayName"       = $retrievedUserData.DisplayName;
                }   
            }
            catch {
                $userData = [SmallsOnline.TeamsAttendance.Lib.Models.UserData]@{
                    "UserId"            = $meetingParticipantItem.AuditData.Attendees[0].UserObjectId;
                    "UserPrincipalName" = $meetingParticipantItem.AuditData.Attendees[0].UserPrinicpalName;
                    "DisplayName"       = $meetingParticipantItem.AuditData.Attendees[0].DisplayName;
                }
            }
    
            $meetingParticipantsEnriched.Add(
                [SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendee]@{
                    "UserId"            = $userData.UserId;
                    "UserPrincipalName" = $userData.UserPrincipalName;
                    "DisplayName"       = $userData.DisplayName;
                    "JoinTime"          = [System.TimeZoneInfo]::ConvertTimeFromUtc($meetingParticipantItem.AuditData.JoinTime, $timezoneInfo);
                    "LeaveTime"         = [System.TimeZoneInfo]::ConvertTimeFromUtc($meetingParticipantItem.AuditData.LeaveTime, $timezoneInfo);
                }
            )
        }

        [SmallsOnline.TeamsAttendance.Lib.Models.MeetingAttendance]@{
            "CreationTime"         = [System.TimeZoneInfo]::ConvertTimeFromUtc($meetingRecordItem.CreationDate, $timezoneInfo);
            "MeetingId"            = $meetingRecordItem.Identity;
            "UserId"               = $meetingRecordItem.AuditData.UserId;
            "CommunicationType"    = $meetingRecordItem.AuditData.CommunicationType;
            "CommunicationSubType" = $meetingRecordItem.AuditData.CommunicationSubType;
            "StartTime"            = [System.TimeZoneInfo]::ConvertTimeFromUtc($meetingRecordItem.AuditData.StartTime, $timezoneInfo);
            "EndTime"              = [System.TimeZoneInfo]::ConvertTimeFromUtc($meetingRecordItem.AuditData.EndTime, $timezoneInfo);
            "MeetingUrl"           = $meetingRecordItem.AuditData.MeetingURL;
            "Attendees"            = $meetingParticipantsEnriched;
        }
    }
}