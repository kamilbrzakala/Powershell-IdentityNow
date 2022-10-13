$documents = [environment]::getfolderpath("mydocuments")
$path = $documents + "\Folder"

$Public  = @( Get-ChildItem "$path\*.ps1" -Depth 2 -ErrorAction SilentlyContinue  | Where-Object {$_.BaseName -notlike '_*'})
    
foreach($item in $Public) 
{
    
    Try
        {
            . $item.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($item.fullname): $_"
        }
}




Export-ModuleMember -Function $Public.Basename 


