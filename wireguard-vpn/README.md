# WireGuard installer
WireGuard is a point-to-point VPN that can be used in different ways. Here, we mean a VPN as in: the client will forward all its traffic through an encrypted tunnel to the server. The server will apply NAT to the client's traffic so it will appear as if the client is browsing the web with the server's IP.

## Usage
Download and execute the script. Answer the questions asked by the script and it will take care of the rest. It will install WireGuard (kernel module and tools) on the server, configure it, create a systemd service and a client configuration file.
```
curl -O https://github.com/tranhien1612/Linux-Note/blob/main/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

Note while running `wireguard-install.sh` file:
```
IPv4 or IPv6 public address: IP Static of Network (example: 240.152.16.48)
Public interface: default
WireGuard interface name: default
Server WireGuard IPv4: IP of VPN (example: 10.0.0.1)
Server WireGuard IPv6:: default
Server WireGuard port [1-65535]: Port is using for wireguard (example: 51820)
First DNS resolver to use for the clients: default
Second DNS resolver to use for the clients (optional): default
```

If wireguard is not installed, follow this command:
```
sudo apt install wireguard
sudo apt install wireguard-tools
```

Install wireguard application in windows, follow this link: [Installation](https://www.wireguard.com/install/)


