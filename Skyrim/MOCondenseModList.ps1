$PRofilesPath = "C:\Games\Mods\Skyrim\MOSkyrimSE\profiles\";
$specificProfile = "mbb3 Trim2";
$profileObject = gci $PRofilesPath $specificProfile;
$modlistFile = gci $profileObject modlist.txt;
<#
First character is mod state. Enabled, disabled, other. 
+ Enable
- disabled
* Other
# Comment

UI presents them in reverse order. Last line is priority 0 and gets overwritten by the second to last line with priority 1
Order is very important, we want to preserve that.
#>