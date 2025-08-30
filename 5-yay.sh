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

# Importanto a chave pública do Dropbox
# Pode evitar erros durante a instalação do Dropbox
curl -fsSL https://linux.dropbox.com/fedora/rpm-public-key.asc -o dropbox-key.asc
gpg --import dropbox-key.asc
rm dropbox-key.asc

# Pacotes AUR
yay -Y --gendb
yay -Y --devel --save
sudo pacman -S cmake meson ninja vulkan-headers --noconfirm --needed
yay --removemake --answerclean A --noanswerdiff --noansweredit --noconfirm --needed -S - <./pacotes/aur.txt

# Habilitando o Ananicy-cpp (instalado pelo script n.° 3) com as regras existentes no pacote cachyos-ananicy-rules-git (AUR)
sudo systemctl enable --now ananicy-cpp.service

printf "%s $VERDE Reinicie o sistema. $FIM \n"
