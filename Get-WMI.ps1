# Get WMI class by dotNET for newer PowerShell compatibility

param (
    [string] $ComputerName = 'localhost',
    [string] $Class = 'win32_OperatingSystem',
    [int] $TimeOut = 10
)

$Version = '0.6'
Write-Verbose -Message ("Get-WMI version: $Version")

[string] $Query = "SELECT * FROM $Class"

try {
    $Scope = [System.Management.ManagementScope]::new("\\$ComputerName\root\cimv2", [System.Management.ConnectionOptions]::new())
    $Scope.Connect()
    $EnumerationOptions = [System.Management.EnumerationOptions]::new()
    $EnumerationOptions.Timeout = [timespan]::FromSeconds($TimeOut)
    $ObjectSearcher = [System.Management.ManagementObjectSearcher]::new($Scope, $Query, $EnumerationOptions)
    $ObjectSearcher.Get()
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}

