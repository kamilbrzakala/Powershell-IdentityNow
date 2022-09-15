Function Get-ListOfFiles {

    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$folder
    )

    $username  = Get-Config | ForEach-Object {$_.ftp_user}
    $password  = Get-Config | ForEach-Object {$_.ftp_password}
    $ftp       = Get-Config | ForEach-Object {$_.ftp_address}
    $subfolder = '/otherfolder/'

    $ftpuri = $ftp + $subfolder
    $uri=[system.URI] $ftpuri
    $ftprequest=[system.net.ftpwebrequest]::Create($uri)
    $ftprequest.Credentials=New-Object System.Net.NetworkCredential($username,$password)
    $ftprequest.Method=[system.net.WebRequestMethods+ftp]::ListDirectory
    $response=$ftprequest.GetResponse()
    $strm=$response.GetResponseStream()
    $reader=New-Object System.IO.StreamReader($strm,'UTF-8')
    $list=$reader.ReadToEnd()
    $lines=$list.Split("`n")
    return $lines

}
