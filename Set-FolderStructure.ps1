Function Set-FolderStructure {

<#
.SYNOPSIS

.DESCRIPTION
    <ParentFolder: SOURCE_NAME>
                                    <ChildFolder: TO_VALIDATE>
                                    <ChildFolder: TO_IMPORT>
                                    <ChildFolder: TO_CORRECT>
    
.EXAMPLE

#>

    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$parentFolder
    )

    $path = (Get-DefaultPath), (Get-Config | ForEach-Object { $_.csv_folder}) -join "\"

    If(!(test-path -PathType container $path))
    {
          New-Item -ItemType Directory -Path $path, $parentFolder -join "\"
          
    }
          New-Item -ItemType Directory -Path ($path, $parentFolder, 'TO_VALIDATE' -join "\")
          New-Item -ItemType Directory -Path  ($path, $parentFolder, 'TO_IMPORT' -join "\")
          New-Item -ItemType Directory -Path  ($path, $parentFolder, 'TO_CORRECT' -join "\")


}
