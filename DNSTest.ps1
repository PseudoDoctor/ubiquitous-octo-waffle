While ($true) {
    $allResults = @();
    get-date;
    #$allResults += Resolve-DnsName -Server 8.8.8.8 -Type TXT -Name _acme-challenge.katara.markghill.com -EA SilentlyContinue;
    #$allResults += Resolve-DnsName -Server 8.8.8.8 -Type TXT -Name _acme-challenge.cassandra.markghill.com -EA SilentlyContinue;
    #$allResults += Resolve-DnsName -Server 4.2.2.2 -Type TXT -Name _acme-challenge.katara.markghill.com -EA SilentlyContinue;
    #$allResults += Resolve-DnsName -Server 4.2.2.2 -Type TXT -Name _acme-challenge.cassandra.markghill.com -EA SilentlyContinu;
    $allResults += Resolve-DnsName -Server 8.8.8.8 -Type TXT -Name _acme-challenge.ximatest.markghill.com -EA SilentlyContinue;
    $allResults += Resolve-DnsName -Server 4.2.2.2 -Type TXT -Name _acme-challenge.ximatest.markghill.com -EA SilentlyContinue;
    Write-Output $allResults | Format-Table;
    get-date;
    Start-Sleep -Seconds 5;
}