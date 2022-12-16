# Assignment F.1

## Milestone 1 - VMWare and Kali

### Steps:

* Download ISOs for systems
* Open VMware
* Edit network settings
  1. Change VMnet 8 (NAT) IP scheme (192.168.229.0/24)
  2. Save config and close network editor
  3. Create VMnet 4 (Host only, 10.0.4.0/24) and disable DHCP and "connect adapter" options
  4. Repeat for VMnet 5 and VMnet 6
  5. Save and open network editor again

* Create default VM storage location in preferences
* Create Kali VM
  1. Specify operating system (Ubuntu x64)
  2. Rename VM
  3. Follow default steps to end screen
  4. Select "Customize Hardware"
    * *4gb of RAM*
    * *40gb disk space*
    * *2 processors*
    * *ISO location (connect at power on)*
  5. Install OS on boot with mainly default settings
    * *Create named user (deployer)*
    * *Power off VM at "Installation Complete" screen*

* Clone Kali VM
  1. Right click VM
  2. Manage > clone
  3. Create linked clone with default settings (name kali-lab)

## Milestone 2 - vyos

### Steps:

* Create VyOS base VM using steps above
  > vyos-base, 1024 MB RAM, 8 GB disk, NAT, add additional NAT network card
* Install image
  1. `install image`
  2. Follow defaults
  3. Create deployer passwords
  4. `reboot`
* Delete MAC addresses
  1. `configure`
  2. `delete int ethernet eth0 hw-id`
  3. `delete int ethernet eth1 hw-id`
  4. `commit`
  5. `save`
* Take snapshot
* Create linked clone based off of snapshot (vyos-lab)
* Adjust network adapters
  > Assign 2nd NAT adapter to VMnet 5
* Configuration Commands:
  1. `configure`
  2. `set interfaces ethernet eth0 address '192.168.229.10/24'`
  3. `set interfaces ethernet eth0 description 'Nat on VMware Host'`
  4. `set interfaces ethernet eth1 address '10.0.5.2/24'`
  5. `set interfaces ethernet eth1 description 'VMNET5-RANGE'`
  6. `set protocols static route 0.0.0.0/0 next-hop 192.168.229.2`
  7. `set service ssh listen-address '192.168.229.10'`
  8. `set system name-server '192.168.229.2'`
  9. `set service ssh listen-address 192.168.229.10`
  10. `commit`
  11. `save`


## Milestone 3 - the centos target

### Steps:
#### Create a Base Image for vyos called centos-base
* Follow steps above
  1. 1 GB Ram, VMnet 5, 20 GB disk
* Follow default installation, use entire disk
  1. Specify web server installation
  2. Include "Development Tools" and  "Server Platform Development"
* Create deployer user
  1. Add to wheel group
  2. `usermod -aG wheel deployer`
  3. Modify `/etc/sudoers` (uncomment `%wheel  ALL=(ALL)     ALL`)


#### Clear out UUIDs an MAC addresses
* `vi /etc/sysconfig/network-scripts/ifcfg-eth0`
* Delete `HWADDR` and `UUID` lines
* `ONBOOT=yes`
* `rm /etc/udev/rules.d/70-persistent-net.rules`

#### Install vmware tools on centos-base
* Done from "tools" tab in GUI
* On centos-base:
  1. `mount /dev/cdrom /mnt`
  2. `cd /mnt`
  3. Copy TAR to `/tmp`
  4. Extract TAR
  5. Enter new directory
  6. Run .pl script
  7. Follow defaults (no to shared folders, no to copy/paste)
  8. Remove TAR and distrib
#### Create a linked clone called cupcake
* Same steps as above

#### Configure DHCP on vyos-lab
* DHCP Configuration Commands
  1. `configure` 
  2. `set service dhcp-server global-parameters 'local-address 10.0.5.2;'`
  3. `set service dhcp-server shared-network-name DHCPPOOL authoritative`
  4. `set service dhcp-server shared-network-name DHCPPOOL subnet 10.0.5.0/24 default-router '10.0.5.2'`
  5. `set service dhcp-server shared-network-name DHCPPOOL subnet 10.0.5.0/24 domain-name 'range.local'`
  6. `set service dhcp-server shared-network-name DHCPPOOL subnet 10.0.5.0/24 lease '86400'`
  7. `set service dhcp-server shared-network-name DHCPPOOL subnet 10.0.5.0/24 range POOL1 start '10.0.5.50'`
  8. `set service dhcp-server shared-network-name DHCPPOOL subnet 10.0.5.0/24 range POOL1 stop '10.0.5.100'`
  9. `commit`
  10. `save`


## Milestone 4 - VPN connectivity to the target network

### Steps:

#### Install Wireguard
* Create a keypair on kali
  1. `sudo apt install wireguard`
  2. `cd /etc/wireguard`
  3. `umask 077`
  4. `wg genkey | tee privatekey | wg pubkey > publickey`
* Create the default keypair on vyos
  1. `generate wireguard default-keypair`
  2. `configure`
  3. `set interfaces wireguard wg0 private-key default`
* Create a peer for 10.0.99.100 on vyos
  1. `set interfaces wireguard wg0 address '10.0.99.1/24'`
  2. `set interfaces wireguard wg0 peer namegoeshere allowed-ips '10.0.99.100/32'`
  3. `set interfaces wireguard wg0 peer namegoeshere public-key keygoeshere`
  4. `set interfaces wireguard wg0 port '51820'`
  5. `commit`
  6. `save`
  7. `exit`
  8. `exit`
  9. `show interfaces wireguard wg0 public-key`
* Finish Wireguard on kali
  1. `vi /etc/wireguard/wg0.conf`

> File Config:
>
>> ```
>> [Interface]
>> PrivateKey = clientprivatekeygoeshere
>> Address = 10.0.99.100/24
>> [Peer]
>> PublicKey = vyospublickeyhere
>> EndPoint = 192.168.229.10:51820
>> AllowedIPs = 10.0.99.1/32, 10.0.5.0/24

## Reflection

I ran into some difficulty over the course of this lab. The first issue I ran into was that I was unable to get a DHCP address on Cupcake. However, I was able to fix this issue when I realized that my main interface was eth1, not eth0. Since this was the case, I simply copied the config from the file `/etc/sysconfig/network-scripts/ifcfg-eth0` into `/etc/sysconfig/network-scripts/ifcfg-eth1`, and changed the interface option at the top of the file to eth1.

The second major issue that I ran into was that I was unable to ssh into Cupcake over the Wireguard VPN from Kali. This issue took some time to resolve, however I found that I was able to establish contact to the system because of the error message I recieved in Kali

> ```
> Unable to negotiate with 10.0.5.50 port 22: no matching host key found
> Their offer: ssh-rsa,ssh-dss

After some googling, I found that I was able to modify my ssh command into `ssh -oHostKeyAlgorithms=+ssh-dss deployer@10.0.5.50`, after which I was able to establish a connection. I imagine this issue lies somewhere in the SSH configuration of the Kali machine, however this fix was more practical in this application. In the future I will have to investigate the SSH configuration to see where the issue lies.
