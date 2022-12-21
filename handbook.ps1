powershell notes 
########################################################
(Get-ChildItem) | Select-Object -Property * | Where-Object -FilterScript { $_.cloudExternalId -eq "174848" }
########################################################
---- multithread
Get-Command *-Job

https://www.delftstack.com/howto/powershell/run-commands-in-parallel-in-powershell/#:~:text=Multithreading%20is%20a%20method%20to%20run%20more%20than,is%20to%20decrease%20the%20runtime%20of%20the%20code.
########################################################
-- objects

$csv = Import-Csv C:\Temp\VMTags.csv
$csv.psobject
$csv.psobject.Properties | Select Name
$csv.psobject.Properties | Select Value


Get-Schema | Select-Object -Property * | Where-Object -FilterScript {$_.cloudExternalId -eq $cloudExternalId.Trim()}


-- @@@@

function New-Item()
{
  param ($accountName, $owner)

  $item = new-object PSObject

  $item | add-member -type NoteProperty -Name First -Value $account
  $item | add-member -type NoteProperty -Name Phone -Value $owner

  return $item
}

-- @@@@
$inclusionList = @()

$InclusionTemplate = [pscustomobject][ordered]@{
    id = $null
    type = $null
    }
$incRole = $InclusionTemplate.PsObject.Copy()
    $incRole.id = $role.id
    $incRole.type = "ROLE"
    $inclusionList += $incRole

    $e = $inclusionList | select-object -Property type | Where-Object { $_.type -eq "ENTITLEMENT" }


-- @@@@
$campaignOptions = @{ }
$campaignOptions.Add("type", "Identity")
$campaignOptions.Add("timeZone", "GMT+1000")

$campaignBody = $campaignOptions | ConvertTo-Json	

-- @@@@	

$objectProperty = [ordered]@{

    ComputerName        = $computerInfo.Name
    'OS Version'        = $("$($osInfo.Version) Build $($osInfo.BuildNumber)")
}

$ourObject = New-Object -TypeName psobject -Property $objectProperty 
$obejctList = @()
$obejctList += $ourObject
$obejctList | Export-CSV .\results.csv -noTypeInformation

-- @@@@	

$arrayList += [PSCustomObject]@{
                source = $folder
                fileName = $fileName
                filePath = $folder, "Input", $fileName -join "/"
                dateModified = $dateModified
            }
			
			
-- @@@@

$OutPutArray = foreach ($j in $json) {
        [PSCustomObject]@{
            "group" = $f
            "user" = $j.displayname
            "email" = $j.email
            "employeeNumber" = $j.employeeNumber
        }
    }
    $OutPutArray | Export-Csv "C:\Users\test\group members.csv" -Delimiter ";" -Append -NoTypeInformation -Encoding UTF8
	
	
########################################################

---@@ 
checking parameter

Function Search-Excel {
    [cmdletbinding()]
    Param (
        [parameter(Mandatory)]
        [ValidateScript({
            Try {
                If (Test-Path -Path $_) {$True}
                Else {Throw "$($_) is not a valid path!"}
            }
            Catch {
                Throw $_
            }
        })]
        [string]$Source,
        [parameter(Mandatory)]
        [string]$SearchText
		
########################################################
---@@ looping through list
$uniqueOwners = $( foreach ($line in $objectslist.owner) {
    $line.trim().ToLower()
  }) | Sort-Object | Get-Unique
$uniqueOwners



########################################################
---@ joining strings etc

$a = 'This', 'Is', 'a', 'cat'

$a
This
Is
a
cat


"$a"
This Is a cat


$ofs = '-' # after this all casts work this way until $ofs changes!
"$a"
This-Is-a-cat


########################################################
csv header

$csv = Import-Csv ((Get-DefaultPath), (Get-Config).local_folders.files_to_validate, (Get-Config).local_folders.to_validate, $fileName -join "\")
$header = @($csv[0].psobject.Properties.Name)

########################################################


switch

https://www.educba.com/switch-case-in-powershell/

Switch -Regex ("Donkey"){
"Dog" {"Dog is Mentioned"}
"Cat" {"Cat is Mentioned"}
"Don" {"Donkey is Mentioned"}
"key" {"Donkey is mentioned again"}
default {"Nothing is mentioned"}
}

$msg = "Error, WMI connection failed"
Switch -Wildcard ($msg) {
"Error*" {"WMI Error"}
"Warning*" {"WMI Warning"}
"Successful*" {"WMI Connection Successful"}
}

Switch -Regex -Exact ("Hello"){
"He" {"Hello World"}
"Hi" {"Hi World"}
Default {"No World"}
}

########################################################

# PROGRESS BAR

[int]$i = 0
write-host -ForegroundColor Yellow "Retrieving full user records"
foreach ($obj in $idnObjects) { 
    $i++
    #$global:user | Out-File $DebugFile -Append              
    if ($obj.id) {
        $userDetails = $null 
        $usrDetailsURI = "https://$($orgName).api.identitynow.com/v2/accounts/$($obj.id)?org=$($orgName)"
        $userDetails = Invoke-RestMethod -Method Get -Uri $usrDetailsURI -Headers @{Authorization = "Basic $($encodedAuth)" }         
        if ($userDetails) {
            $fullUsers += $userDetails
        }
    } 
    # PS ISE Progress Bar
    #Write-Progress -Activity "Retrieving User Object" -status "User $($obj.displayName)" -percentComplete ($i / $idnObjects.count * 100)
    # VS Code Progress Bar
    # get psInlineProgress using  Install-Module psInlineProgress
    # update line 36 of psInlineProgress.psd1 and change ConsoleHost to Visual Studio Code Host
    $percentComplete = $i / $idnObjects.count * 100
    Write-InlineProgress -Activity "Getting User Object $($obj.displayName)" -PercentComplete $percentComplete -ProgressCharacter '<' -ProgressFillCharacter '.' -ProgressFill '-'    
}
write-host -ForegroundColor Green "Retrieved full user records for $($fullUsers.Count) users"

########################################################

$C = Get-Culture | Select-Object -Property *
Out-String -InputObject $C -Width 100

########################################################

# JSON

$json = Get-Content "files\config.json" | ConvertFrom-Json
foreach($obj in $arr.PSObject.Properties.value)
{
    $obj
}
