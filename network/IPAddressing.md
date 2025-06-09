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
