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

## Techniques

Something I have realized is that one does not simply run a single nmap scan. The great thing about nmap, also the reason why it is used so widely, is because it allows for enumeration past the initial results you recieve, recursive or sub-enumeration if you will. Say you find that port 1234 is open on 10.0.1.1. Instead of trying different techniques and roundabout methods to try to determine what service is using this port, you can instead just ask nmap to tell you, and better yet you can run scripts, run a traceroute, and get information about the OS. The best technique you can use with nmap is to use it again.
