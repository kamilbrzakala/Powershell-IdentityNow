
cls
# list all source names

#(Invoke-RestMethod -Method Get -Uri "https://$((Get-Config).environment).api.identitynow.com/v3/sources" -Headers @{Authorization = "Bearer $(Get-SPToken)" }).name
$out = Invoke-WebRequest -UseBasicParsing -Uri "https://$((Get-Config).environment).api.identitynow.com/v3/sources" `
-WebSession $session `
    -Headers @{
    "authority"="$((Get-Config).environment).api.identitynow.com"
      "method"="GET"
      "path"="/v3/sources"
      "scheme"="https"
      "accept"="*/*"
      "accept-encoding"="gzip, deflate, br"
      "accept-language"="en-US,en;q=0.9,pl;q=0.8"
      "authorization"="Bearer $(Get-SPToken)"
      "origin"="https://$((Get-Config).environment).identitynow.com"
      "sec-ch-ua"="`"Microsoft Edge`";v=`"107`", `"Chromium`";v=`"107`", `"Not=A?Brand`";v=`"24`""
      "sec-ch-ua-mobile"="?1"
      "sec-ch-ua-platform"="`"Android`""
      "sec-fetch-dest"="empty"
      "sec-fetch-mode"="cors"
      "sec-fetch-site"="same-site"
      "slpt-origin"="ui:ext_admin"
      "x-requested-with"="XMLHttpRequest"
    } | select *

$a = $out.Content | ConvertFrom-Json 
$a.name
