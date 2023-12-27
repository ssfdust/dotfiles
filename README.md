System Configuration
----------------------
Archlinux Configuration

Install all modules
=========================
```bash
make
```

Install one module
=========================
```
make <module name>
```

### Requirements

* ansible
* python-lxml
* ansible-collection-kewlfft-aur
* openssh
* make
* rsync

#### Install Requirements

##### Via pacman
```bash
pacman -S ansible python-lxml openssh make rsync
```

if you want install the galaxy collection into user directroy. You can use

```
ansible-galaxy collection install kewlfft.aur
```

##### Via paru

```bash
paru -S ansible python-lxml openssh make rsync ansible-collection-kewlfft-aur
```
