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
