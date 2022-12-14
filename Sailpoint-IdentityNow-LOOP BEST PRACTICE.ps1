cls
#list available source's names
$token = Get-SPToken
$data = Invoke-RestMethod -Method Get -Uri "https://$((Get-Config).environment).api.identitynow.com/v3/sources" -Headers @{Authorization = "Bearer $($token)" }

$data.name

[int]$offset = 0

    if($data.Count -eq 250)
    {
        do
        {
            $offset += 250
            
            $data2 = Invoke-RestMethod -Method GET -Uri "https://$((Get-Config).environment).api.identitynow.com/v3/sources?limit=250&offset=$($offset)" -Headers @{Authorization = "Bearer $($token)"; Accept = "application/json"}
            $data2.name
        }
        until($data2.Count -lt 250)
    }
    
