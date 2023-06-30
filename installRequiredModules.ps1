[CmdletBinding()]
param()

<#

    NOTE:
    
    This is only meant to be run in CI/CD!

#>

$modulesNeeded = @(
    [pscustomobject]@{
        "ModuleName"    = "Microsoft.Graph.Authentication";
        "ModuleVersion" = "1.28.0";
    },
    [pscustomobject]@{
        "ModuleName"    = "Microsoft.Graph.Users";
        "ModuleVersion" = "1.28.0";
    },
    [pscustomobject]@{
        "ModuleName"    = "ExchangeOnlineManagement";
        "ModuleVersion" = "3.2.0";
    },
    [pscustomobject]@{
        "ModuleName"    = "ImportExcel";
        "ModuleVersion" = "7.8.5";
    }
)

foreach ($moduleItem in $modulesNeeded) {
    Write-Information -InformationAction "Continue" -MessageData "- Installing $($moduleItem.ModuleName) v$($moduleItem.ModuleVersion)"
    Install-Module -Name $moduleItem.ModuleName -RequiredVersion $moduleItem.ModuleVersion -Force
}