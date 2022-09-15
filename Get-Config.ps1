<# 
JSON FILE
{
	"ftp_user"		:	"test",
	"ftp_password"	:	"test",
    "ftp_address"	:	"ftp://127.0.0.1",
	"excluded_files":	"",
	"csv_folder"	: 	"csv",
	"root_folder"	:	"Folder\\Folder",
	"config_file"	:	"config.json",
	"scope_folders"	:	"Folder1,Folder2"
}
#>

Function Get-Config {

    $json = Get-Content 'C:\Users\config.json' | ConvertFrom-Json
	return $json
}
