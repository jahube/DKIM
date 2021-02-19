# O365 DKIM CHECK + Values

$Domain = "yourdomain.com"  # Modify

$tenant = "YourTenant.onmicrosoft.com" # Modify

$MX2 = (Resolve-DnsName "$Domain" MX -DnsOnly -EA SilentlyContinue).NameExchange
$s = "Selector" ;$d = "._domainkey." ; $MX1 = $MX2 -replace ".mail.protection.outlook.com"
$H1=$($s+'1'+$d);$DKIM1 = (Resolve-DnsName $($H1+$domain) CNAME -DnsOnly -EA SilentlyContinue).namehost
$H2=$($s+'2'+$d);$DKIM2 = (Resolve-DnsName $($H2+$domain) CNAME -DnsOnly -EA SilentlyContinue).namehost
$s1 = $($s+'1-'+$MX1+$d+$tenant) ; $key1 = (Resolve-DnsName $s1 txt -EA SilentlyContinue).strings
$s2 = $($s+'2-'+$MX1+$d+$tenant) ; $key2 = (Resolve-DnsName $s2 txt -EA SilentlyContinue).strings
$t1 = $("`n`n,CNAME Selector ,[Host name],[REQUIRED CNAME],DKIM Missing - Please add`n,`n-------------------------`n").Split(",")
$t2 = $("[Existing CNAME],[OK],[DKIM KEY Active],[PLEASE Activate DKIM],[INCORRECT]").Split(",")
Write-host $t1[0]$t1[1]"1" -F yellow  ; Write-host $("-" * 35) -F green ; Write-host $t1[2]"1" -F white -N
Write-host "  $H1" -F yellow -N ; Write-host $Domain -F green ; Write-host $t1[3] -F white -N ;
Write-host $s"1-" -F yellow -N ; Write-host $MX1 -F cyan -N ;Write-host $d -F yellow -N ; Write-host $tenant -F green
If (!($DKIM1)) { Write-host $t1[5]$t1[6]$h1"`n"$S1 -F yellow } ;If ($DKIM1) {Write-host $t2[0] -F green -N ; 
Write-host $DKIM1 -F yellow -N } ; If ($DKIM1 -eq $S1) { Write-host $t2[1] -F green -N };
If ($key1) { Write-host $t2[2] -F green -N };If (!($key1 -or $key2)) { Write-host $t2[3] -F yellow -N };
If (($DKIM1) -and ($DKIM1 -ne $S1)) { Write-host $t2[4] -F cyan -N };

Write-host $t1[0]$t1[1]"2" -F yellow  ; Write-host $("-" * 35) -F green ; Write-host $t1[2]"2" -F white -N
Write-host "  $H2" -F yellow -N ; Write-host $Domain -F green ; Write-host $t1[3] -F white -N ;
Write-host $s"2-" -F yellow -N ; Write-host $MX1 -F cyan -N ;Write-host $d -F yellow -N ; Write-host $tenant -F green
If (!($DKIM2)) { Write-host $t1[5]$t1[6]$h2"`n"$S2 -F yellow } ;If ($DKIM2) {Write-host $t2[0] -F green -N ; 
Write-host $DKIM2 -F yellow -N } ; If ($DKIM2 -eq $S2) { Write-host $t2[1] -F green -N };
If ($key2) { Write-host $t2[2] -F green -N };If (!($key1 -or $key2)) { Write-host $t2[3] -F yellow -N };
If (($DKIM2) -and ($DKIM1 -ne $S2)) { Write-host $t2[4] -F cyan -N };
