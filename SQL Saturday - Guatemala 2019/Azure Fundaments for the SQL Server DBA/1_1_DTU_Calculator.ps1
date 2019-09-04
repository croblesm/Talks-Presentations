<#
    .SYNOPSIS
    Collect counters required for DTU Calculator and log as CSV.

    .DESCRIPTION
    Collect counters required for DTU Calculator and log as CSV. 
    Default log file location is C:\sql-perfmon-log.csv.
    Counters are collected at 1 second intervals for 1 hour or 3600 seconds.
    No support or warranty is supplied or inferred. 
    Use at your own risk.

    .PARAMETER DatabaseName
    The name of the SQL Server database to monitor.

    .INPUTS
    Parameters above.
    
    .OUTPUTS
    None.

    .NOTES
    Version: 1.0
    Creation Date: May 1, 2015
    Modified Date: June 17, 2016
    Author: Justin Henriksen ( http://justinhenriksen.wordpress.com )    
#>

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

cls

Write-Output "Collecting counters..."
Write-Output "Press Ctrl+C to exit."

$counters = @("\Processor(_Total)\% Processor Time", 
"\LogicalDisk(_Total)\Disk Reads/sec", 
"\LogicalDisk(_Total)\Disk Writes/sec", 
"\SQLServer:Databases(_Total)\Log Bytes Flushed/sec") 

Get-Counter -Counter $counters -SampleInterval 1 -MaxSamples 3600 | 
    Export-Counter -FileFormat csv -Path "F:\SQLSaturday - 898 Guatemala\AzureFundamentals\1_1_DTU_Calculator-log.csv" -Force