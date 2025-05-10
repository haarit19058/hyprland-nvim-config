# This is the  first time i am trying neovim and hyperland 
- There is a channel named typecraft the i am learning from and he is teaching how to setup the proper development environment using neovima nd how to setup hyprland and how it works in grim details. For now i will use nvim and hyprland and not exploring further .
It is better to get a good grip of the workflow before doing more and hence i stop at colorscheme and telescope in neovim.





# Function for cp and running test cases easily
For competitive Programming we do the following
- Define this function in .bashrc and use it

function runcp() {
  local src=${1:-main.cpp}
  local exe=a.out
  local inp="$HOME/input_cp.txt"
  local out="$HOME/output_cp.txt"
  g++ -std=c++17 -O2 "$src" -o "$exe" && ./"$exe" < "$inp" > "$out"
}






# Installing the base Arch system
First of all download the iso file and burn it on the drive using rufus.
Now make a free partition using the disk manager in windows. Free means unallocated space.

Now boot into the pendrive from bios and run following commands.

### Note that if we disassemble the motherboard then the system needs to be reinstalled..... This is the only shortcoming of this method.

## If you want to change the  fonts then type following
setfont ter-132n

## Connect to a wifi
- ping google.com  // to check whether you are connected to the internet or not.

- iwctl // opens the interface to interact with the wifi devices
- device list // to list all the attached devices
- station wlan0 get-networks // get the list of available networks
- station wlan0 connect 'vivo T1' // connect to the network. will ask for the password for the network. Can connect to wpa psk 2 type authentications only no sso 
- ping google.com // if you want to verify 


## Update the pacman database
- pacman -Sy

## install the arch linux key ring
- pacman -Sy archlinux-keyring
keyring is a PGP key used by arch to verify the integrity of its packages.


## Creating partitions for arch
- lsblk // list all the attached storage devices

### BECAREFUL !! One wrong click and the whole windows is erased
- cfdisk /dev/nvme0n1 // for partitioning the disk the interface to do so
- GUI easy to understand. Do not forget to set teh file system type for all the patitions you make
- one partition of size 500M for EFI grub
- another parition of 1-5 G for swap
- rest is for ext4 root file system

- verify using lsblk

- mkfs.fat -F32 /dev/nvme0n1p6  // make the EFI partiton to use fat system
- mkfs.ext4 /dev/nvme0n1p7  // make the main storage as ext4 for separate setup for llvm if you want otherwise this is more than fine
- mkswap /dev/nvme0n1p8 // enable the swap partition

- mount /dev/nvme0n1p7 /mnt // mount the base storage
- mkdir /mnt/boot   // make directory to mount the efi parition for grub
- swapon /dev/nvme0n1p8 // enable the swap


## Setup the base system
- Another draw back of archlinux is that the whole installation depends on internet and therefore you will need good internet connection

install the base system
- pacstrap -i /mnt base base-devel linux-lts linux-firmware git sudo fastfetch htop intel-ucode nano vim nvim bluez bluez-utils networkmanager

This will take a lots of time. Will download ~800M data



## generate fstab file
- genfstab -U /mnt >> /mnt/etc/fstab // generate the fstab file
- cat /mnt/etc/fstab    //  verify

## chroot into the base system
- arch-chroot /mnt


- passwd // setup the root password
- useradd -m -g users -G wheel,storage,power,video,audio -s /bin/bash haarit
- passwd haarit


- EDITOR=nano visudo // For sudo access to the user haarit
- Find the line which says 'uncomment to allow memebers of group wheel to execute any command'

## Setting up the time zone,locale,keyboard,language,hostname etc.
- ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
- hwclock --systohc
- nano /etc/locale.gen // uncomment the locale that you want to use. US utf 8
- locale-gen    // to generate teh locales

- nano /etc/locale.gen  // Write 'LANG=en_US.UTF-8' into the file to set english as default language

- nano /etc/hostname    // write 'archlinux\<the name of the pc that you want \>'
- nano /etc/hosts   // add the line '127.0.1.1  archlinux\<name\>.localdomain   archlinux\<name\>'


## Installing grub
- pacman -S grub efibootmgr dosfstools mtools   //install the grub

- grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB //    install grub into /boot

- grub-mkconfig -o /boot/grub/grub.cfg  // generate the grub configuration file into /boot


- systemctl enable NetworkManager // enable the networkmanager

- exit  // the base system is ready to boot

umount -lR /mnt
poweroff now




# Post install tweaks

## enable audio

- install necessary packages
```bash
sudo pacman -Syu \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  pipewire-jack \
  wireplumber \
  alsa-utils \
  pavucontrol

```
- enable the services
```bash
systemctl --user enable --now \
  pipewire.service \
  pipewire.socket \
  pipewire-pulse.socket \
  wireplumber.service
```

- another thing to take care of is that ensure that the user is in the audio group
- groups $USER  // see the groups current user is in
- sudo usermod -aG audio $USER  // add teh user to audio group if not already

- pavucontrol   // use to control the audio volume and stuff


## Enable os-prober
- firstly you need to install os-prober as it is not installed
- now you must know that it depends on grub-mount which requires fuse3 so you need to isntall it first
- sudo pacman -S fuse3
- sudo pacman -S ntfs-3g    // to read the ntfs file system and support for fstab and it may cause os prober to not work properly depends not sure on this 


## Edit the fstab file to mount the drive on boot

- See teh exact format what you have to write in the fstab file
UUID=uuit   mount point    filesystem   defaults    0 2


# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install and configure hyprland
- yay -S hyprland waybar wofi dolphin\(or use nautilus\) kitty sddm


- Then copy the hyprland config from the repo to .config  working properly as of 11 May 2025.
- If something breaks then rever the code to this date

sudo systemctl enable sddm
- hyprland should be working fine by now. Need to enable sddm

## configure vim nvim kitten waybar 
Copy the config files to .config and it will work file



## It is advised to install miniconda


# For all other desktop environment it is easy to install but the hyprland requires a lots of configuration and working in terminal only.



# Hope you destroyed your life by installing the deadly combo of arch and hyprland
Your life is hell now --- and it is fun livign in hell ;->




