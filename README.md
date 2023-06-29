# Teams Attendance Reports

You may be asking yourself... Can't you already get attendance reports natively through Teams? [Yes. Yes you can.](https://support.microsoft.com/en-us/office/manage-meeting-attendance-reports-in-teams-ae7cf170-530c-47d3-84c1-3aedac74d310) So what's the point of this? Well... There are unique use cases and is meant to be a **last ditch option**. In my case:

* It's been well past the meeting dates and the attendance reports are no longer available to download.
* The data in the attendance report that's available isn't showing the whole meeting because the meeting had a new session of the meeting start.
* The instructor may have forgotten to get the attendance report and they're not around, at the time, when it needs to be submitted for audit/accreditation reasons.

## How does it work?

It's _best guess_ and it doesn't correlate a meeting to a specific class; however, it can get **all** of the meetings a user organized and get their respective attendees with their join and leave times.

It utilizes `Search-UnifiedAuditLog` in the `ExchangeOnlineManagement` PowerShell module to get all `MeetingDetail` and `MeetingParticipantDetail` entries from your tenant's [Microsoft 365 Unified Audit Log](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-log-search?view=o365-worldwide)... Provided you have [the necessary license to use it](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-solutions-overview?view=o365-worldwide#audit-standard-1) and your user account has the [correct permissions to search the audit log](https://learn.microsoft.com/en-us/microsoft-365/compliance/audit-standard-setup?view=o365-worldwide#step-2-assign-permissions-to-search-the-audit-log).

## Requirements

> ⚠️ **Note:**
>  
> I don't have a pre-packaged version of the module yet. I should have that out fairly soon.

* [PowerShell 7.3](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3)
	* That means no Windows PowerShell 5.1 support.
* [`ExchangeOnlineManagement` v3.2.0 and higher](https://www.powershellgallery.com/packages/ExchangeOnlineManagement/3.2.0)
* [`Microsoft.Graph` v1.2.8 and higher](https://www.powershellgallery.com/packages/Microsoft.Graph/1.28.0)
	* I have **not** tested this against the preview/release candidate releases of the upcoming v2.0.0 release.
	* If you don't want to install the meta module, v1.2.8 of [`Microsoft.Graph.Authentication`](https://www.powershellgallery.com/packages/Microsoft.Graph.Authentication/1.28.0) and [`Microsoft.Graph.Users`](https://www.powershellgallery.com/packages/Microsoft.Graph.Users/1.28.0) are the exact requirements.
* [`ImportExcel` v7.8.5 or higher](https://www.powershellgallery.com/packages/ImportExcel/7.8.5)
