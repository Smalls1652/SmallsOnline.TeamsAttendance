[CmdletBinding()]
param()

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

$buildDirPath = Join-Path -Path $PSScriptRoot -ChildPath "build"
$moduleOutDirPath = Join-Path -Path $buildDirPath -ChildPath "SmallsOnline.TeamsAttendance.Pwsh"

if (!(Test-Path -Path $buildDirPath)) {
    Write-ConsoleLog -Message "- Creating build directory at '$($buildDirPath)'."
    $null = New-Item -Path $buildDirPath -ItemType "Directory"
}

if (Test-Path -Path $moduleOutDirPath) {
    Write-ConsoleLog -Message "- Removing previous build."
    Remove-Item -Path $moduleOutDirPath -Force -Recurse
}

$null = New-Item -Path $moduleOutDirPath -ItemType "Directory"

$pwshModulePath = Join-Path -Path $PSScriptRoot -ChildPath "src/Pwsh"

Write-ConsoleLog -Message "- Copying PowerShell module files from '$($pwshModulePath)' -> '$($moduleOutDirPath)'."
Copy-Item -Path "$($pwshModulePath)/*" -Destination $moduleOutDirPath -Recurse

Write-ConsoleLog -Message "- Building class library.`n"
$classLibPath = Join-Path -Path $PSScriptRoot -ChildPath "src/Lib"
$classLibCompiledPath = Join-Path -Path $classLibPath -ChildPath "bin/Release/net7.0/publish/SmallsOnline.TeamsAttendance.Lib.dll"

dotnet publish "$($classLibPath)" --configuration "Release" --nologo
Copy-Item -Path $classLibCompiledPath -Destination $moduleOutDirPath

Write-ConsoleLog -Message "`n- Building help files."
$docsDirPath = Join-Path -Path $PSScriptRoot -ChildPath "docs"
$docsDirectories = Get-ChildItem -Path $docsDirPath

foreach ($docsLanguageItem in $docsDirectories) {
    Write-ConsoleLog -Message "`t- Building for language '$($docsLanguageItem.BaseName)'."
    $docsOutPath = Join-Path -Path $moduleOutDirPath -ChildPath $docsLanguageItem.BaseName

    $null = New-ExternalHelp -Path $docsLanguageItem.FullName -OutputPath $docsOutPath
}

Write-ConsoleLog -Message "- Build complete."