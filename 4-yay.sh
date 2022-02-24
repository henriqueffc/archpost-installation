#!/bin/bash

#Chrome (Wayland) 
mv chrome-flags.conf ~/.config

# YAY 
sudo pacman -S --needed git base-devel go wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Pacotes AUR
yay -S google-chrome dropbox jstest-gtk-git appimagelauncher visual-studio-code-bin heroic-games-launcher-bin ulauncher timeshift downgrade inxi ttf-ms-fonts mangohud lib32-mangohud qgnomeplatform

printf "\e[1;32mFim! Reinicie o sistema.\e[0m"
