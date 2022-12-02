cls

#$pwdIn = read-host -assecurestring  | ConvertFrom-SecureString # | out-file $outFile

# store hashed value in config file instead of plain password
$pwdOut = "01000000d08c9dd............" | ConvertTo-SecureString
$pwdOut
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList "user", $pwdOut 
$creds.GetNetworkCredential().Password

