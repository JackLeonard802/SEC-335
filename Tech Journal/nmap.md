# nmap

## Flags

* -p
  * Used to specify a port, a port range, or a list of individual ports
  * Examples:
    * `nmap 192.168.1.1 -p 80`
    * `nmap 192.168.1.1 -p 1-6000`
    * `nmap 192.168.1.1 -p 80,443,53`
* -sV
  * Used to display service and version info for discovered ports
  * Example:
    * `nmap -sV 192.168.1.1 -p 80`
* -A
  * A fairly comprehensive flag, used for OS Detection, Version Detection, Script Scanning, and traceroute
  * Example:
    * `nmap -A 192.168.1.1 -p 80`
