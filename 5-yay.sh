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
yay -S - <./pacotes/aur.txt

# asdf-vm
echo 'source /opt/asdf-vm/asdf.sh' >>$HOME/.bashrc
echo -e 'python system\njava system\nnodejs system\nrust system' >>$HOME/.tool-versions

# Heroic Games Launcher
cp /usr/share/applications/heroic.desktop ~/.local/share/applications/
sed -i 's|Exec=.*|Exec=/opt/Heroic/heroic --enable-features=CanvasOopRasterization --enable-zero-copy --force_low_power_gpu --disable-gpu-driver-bug-workarounds %U|g' ~/.local/share/applications/heroic.desktop

# Ananicy-cpp
sudo systemctl enable --now ananicy-cpp.service

# nautilus-open-any-terminal
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal tabby

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
