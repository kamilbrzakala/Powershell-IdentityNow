Function wh {
<#
.SYNOPSIS

.DESCRIPTION
    Write-Host in shortned version
    
.EXAMPLE
    wh "hello"
    output: hello
    
    wh "hello" "world"
    output: hello world
    
    $str1 = "hello"
    wh $str1
    output: hello
    
    $str1 = "hello"
    $str2 = "world"
    wh $str1 $str2
    output: hello world

#>
    [cmdletbinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$string,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [string]$string2
    )
    $str = $string, $string2 -join " "
    Write-Host $str
}
