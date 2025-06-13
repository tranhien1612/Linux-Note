## Temporary IP address assignment

```
sudo ip addr add 10.102.66.200/24 dev enp0s25

ip link set dev enp0s25 up
ip link set dev enp0s25 down

ip address show dev enp0s25

sudo ip route add default via 192.168.1.1
```

## Dynamic IP address assignment (DHCP client)

Config file `/etc/netplan/...yaml`:
```
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      dhcp4: true
```

## Static IP address assignment

```
network:
  version: 2
    ethernets:
      enp0s3:  # This is the device name and may be different on each machine
        dhcp4: false
        dhcp6: false
        addresses: 
          - 192.168.1.80/24    # The static IP address to use for the device
        routes:
          - to: default
           via: 192.168.1.254
        nameservers:
                addresses: [8.8.8.8,8.8.4.4,1.1.1.1,192.168.1.254] # array of DNS nameservers
```

The configuration can then be applied using the netplan command.
```
sudo netplan apply
```


## Note
Check eno4 is managered by: 
```
networkctl status eno4
```

- if using `netplan` -> delete /etc/systemd/network/20-eno4.network.
- if using `/etc/systemd/network` -> delete eno4 in netplan file
- 
### Using netplan to config ip static for eno4
edit `/etc/netplan/00-installer-config.yaml`:
```
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      dhcp4: true
    eno2:
      dhcp4: true
    eno3:
      dhcp4: true
    eno4:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.1.4/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8,8.8.4.4]
```

### Using systemd/network to config ip static for eno4

edit ```/etc/netplan/00-installer-config.yaml```:
```
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      dhcp4: true
    eno2:
      dhcp4: true
    eno3:
      dhcp4: true
```        

Create `/etc/systemd/network/20-eno4.network
```
[Match]
Name=eno4

[Network]
Address=192.168.1.4/24
Gateway=192.168.1.1
DNS=8.8.8.8
```
