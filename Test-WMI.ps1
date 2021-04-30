# Test WMI connection

param (
    [string] $ComputerName = 'localhost'
)

$Version = '0.6'
Write-Verbose -Message ("Test-WMI version: $Version")

try {
    $Scope = [System.Management.ManagementScope]::new("\\$ComputerName\root\cimv2")
    $Scope.Connect()
    return $true
}
catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
    return $false
}

