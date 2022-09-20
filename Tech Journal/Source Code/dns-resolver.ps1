$net = read-host "net"
$server = read-host "server"

for ($i = 1 ; $i -le 254 ; $i++){
    $hostid = $net + ".$i"
    Resolve-DnsName -DnsOnly $hostid -Server $server -ErrorAction Ignore
    
}
