<#---------------------------------------------------------------------------- 
LEGAL DISCLAIMER  The sample scripts are not supported under any Microsoft standard support program or service. The sample scripts are provided AS IS without warranty of any kind. Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.

This posting is provided "AS IS" with no warranties, and confers no rights.   Author: Clint Oliveira
Website: https://O365Inside.com
Version 1.0 -Initial Release -Thanks to all of the Script Center commenters for feedback! ---------------------------------------------------------------------------- #>

$Title = "Detailed License Report"
$Info = "O365Inside.com By: Clint Oliveira"
 
$options = [System.Management.Automation.Host.ChoiceDescription[]] @("&All Users", "&Select Users", "&Quit")
[int]$defaultchoice = 0
$opt = $host.UI.PromptForChoice($Title , $Info, $Options, $defaultchoice)
switch($opt)
{
0 { Write-Host "All Users" -ForegroundColor Green
$OutputFile = Read-Host "Where would you like the file exported eg. c:\users\clint.oliveira\desktop\DetailedUserLicenses.csv"
Out-File -FilePath $OutputFile -InputObject "Users_UserPrincipalName, AccountSkuId, ServicePlan, ServiceStatus, GroupsAssigningLicense" -Encoding  UTF8 
$users = get-msoluser -All | Where-Object { $_.isLicensed -eq "TRUE" }

$users | foreach{
$user = Get-MsolUser -UserPrincipalName $_.userprincipalname
$Licenses = ($user).licenses
write-host "The User  $($user.UserPrincipalName) has $($Licenses.count) license Packs" -ForegroundColor Cyan
foreach ($license in $Licenses)
{
write-host "Processing  $($license.accountskuid)..." -ForegroundColor Green
$AccountSkuId = ($license).accountskuid
$GroupsAssigningLicense = ($License).GroupsAssigningLicense
$servicestatuses = $license.ServiceStatus
$Plans = ($license).ServiceStatus.serviceplan.ServiceName
$statuses = ($license).ServiceStatus.ProvisioningStatus
Foreach($servicestatus in $servicestatuses)
{
$plan=$servicestatus.ServicePlan.ServiceName
$status= $servicestatus.ProvisioningStatus
Out-File -FilePath $OutputFile -InputObject "$($user.UserPrincipalName),$($AccountSkuId),$($Plan),$($status),$($GroupsAssigningLicense)" -Encoding UTF8 -append 
write-host "`t$($user.UserPrincipalName),$($AccountSkuId),"$($Plan)",$($status),$($GroupsAssigningLicense)" 
}
}
}

}
1 { Write-Host "Select Users" -ForegroundColor Green
$InputFile = Read-Host "Enter the file path of the list of users eg. c:\users\clint.oliveira\desktop\UserList.csv"
$OutputFile = Read-Host "Where would you like the file exported eg. c:\users\clint.oliveira\desktop\DetailedUserLicenses.csv"
Out-File -FilePath $OutputFile -InputObject "Users_UserPrincipalName, AccountSkuId, ServicePlan, ServiceStatus, GroupsAssigningLicense" -Encoding  UTF8 
$csv = import-csv $InputFile

$csv | foreach{
$user = Get-MsolUser -UserPrincipalName $_.userprincipalname
$Licenses = ($user).licenses
write-host "The User  $($user.UserPrincipalName) has $($Licenses.count) license Packs" -ForegroundColor Cyan
foreach ($license in $Licenses)
{
write-host "Processing  $($license.accountskuid)..." -ForegroundColor Green
$AccountSkuId = ($license).accountskuid
$GroupsAssigningLicense = ($License).GroupsAssigningLicense
$servicestatuses = $license.ServiceStatus
$Plans = ($license).ServiceStatus.serviceplan.ServiceName
$statuses = ($license).ServiceStatus.ProvisioningStatus
Foreach($servicestatus in $servicestatuses)
{
$plan=$servicestatus.ServicePlan.ServiceName
$status= $servicestatus.ProvisioningStatus
Out-File -FilePath $OutputFile -InputObject "$($user.UserPrincipalName),$($AccountSkuId),$($Plan),$($status),$($GroupsAssigningLicense)" -Encoding UTF8 -append 
write-host "`t$($user.UserPrincipalName),$($AccountSkuId),"$($Plan)",$($status),$($GroupsAssigningLicense)" 
}
}
}
}
2 { Write-Host "Good Bye!!!" -ForegroundColor Green
	}
}