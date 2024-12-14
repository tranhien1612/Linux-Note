# Linux-Note

## Increase swap memory for raspi
```
	sudo swapon --show 
	free -h 
	sudo fallocate -l 4G /swapfile 
	sudo chmod 600 /swapfile 
	ls -lh /swapfile 
	sudo mkswap /swapfile 
	sudo swapon /swapfile 
	sudo cp /etc/fstab /etc/fstab.bak 
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

## Mavlink-camera-manager Install

### 1. Install the development dependencies:
```
sudo apt update -y && sudo apt install -y --no-install-recommends libunwind-dev libclang-dev libssl-dev pkg-config build-essential curl gnupg ca-certificates git libmount-dev libsepol-dev libselinux1-dev libglib2.0-dev libgudev-1.0-dev gstreamer1.0-tools gstreamer1.0-nice libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev libgstrtspserver-1.0-dev
```

### 2. Install cargo if not available   
```	
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 3. Install NodeJS greater or equal to 19
```
 sudo apt-get install -y curl
	curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
	sudo -E bash nodesource_setup.sh
	sudo apt-get install -y nodejs
```

### 4. Install the latest Yarn
```
	npm install --global yarn

	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
	  | sudo gpg --dearmor -o /usr/share/keyrings/nodesource.gpg &&\
	echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
	  | sudo tee /etc/apt/sources.list.d/nodesource.list &&\
	curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg \
	  | sudo gpg --dearmor -o /usr/share/keyrings/yarnkey.gpg &&\
	echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" \
	  | sudo tee /etc/apt/sources.list.d/yarn.list &&\
	sudo apt-get update -y &&\
	  sudo apt-get install -y --no-install-recommends \
	  nodejs \
	  yarn
```
### 5. Install Bun
```
	curl -fsSL https://bun.sh/install | bash
	curl -fsSL https://bun.sh/install | bash -s "bun-v1.0.0"
```
After install bun, run to command:
```
  source /home/maj/.bashrc
```

### 6. Clone this repository and enter it
```
	git clone --branch t3.16.0 --depth 1 https://github.com/mavlink/mavlink-camera-manager.git && cd mavlink-camera-manager && cargo build
```

### Run
```
  cd mavlink-camera-manager
  ./target/debug/mavlink-camera-manager --mavlink=tcpout:0.0.0.0:14000 --verbose
```
Open web local [http://localhost:6020](http://localhost:6020)


 
