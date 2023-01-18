cls
## INSTRUCTION OF USE
## 1. setup pwdIn by passing password to popup
$pwdIn = read-host -assecurestring  | ConvertFrom-SecureString # | out-file $outFile

#$pwdOut = "01000000d08c9dd............" | ConvertTo-SecureString
$pwdOut = $pwdIn | ConvertTo-SecureString
$pwdOut
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList "user", $pwdOut 

# execute below if you wanna read unencrypted password (as plain text)
#$creds.GetNetworkCredential().Password

# use it as param in invoke
Invoke-WebRequest -UseBasicParsing -Credential $creds -Uri
