#
# Module manifest for module "SmallsOnline.TeamsAttendance.Pwsh"
#

@{

    RootModule         = "SmallsOnline.TeamsAttendance.Pwsh.psm1"

    ModuleVersion      = "1.0.0"

    # CompatiblePSEditions = @()

    GUID               = "666a4893-5740-4079-9da3-66f6f0842411"

    Author             = "Tim Small"

    CompanyName        = "Smalls.Online"

    Copyright          = "2023"

    Description        = "Last ditch option for retrieving Teams meeting attendance reports."

    PowerShellVersion  = "7.2"

    # PowerShellHostName = ""

    # PowerShellHostVersion = ""

    # DotNetFrameworkVersion = ""

    # ClrVersion = ""

    # ProcessorArchitecture = ""

    RequiredModules    = @(
        @{
            "ModuleName"    = "Microsoft.Graph.Authentication";
            "ModuleVersion" = "1.28.0";
        },
        @{
            "ModuleName"    = "Microsoft.Graph.Users";
            "ModuleVersion" = "1.28.0";
        },
        @{
            "ModuleName"    = "ExchangeOnlineManagement";
            "ModuleVersion" = "3.2.0";
        },
        @{
            "ModuleName"    = "ImportExcel";
            "ModuleVersion" = "7.8.5";
        }
    )

    RequiredAssemblies = @(
        "SmallsOnline.TeamsAttendance.Lib.dll"
    )

    # ScriptsToProcess = @()

    # TypesToProcess = @()

    # FormatsToProcess = @()

    # NestedModules = @()

    FunctionsToExport  = @(
        "Get-ExoTeamsAttendance",
        "Export-ExoTeamsAttendance"
    )

    CmdletsToExport    = @()

    VariablesToExport  = @()

    AliasesToExport    = @()

    # DscResourcesToExport = @()

    # ModuleList = @()

    FileList           = @(
        "SmallsOnline.TeamsAttendance.Pwsh.psd1",
        "SmallsOnline.TeamsAttendance.Pwsh.psm1",
        "SmallsOnline.TeamsAttendance.Lib.dll",
        "./functions/private/Get-ExoMeetingDetailRecords.ps1",
        "./functions/private/Get-ExoMeetingParticipantDetailRecords.ps1",
        "./functions/private/Test-ExchangeOnlineModuleConnectivity.ps1",
        "./functions/private/Test-MicrosoftGraphConnectivity.ps1",
        "./functions/public/Get-ExoTeamsAttendance.ps1"
    )

    PrivateData        = @{

        PSData = @{

            # Tags = @()
            LicenseUri = "https://raw.githubusercontent.com/Smalls1652/SmallsOnline.TeamsAttendance/main/LICENSE"
            RequireLicenseAcceptance = $false
            ProjectUri = "https://github.com/Smalls1652/SmallsOnline.TeamsAttendance"
            # IconUri = ""
            # ReleaseNotes = ""
            # Prerelease = ""
            # ExternalModuleDependencies = @()

        } 

    }
    # HelpInfoURI = ""
    # DefaultCommandPrefix = ""

}

