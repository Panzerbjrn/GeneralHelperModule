Function Add-ToPath
{

$oldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$newPath=$oldPath+';D:\Dropbox\Scripts;D:\Dropbox\Scripts\Scripts.Mine\Powershell;D:\Dropbox\Scripts\Scripts.Mine\Batchfiles;'
#$newPath=$oldPath+';C:\Users\LarsPetersson\Dropbox\Scripts\Scripts.Mine\Batchfiles'
#$newPath=$oldPath+';C:\Users\Lars\Dropbox\Scripts\Scripts.Mine\Batchfiles'
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

}