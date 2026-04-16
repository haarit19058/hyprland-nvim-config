sudo pacman -Syu

git clone https://aur.archlinux.org/yay.git 
cd yay 
makepkg -si


cd ..

sudo pacman -S btop powertop tlp tlp-rdw smartmontools base-devel obsidian docker
sudo systemctl enble --now tlp 


sudo groupadd docker
sudo usermod -aG docker $USER 
sudo usermod -aG docker $USER 


yay -S visual-studio-code-bin google-chrome


echo "For qemu setup see the md file from /notes it is self explanatory and copy the qemu.sh file to home folder for easy access"

