#!/bin/bash

# Pacotes
sudo pacman -S --needed flatpak zsh materia-gtk-theme ufw gufw aria2 bash-completion man-db man-pages texinfo reflector rsync curl cmatrix pacman-contrib dialog unrar zip unzip p7zip okular discount ebook-tools djvulibre unrar libzip kdegraphics-mobipocket libreoffice libreoffice-fresh-pt-br jre-openjdk kvantum-qt5 qt6-wayland qt5-wayland xorg-xkill lutris wine wine-gecko wine-mono gifski winetricks pandoc libappindicator-gtk3 transmission-gtk gparted exa bat alacarte fwupd gnome-firmware nvme-cli coreutils progress neofetch psensor ntfs-3g cpupower intel_gpu_top i7z xorg-xdpyinfo libgtop lm_sensors glfw-x11 glew gnome-icon-theme-symbolic steam steam-fonts python-magic lib32-gnutls gamemode thermald papirus-icon-theme

# Fontes
sudo pacman -S --needed noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation xorg-fonts-type1 xorg-fonts-misc ttf-bitstream-vera ttf-opensans terminus-font ttf-roboto ttf-roboto-mono xorg-fonts-100dpi 

# Virt-Mananger
sudo pacman -S --needed qemu libvirt iptables-nft virt-manager virt-viewer dmidecode bridge-utils openbsd-netcat dnsmasq

# TESSERACT 
sudo pacman -S --needed tesseract tesseract-data-spa tesseract-data-frk tesseract-data-ita tesseract-data-equ tesseract-data-fra tesseract-data-deu tesseract-data-deu_frak tesseract-data-eng tesseract-data-por

# Habilitar os serviços
sudo systemctl enable libvirtd
sudo systemctl enable fstrim.timer
sudo systemctl enable thermald
sudo ufw enable
sudo systemctl enable ufw.service

# Grupos
sudo usermod -aG libvirt henriqueffc

# Appimage e outros
wget -P ~/Downloads https://github.com/linuxhw/hw-probe/releases/download/1.6/hw-probe-1.6-185-x86_64.AppImage
wget -P ~/Downloads https://vulkan.gpuinfo.org/downloads/vulkancapsviewer_3.2_linux64_wayland.AppImage
wget -P ~/Downloads https://opencl.gpuinfo.org/downloads/openclcapsviewer_1.00_linux64_x11.AppImage
wget -P ~/Downloads http://opengl.gpuinfo.org/downloads/glcapsviewer_1_2_linux64.tar.gz
wget -P ~/Downloads -O bitwarden.AppImage https://vault.bitwarden.com/download/\?app\=desktop\&platform\=linux
wget -P ~/Downloads https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget -P ~/Downloads https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget -P ~/Downloads https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget -P ~/Downloads https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Variáveis
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile 

# Offpowersave
sudo mv offpowersave.service /etc/systemd/system  
sudo systemctl enable offpowersave.service 

# Intelparanoid.service
sudo mv intelparanoid.service /etc/systemd/system
sudo systemctl enable intelparanoid.service 

#Sensors
sudo sensors-detect

# Mlocate
sudo pacman -S --needed mlocate
sudo updatedb

# Limitador de FPS
git clone https://gitlab.com/torkel104/libstrangle.git
cd libstrangle 
make
sudo make install

printf "\e[1;32mFim! Reinicie o sistema.\e[0m"
