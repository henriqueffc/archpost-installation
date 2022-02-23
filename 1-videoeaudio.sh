#!/bin/bash

#Deletar a antiga pasta no /
sudo rm -r /archpost-installation

# Reflector
#sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
#sudo pacman -S --needed --noconfirm reflector rsync
#sudo reflector -c Brazil -a 12 -p --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu

# Video (Intel e Nvidia)
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings opencl-nvidia vulkan-icd-loader libvdpau-va-gl libva-vdpau-driver libvdpau vulkan-tools ocl-icd mesa mesa-vdpau libva vdpauinfo libva-utils intel-ucode intel-media-sdk lib32-mesa vulkan-intel intel-media-driver intel-compute-runtime intel-graphics-compiler nvidia-prime clinfo nvtop

# Audio
sudo pacman -S --needed vlc ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer-vaapi gstreamer a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore

# Pipeware
sudo pacman -S --needed pipewire pipewire-alsa pipewire-jack wireplumber pipewire-pulse gst-plugin-pipewire libpulse pipewire-x11-bell xdg-desktop-portal

#Apparmor
sudo pacman -S --needed apparmor python-notify2 python-psutil 
sudo systemctl enable apparmor.service
sudo touch /var/log/syslog
mkdir ~/.config/autostart
mv apparmor-notify.desktop ~/.config/autostart
sudo sed -i '34s/#//' /etc/apparmor/parser.conf
sudo chown henriqueffc:henriqueffc ~/.config/autostart

printf "\e[1;32mFim! Acrescente as instruções contidas em paBoot.txt nos parâmetros do boot. Reinicie o sistema.\e[0m"
