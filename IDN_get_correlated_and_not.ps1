cls

function get-accounts(){
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$token,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$cloudExternalId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$env
    )
    $limit = 250
    $array = @()
    # get cloudextid
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Mobile Safari/537.36 Edg/108.0.1462.42"
    $data = (Invoke-WebRequest -UseBasicParsing -Uri "https://$($env).api.identitynow.com/cc/api/source/getAccounts/?_dc=1674250434665&id=$($cloudExternalId)&start=0&limit=$($limit)&sort=%5B%7B%22property%22%3A%22identityName%22%2C%22direction%22%3A%22ASC%22%7D%5D" `
    -WebSession $session `
    -Headers @{
    "authority"="xxxxx.api.identitynow.com"
      "method"="GET"
      "path"="/cc/api/source/getAccounts/?_dc=1674250434665&id=$($cloudExternalId)&start=0&limit=$($limit)&sort=%5B%7B%22property%22%3A%22identityName%22%2C%22direction%22%3A%22ASC%22%7D%5D"
      "scheme"="https"
      "accept"="*/*"
      "accept-encoding"="gzip, deflate, br"
      "accept-language"="en-US,en;q=0.9,pl;q=0.8"
      "authorization"="Bearer $($token)"
      "origin"="https://xxxx.identitynow.com"
      "sec-ch-ua"="`"Not?A_Brand`";v=`"8`", `"Chromium`";v=`"108`", `"Microsoft Edge`";v=`"108`""
      "sec-ch-ua-mobile"="?1"
      "sec-ch-ua-platform"="`"Android`""
      "sec-fetch-dest"="empty"
      "sec-fetch-mode"="cors"
      "sec-fetch-site"="same-site"
      "slpt-origin"="ui:ext_admin"
      "x-requested-with"="XMLHttpRequest"
    }).Content | ConvertFrom-Json | ForEach-Object { $_.items |select accountId, nativeIdentity, displayName, identity, identityName, uncorrelated }

    $array += $data

    [int]$offset = 0

    if($data.Count -eq 250)
    {
        do
        {
            $offset += 250
            
            $data2 = (Invoke-WebRequest -UseBasicParsing -Uri "https://$($env).api.identitynow.com/cc/api/source/getAccounts/?_dc=1674250434665&id=$($cloudExternalId)&start=$($offset)&limit=$($limit)&sort=%5B%7B%22property%22%3A%22identityName%22%2C%22direction%22%3A%22ASC%22%7D%5D" `
            -WebSession $session `
            -Headers @{
            "authority"="xxxx.api.identitynow.com"
              "method"="GET"
              "path"="/cc/api/source/getAccounts/?_dc=1674250434665&id=1418237&start=0&limit=50&sort=%5B%7B%22property%22%3A%22identityName%22%2C%22direction%22%3A%22ASC%22%7D%5D"
              "scheme"="https"
              "accept"="*/*"
              "accept-encoding"="gzip, deflate, br"
              "accept-language"="en-US,en;q=0.9,pl;q=0.8"
              "authorization"="Bearer $($token)"
              "origin"="https://xxxx.identitynow.com"
              "sec-ch-ua"="`"Not?A_Brand`";v=`"8`", `"Chromium`";v=`"108`", `"Microsoft Edge`";v=`"108`""
              "sec-ch-ua-mobile"="?1"
              "sec-ch-ua-platform"="`"Android`""
              "sec-fetch-dest"="empty"
              "sec-fetch-mode"="cors"
              "sec-fetch-site"="same-site"
              "slpt-origin"="ui:ext_admin"
              "x-requested-with"="XMLHttpRequest"
                }).Content | ConvertFrom-Json | ForEach-Object { $_.items |select accountId, nativeIdentity, displayName, identity, identityName, uncorrelated }
            $array += $data2
        }
        until($data2.Count -lt 250)
    }

    return $array
}
$token = Get-SPToken
$env = ""

$result = get-accounts -token $token -cloudExternalId "222222" -env $env

cls
($result | Where-Object { $_.uncorrelated -eq "True"}).count
