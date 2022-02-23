#!/bin/bash

# Reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo pacman -S --needed --noconfirm reflector rsync
sudo reflector -c Brazil -a 12 -p --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu

# Video (Intel e Nvidia)
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader libvdpau-va-gl libva-vdpau-driver libvdpau vulkan-tools libglvnd lib32-libglvnd lib32-opencl-nvidia lib32-libva-vdpau-driver ocl-icd lib32-ocl-icd mesa mesa-vdpau lib32-mesa-vdpau libva lib32-libva vdpauinfo libva-utils lib32-libvdpau intel-ucode intel-media-sdk lib32-mesa vulkan-intel lib32-vulkan-intel intel-media-driver intel-compute-runtime intel-graphics-compiler nvidia-prime clinfo nvtop

# Audio
sudo pacman -S --needed vlc ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer-vaapi gstreamer a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore

# Pipeware
sudo pacman -S --needed pipewire pipewire-alsa pipewire-jack wireplumber pipewire-pulse gst-plugin-pipewire libpulse pipewire-x11-bell xdg-desktop-portal

#Apparmor
sudo pacman -S --needed apparmor python-notify2 python-psutil 
sudo systemctl enable apparmor.service
sudo touch /var/log/syslog
sudo mkdir ~/.config/autostart
sudo mv apparmor-notify.desktop ~/.config/autostart
sudo sed -i '34s/#//' /etc/apparmor/parser.conf

printf "\e[1;32mFim! Acrescente as instruções contidas em paBoot.txt nos parâmetros do boot. Reinicie o sistema.\e[0m"
