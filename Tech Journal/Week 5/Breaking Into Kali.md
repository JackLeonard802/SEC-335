# Breaking Into Kali

In Kali Linux, it is possible to alter the boot sequence in order to change the root password without authenticating

## Steps

1. Restart Kali
2. During boot sequence press space
3. Press E on first option
4. Find first line that begins with linux
5. Append `single init=/bin/bash` to enter minimal terminal in single user mode
6. Press ctrl+x to boot
7. Enter `mount -rw -0 remount /`
8. Enter `passwd` to change password
9. Enter `sync`
10. Enter `umount /`
11. Reboot Kali
