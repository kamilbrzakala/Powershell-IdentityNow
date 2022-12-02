Function DownloadFTPFile {

    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$fileName,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$folderName
    )

    $source = 'ftp://<ftp.dns.com>', $fileName -join "/"
    $target = (Get-DefaultPath), $folderName, $fileName -join "\"
    $password = Microsoft.PowerShell.Security\ConvertTo-SecureString -String (Get-Config).ftp_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList (Get-Config).ftp_user, $password

    # Download
    Invoke-WebRequest -Uri $source -OutFile $target -Credential $credential -UseBasicParsing

}
