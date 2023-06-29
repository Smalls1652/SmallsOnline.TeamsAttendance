function Test-ExchangeOnlineModuleConnectivity {
    [CmdletBinding()]
    param()

    Write-Verbose "Testing for 'ExchangeOnline' connectivity."
    $importedCommands = Get-Command -ListImported -Verbose:$false

    $searchUnifiedAuditLogCommandFound = "Search-UnifiedAuditLog" -in $importedCommands.Name

    return $searchUnifiedAuditLogCommandFound
}