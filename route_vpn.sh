#!/bin/bash

# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1

# Configure IP routing
sudo ip route add 192.168.144.0/24 dev br0
sudo ip route add 10.0.0.0/24 dev wg0
sudo ip route add 192.168.144.0/24 via 10.0.0.2
sudo ip route add 10.0.0.0/24 dev wg0 src 10.0.0.2

# Set up IPTables rules
sudo iptables -A FORWARD -i wg0 -o br0 -j ACCEPT
sudo iptables -A FORWARD -i br0 -o wg0 -j ACCEPT
sudo iptables -A FORWARD -p tcp -d 192.168.144.100 --dport 554 -j ACCEPT

# NAT for outgoing traffic on br0
sudo iptables -t nat -A POSTROUTING -o br0 -j MASQUERADE

# Forward RTSP traffic to a specific destination
sudo iptables -t nat -A PREROUTING -p tcp --dport 554 -j DNAT --to-destination 192.168.144.100:554
