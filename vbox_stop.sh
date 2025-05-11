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
