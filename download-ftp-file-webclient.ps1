[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url= 'ftp://<domain.com>/', "file.csv" -join ""

$file = "C:\Users\test\Downloads\file.csv"

$user = "user"
$pwd = Microsoft.PowerShell.Security\ConvertTo-SecureString -String "password" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $user, $pwd  
$creds.GetNetworkCredential().Password.GetType()

$webclient = New-Object System.Net.WebClient
$uri = New-Object System.Uri($url)
   
$webclient.Credentials = new-object System.Net.NetworkCredential($user, $creds.GetNetworkCredential().Password)
$webclient.DownloadFile($uri,$file)
