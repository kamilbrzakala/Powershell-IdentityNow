Function Get-DefaultPath {

    $documents = [environment]::getfolderpath("mydocuments")
    $path = $documents, (Get-Config).root_folder -join "\"
    return $path
} 
