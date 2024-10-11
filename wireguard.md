# WireGuard installer
WireGuard is a point-to-point VPN that can be used in different ways. Here, we mean a VPN as in: the client will forward all its traffic through an encrypted tunnel to the server. The server will apply NAT to the client's traffic so it will appear as if the client is browsing the web with the server's IP.

## Usage
Download and execute the script. Answer the questions asked by the script and it will take care of the rest.
```
curl -O https://github.com/tranhien1612/Linux-Note/blob/main/wireguard-install.sh
chmod +x wireguard-install.sh
sudo ./wireguard-install.sh
```

It will install WireGuard (kernel module and tools) on the server, configure it, create a systemd service and a client configuration file.

Run the script again to add or remove clients!
