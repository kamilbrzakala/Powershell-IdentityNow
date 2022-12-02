Function Get-List-FTP-Files {

    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$folder
    )

    $username  = (Get-Config).ftp_user
    $password  = (Get-Config).ftp_password
    $ftp       = (Get-Config).ftp_address
    $subfolder = '/other/', $folder, 'Input' -join "/"
    $ftpuri = $ftp + $subfolder
    $uri=[system.URI] $ftpuri

    $ftprequest=[system.net.ftpwebrequest]::Create($uri)
    $ftprequest.Credentials=New-Object System.Net.NetworkCredential($username,$password)
    #$ftprequest.Method=[system.net.WebRequestMethods+ftp]::ListDirectory
    $ftprequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
    $response=$ftprequest.GetResponse()
    $strm=$response.GetResponseStream()
    $reader=New-Object System.IO.StreamReader($strm,'UTF-8')
    $list=$reader.ReadToEnd()

    $li=$list.Split("`n")
    $li = $li[1..($li.length - 2)] # ignore 1st index from array because is not needed

    $arrayList = @()

    foreach($item in $li){
        
        if($item){
            $left = $item[0..48] -join ""
            $right = $item[49..($item.length - 1)] -join ""
            [string]$dateModified = ($right[0..12] -join "").trim()
            [string]$fileName = $right[13..($item.length - 1)] -join ""

            $arrayList += [PSCustomObject]@{
                source = $folder
                fileName = $fileName
                filePath = $folder, "Input/", $fileName -join "/"
                dateModified = $dateModified
            }
        }
    }

    $orderedArray = $arrayList | Sort-Object -Property dateModified -Descending # get latest file

    return $orderedArray[0]
}
