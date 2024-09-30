# Anaconda

## Install
### Install
```
sudo apt update

```
Change the URl and check file
```
cd /tmp
curl -O https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh 
sha256sum Anaconda3-2023.09-0-Linux-x86_64.sh #Check file
```
Install file: 
```
bash Anaconda3-2023.09-0-Linux-x86_64.sh
```

After Install, add PATH into ```bashrc``` file : 
```
source ~/.bashrc
```

### Uninstall
```
conda install anaconda-clean
anaconda-clean
rm -rf ~/anaconda3

# Remove path in .bashrc file
nano ~/.bashrc
```

### Check and Update
Check anaconda: 
```
conda info
```

Update anaconda version: 
```
conda update conda
```

## Using

### Creating environments
Create a new environment:
```
conda create -n <env-name>
```
Or add packages while creating an environment:
```
conda create -n myenvironment python numpy pandas
```
List of all your environments:
```
conda info --envs
```
Change your current environment back to the default ```base```:
```
conda activate
```
Install packages into a previously created environment:
```
# via environment activation
conda activate myenvironment
conda install matplotlib

# via command line option
conda install --name myenvironment matplotlib
```


