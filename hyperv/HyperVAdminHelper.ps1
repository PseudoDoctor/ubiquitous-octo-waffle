function installHyperV {
    param ()
    <#
    https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v
    Windows 10 Home does not support Hyper-V

    # Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
    # ERROR Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

    # DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
    # Error: 0x800f080c
    # Feature name Microsoft-Hyper-V is unknown.

    However, there are ways around that. I justify this as it will be monitoring another host.
    https://www.itechtics.com/enable-hyper-v-windows-10-home/
    Hyper-V-Enabler.bat
    #>
    $HyperVEnablerBatchContents = "pushd `"%~dp0`" `
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt `
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:`"%SystemRoot%\servicing\Packages\%%i`" `
del hyper-v.txt `
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL `
pause";
    $HyperVEnablerBatch = "hyperv\Hyper-V-Enabler.bat";
    $HyperVEnablerBatchSHA256 = "252FAE772ED5E8018C268B7F9815DF27A6CF84DBDD0912EDB6B9BB1C231EBDFF";
    $hash = Get-FileHash $HyperVEnablerBatch;
    if($hash.Hash.Equals($HyperVEnablerBatchSHA256)){
        Invoke-Command -ScriptBlock {cmd /k $HyperVEnablerBatch};
    };
}
function testGetVMServer {
    param (
        [string]$hostname
    )
    write-host "Attempting Get-VM "
    Get-VM 
}
function enableRemotePSWithHost {
    param (
        [string]$hostname
    )
    Enable-PSRemoting
    $current=(get-item WSMan:\localhost\Client\TrustedHosts).value
    Write-Host $current
    if($current.Length -gt 0){
        $current+=",$hostname"
    } else {
        $current=$hostname
    }
    Write-Host $current
    set-item WSMan:\localhost\Client\TrustedHosts –value $current
}
