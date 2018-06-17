# download binaries
$url = "http://aka.ms/WACDownload"
$output = "$PSScriptRoot\WindowsAdminCenter.msi"

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)

# install software
msiexec /i WindowsAdminCenter.msi /qn /L*v log.txt SME_PORT=443 SSL_CERTIFICATE_OPTION=generate