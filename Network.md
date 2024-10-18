Use iptables to setup data forwarding (wlan0 to eth0)
```
net.ipv4.ip_forward = 1
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
```

Use iptables to setup data forwarding (wlan0 to br0)
```
net.ipv4.ip_forward = 1
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i wlan0 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i br0 -o wlan0 -j ACCEPT
```

# Forward from a laptop's eth0 to wlan0
## To laptop
Specify an IP address to eth0 (here 192.168.56.1)
```
sudo ifconfig eth0 192.168.56.1 netmask 255.255.255.0
```

Enable forwarding
```
sudo sysctl -w net.ipv4.ip_forward=1 
```

Forward package from eth0 to wlan0
```
sudo iptables -A FORWARD -i eth0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
```

## To device connected to laptop
Setup IP address for eth0,and add gateway
```
sudo ifconfig eth0 192.168.56.2 netmask 255.255.255.0
sudo route add default gw 192.168.56.1
```
