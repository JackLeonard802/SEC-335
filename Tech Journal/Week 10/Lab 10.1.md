# Lab 10.1

## Permissions Hunting Techniques

### Suid Files

#### Commands Used

* `find / -perm -u=s -type f 2>/dev/null`
* `find /etc -perm -o=w -type f 2>/dev/null`

#### Breakdown 
* `find` is used to find files matching certian criteria
* `/` specifies the entire system. This could be modified to include a directory (such as /etc/)
* `-perm -u=s` filters for content with suid bits set
* `-type f` filters for only files
* `2>/dev/null` filters out error messages by sending them to /dev/null

### World-writeable Files

#### Commands used

* `find / -perm -o=w -type f 2>/dev/null`
* `find / ! -path "/sys/*" ! -path "/proc/*" -perm -o=w -type f 2>/dev/null`

#### Breakdown
* The syntax here is largely the same as in the case of suid files, with a few key differences
* `-o=w` specifies world-writeable files
* `! -path "/sys/*"` and `! -path "/proc/*"` both exclude their respective directories (this was used in the rocky deliverable to exclude false positives).
