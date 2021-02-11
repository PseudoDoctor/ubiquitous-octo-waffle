$modInstallersPath = "C:\Games\Mods\DragonAgeOrigins\modDownloads"
$tempPath = "C:\Games\Mods\temp\"
gci $modInstallersPath | where { ! $_.PSIsContainer } |
# gci 'C:\Games\Mods\DragonAgeOrigins\modDownloads\Chargen Package v1-110.zip' |
# gci "C:\Games\Mods\DragonAgeOrigins\modDownloads\Chargenmophcfg-3552-.7z" | 
% { 
  $a = & 'C:\Program Files\7-Zip\7z.exe' l -slt $_.FullName ;
  $hasChargen = $a | Select-String -Pattern 'chargenmorphcfg.xml';
  if ( $hasChargen -eq $null ) {
    # "No chargen, skip";
  } else {
    # "Lookup path and all chargen results";
    $archivePath = $_.FullName;
    $newTempPath = $tempPath + $_.BaseName;
    #mkdir $newTempPath -ErrorAction Ignore;
    $chargenFileName = $hasChargen.Line.Replace("Path = ","");
    $archivePath;
    $chargenFileName;
    $chargenFileName | % { & 'C:\Program Files\7-Zip\7z.exe' x -y -o"$newTempPath" $archivePath $_};
    gci -Recurse $newTempPath;
    

  }
}
