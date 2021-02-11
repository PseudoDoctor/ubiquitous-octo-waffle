$dir = "C:\Windows\servicing\Packages"
gci "C:\Windows\servicing\Packages" -Filter *Hyper-V*.mum | %{$package = $_.FullName;& dism /online /norestart /add-package:"$package"}
Get-WindowsOptionalFeature -Online -FeatureName *Hyper-V*
Microsoft-Hyper-V-Management-Clients
Enable-WindowsOptionalFeature  -Online -FeatureName Microsoft-Hyper-V-Management-Clients -All