Function Get-DefaultPath {

    $documents = [environment]::getfolderpath("mydocuments")
    $path = $documents, (Get-Config | ForEach-Object { $_.root_folder}) -join "\"
    return $path
} 
