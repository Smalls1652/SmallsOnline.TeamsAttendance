[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ModuleOutDirPath
)

function Write-ConsoleLog {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)]
        [string]$Message
    )

    $writeInfoSplat = @{
        "InformationAction" = "Continue";
    }

    Write-Information @writeInfoSplat -MessageData $Message
}

$docsDirPath = Join-Path -Path $PSScriptRoot -ChildPath "docs"
$docsDirectories = Get-ChildItem -Path $docsDirPath

foreach ($docsLanguageItem in $docsDirectories) {
    Write-ConsoleLog -Message "`t- Building for language '$($docsLanguageItem.BaseName)'."
    $docsOutPath = Join-Path -Path $ModuleOutDirPath -ChildPath $docsLanguageItem.BaseName

    $null = New-ExternalHelp -Path $docsLanguageItem.FullName -OutputPath $docsOutPath
}