#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

echo -e "$AZUL
-------------------------------------------------------------------------
                    Instalando o YAY
-------------------------------------------------------------------------
$FIM"

# YAY
sudo pacman -Syu --needed git base-devel go wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

echo -e "$AZUL
-------------------------------------------------------------------------
                    Instalando os pacotes AUR
-------------------------------------------------------------------------
$FIM"

# Pacotes AUR
yay -Y --gendb
yay -Y --devel --save
sudo pacman -S cmake meson ninja vulkan-headers --noconfirm --needed
yay -S - <./pacotes/aur.txt

# Habilitando o Ananicy-cpp (instalado pelo script n.° 3) com as regras existentes no pacote cachyos-ananicy-rules-git (AUR)
sudo systemctl enable --now ananicy-cpp.service

# Tema dos ícones - Kora
gsettings set org.gnome.desktop.interface icon-theme "kora"

# Albert
sudo pacman -S libqalculate openbsd-netcat plocate --needed
cp /usr/share/applications/albert.desktop ~/.config/autostart
albert </dev/null &>/dev/null &

printf "%s $VERDE Configure o Albert e depois reinicie o sistema. O atalho de teclado para o Albert é Ctrl+espaço $FIM \n"
