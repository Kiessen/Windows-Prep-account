$ipShare = <Server IP>
$netAccount= <Username Server>
$netPass= <Pass Server>
$uname1 = <Username Account1>
$uname2 = <Username Account2>
$pass1 = <Pass Account 1>
$pass2 = <Pass Account 2>
$DestinationFolder = "$env:USERPROFILE\Downloads\TempInstall"
$checkTemp = Get-LocalUser |Where {@($uname1,$uname2) -contains $_.Name}

function shareCopy {
net use \\$ipShare\ /user:$netAccount $netPass
mkdir $DestinationFolder
Copy-Item -Path "\\$ipShare\Share\FirstApp\*" -Destination $DestinationFolder
reg add HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\AllowBluetooth /v value /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t REG_DWORD /d 4 /f
}

function disBlusb{
reg add HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\AllowBluetooth /v value /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\USBSTOR /v Start /t REG_DWORD /d 4 /f
}


if ($checkTemp.Name -notcontains $uname1){
New-LocalUser -Name $uname1 -Password ConvertTo-SecureString $pass2 -AsPlainText -Force
Add-LocalGroupMember -Group "Administrators" -Member $uname1
}
elif($checkTemp.Name -notcontains $uname2){
New-LocalUser -Name $uname2 -Password ConvertTo-SecureString $pass1 -AsPlainText -Force
Add-LocalGroupMember -Group "Users" -Member $uname2
}
else {
Get-LocalUser |Where { $_.Enabled -Match "True" -and @($uname1,$uname2) -notcontains $_.Name}| disable-localuser
}

shareCopy
disBlusb