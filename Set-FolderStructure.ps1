Function Set-FolderStructure {

<#
.SYNOPSIS

.DESCRIPTION
    <ParentFolder: SOURCE_NAME>
                                    <ChildFolder: child folder>
    
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
          New-Item -ItemType Directory -Path ($path, $parentFolder, 'child folder' -join "\")
    }
          


}
