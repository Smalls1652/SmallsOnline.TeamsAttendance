$privateFunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath "functions/private"
$publicFunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath "functions/public"

$privateFunctions = Get-ChildItem -Path $privateFunctionsPath | Where-Object { $PSItem.Extension -eq ".ps1" }
$publicFunctions = Get-ChildItem -Path $publicFunctionsPath | Where-Object { $PSItem.Extension -eq ".ps1" }

foreach ($functionItem in $privateFunctions) {
    . "$($functionItem.FullName)"
}

foreach ($functionItem in $publicFunctions) {
    . "$($functionItem.FullName)"
}