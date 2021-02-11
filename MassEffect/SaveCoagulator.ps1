$biowareFolder = gci $env:HOMEPATH -Recurse -Filter "bioware"
$biowareFolder.FullName
$saveFolders = gci -Recurse -Path $biowareFolder.FullName -Filter "Save"
$tempFolder = "$env:TEMP/ME/"
if(Test-Path $tempFolder){
    $saveFolders.ForEach({
        $dest = $tempFolder+$_.parent.Name
        mkdir $dest
        robocopy /E $_.FullName "$dest/Save"
    })
}
$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
if (-not (Test-Path -Path $7zipPath -PathType Leaf)) {
    throw "7 zip file '$7zipPath' not found"
}
Set-Alias 7zip $7zipPath
$destinationZIP = "C:\Games\Mods\MassEffectSaves.7z"
7zip a $destinationZIP $tempFolder