function Test-MicrosoftGraphConnectivity {
    [CmdletBinding()]
    param()

    Write-Verbose "Testing for 'Microsoft.Graph' connectivity."
    $mgContext = Get-MgContext -Verbose:$false

    if ($null -eq $mgContext) {
        return $false
    }
    else {
        return $true
    }
}