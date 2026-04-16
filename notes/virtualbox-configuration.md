
Check vbox related processes
ps aux | grep vbox


# Remove vbox modules from kernel and disable all services

To prevent VirtualBox kernel modules from loading automatically on startup, you need to blacklist them. Follow these steps:

### 1. **Blacklist VirtualBox Kernel Modules**

Create or edit the blacklist configuration file:

```bash
sudo nano /etc/modprobe.d/blacklist-virtualbox.conf
```

Add the following lines:

```
blacklist vboxdrv
blacklist vboxnetflt
blacklist vboxnetadp
blacklist vboxpci
blacklist vboxvideo
```

Save the file and exit (`Ctrl+X`, then `Y`, then `Enter`).

### 2. **Disable VirtualBox Services (if enabled)**

Run the following commands:

```bash
sudo systemctl disable vboxdrv.service
sudo systemctl disable vboxballoon.service
sudo systemctl disable vboxautostart-service
sudo systemctl disable vboxweb-service
```

### 3. **Update the Initramfs (If Required)**

On Arch Linux, update the initramfs to apply blacklisting:

```bash
sudo mkinitcpio -P
```

### 4. **Reboot Your System**

Restart your system to apply the changes:

```bash
sudo reboot
```

After rebooting, check if the modules are loaded:

```bash
lsmod | grep vbox
```

If no output appears, the modules are successfully blocked from loading. Let me know if you need further tweaks!



# Script to load vbox modules temporarily

Here’s a Bash script to **temporarily load** all VirtualBox-related kernel modules:

```bash
#!/bin/bash

# Define the list of VirtualBox modules
modules=("vboxdrv" "vboxnetflt" "vboxnetadp" "vboxpci" "vboxvideo")

# Load each module
for mod in "${modules[@]}"; do
    if ! lsmod | grep -q "$mod"; then
        sudo modprobe "$mod"
    fi
done

echo "All VirtualBox modules have been loaded temporarily."
```

### Steps to Use:

1. Save this as `load_vbox.sh`
2. Give it execute permissions:
    
    ```bash
    chmod +x load_vbox.sh
    ```
    
3. Run it with:
    
    ```bash
    ./load_vbox.sh
    ```
    

This will **only load** the modules for the current session. After a reboot, since you've blacklisted them, they will not load automatically. Let me know if you need any changes!




# Script to turn off vbox

```bash
#!/bin/bash  
  
# Stop VirtualBox services  
sudo systemctl stop vboxdrv.service  
sudo systemctl stop vboxballoon.service  
sudo systemctl stop vboxautostart-service  
sudo systemctl stop vboxweb-service  
  
# Unload VirtualBox kernel modules  
modules=("vboxnetflt" "vboxnetadp" "vboxdrv")  
  
for mod in "${modules[@]}"; do  
   if lsmod | grep -q "$mod"; then  
       sudo rmmod "$mod"  
   fi  
done  
  
echo "All VirtualBox modules have been unloaded."
```


# Shared Folder

If shared folder is not working then do this

## ARCH

On Arch Linux, you can add yourself to the `vboxsf` group within the guest VM using:

```bash
sudo gpasswd -a $USER vboxsf
```

Then, either log out and log back in or reboot for the changes to take effect:

```bash
reboot
```


# UBUNTU

Run `sudo adduser $USER vboxsf` from terminal.



# For linux-lts download 'virtualbox-dmks-lts'
