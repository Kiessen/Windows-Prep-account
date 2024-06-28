$ServerPath = "\\192.168.222.222\Share\FirstApp\*"
#$DestinationFolder = "C:\Users\PejabaTinggi\Downloads\TempInstaller"
#$DestinationFolder = "C:\Users\Uangme\Downloads\TempInstall"
$dingtalk= 'https://www.dingtalk.com/win/d/qd=20170420173511985?spm=a3140.10045796.845299.4.327224bfPllieU'
$arr_Uriapp= 
#'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi'<#Chrome#>,
#'https://www.microsip.org/download/MicroSIP-3.21.3.exe'<#MicroSIP#>,
#'https://download.anydesk.com/AnyDesk.exe'<#AnyDesk#>,
#'https://dl2.ultraviewer.net/UltraViewer_setup_6.6_en.exe'<#AnyDesk#>,
#'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/onlinesetup/distsrc/600.1021/wpsinst/wps_office_inst.exe'<#WPS#>
#mkdir $DestinationFolder
#cd $DestinationFolder
function download_App {
   foreach ($item in $arr_Uriapp)
			{
			Start-BitsTransfer -Source $item -Destination $DestinationFolder
			}
Invoke-WebRequest -Uri $dingtalk -OutFile "Dingtalk.exe"
Invoke-Expression 'ls $DestinationFolder'
}

function copy_App{
Copy-Item -Path $ServerPath -Destination $DestinationFolder
}

function install_App {
$count = Get-ChildItem -Name
foreach ($item in $count){
	Start-Process -FilePath $item -Argument "/VERYSILENT /S /v /qn" -PassThru
}
}

#download_App
#copy_App
install_App
