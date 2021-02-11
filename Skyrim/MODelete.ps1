$backupFolder = "M:\Stuff\Mods\Skyrim\MOSkyrimSE";
$toBeDeleted = "C:\games\mods\skyrim\MOSkyrimSE";
$tempFolder = "C:\temp\asdf";
robocopy /E $toBeDeleted $backupFolder;
mkdir $tempFolder;
robocopy /purge $tempFolder $toBeDeleted
