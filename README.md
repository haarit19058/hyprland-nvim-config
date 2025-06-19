# hyprland-nvim-config

This repo is meant to guide all the travellers eager to aquire the power of arch and beauty, productiveness of hyperland. 
Note: This guide is for uefi firmware only. I would suggest you to first check the type of hardware you are usign otherwise may run into problems.

howToBuildArchHyper.md
This file is the main guide that would help you install Arch linux and hyprland.

nvim
this folder contains the configuration for neovim paste it under ~/.config

kitty
this folder contains config files for kitty terminal emulator. paste it under ~/.config

hypr
this is where the magic happens. Unlike all other desktop environment hypr needs you attention the most. It needs you to know it very well. THis folder holds all the configuration files to make your hyprland look good/bad as per your liking

font files .ttf
I use Comic Mono for terminal and Consolas for vs code so i have provided them here.

Install and Setup QEMU.md
this guide helps you to install and run qemu on arch linux

virtualbox-configuration.md
this will help you setup the virtul box and turn off the services by default to save power.


copyfile.sh
utility to make the work of copying the configuration files into the repo easy for me

qemu.sh
script to run qemu services otherwise off by default.

vbox start/stop.sh
scripts to start and stop vbox.

Note: always turn off the unecessary services. THese scripts are used to enable them temporarily. Other wise it will use a lots of battery on background.
