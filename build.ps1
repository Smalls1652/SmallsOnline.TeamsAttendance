[CmdletBinding()]
param()

$buildDirPath = Join-Path -Path $PSScriptRoot -ChildPath "build"
$moduleOutDirPath = Join-Path -Path $buildDirPath -ChildPath "SmallsOnline.TeamsAttendance.Pwsh"

if (!(Test-Path -Path $buildDirPath)) {
    $null = New-Item -Path $buildDirPath -ItemType "Directory"
}

if (Test-Path -Path $moduleOutDirPath) {
    Remove-Item -Path $moduleOutDirPath -Force -Recurse
}

$null = New-Item -Path $moduleOutDirPath -ItemType "Directory"

$pwshModulePath = Join-Path -Path $PSScriptRoot -ChildPath "src/Pwsh"

Copy-Item -Path "$($pwshModulePath)/*" -Destination $moduleOutDirPath -Recurse

$classLibPath = Join-Path -Path $PSScriptRoot -ChildPath "src/Lib"
$classLibCompiledPath = Join-Path -Path $classLibPath -ChildPath "bin/Release/net7.0/publish/SmallsOnline.TeamsAttendance.Lib.dll"

dotnet publish "$($classLibPath)" --configuration "Release" --nologo
Copy-Item -Path $classLibCompiledPath -Destination $moduleOutDirPath