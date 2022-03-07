#!/bin/bash

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
FIM='\e[0m'

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando o YAY
-------------------------------------------------------------------------
${FIM}"

# YAY 
sudo pacman -S --needed git base-devel go wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando os pacotes AUR
-------------------------------------------------------------------------
${FIM}"

# Pacotes AUR
yay -S google-chrome dropbox appimagelauncher visual-studio-code-bin heroic-games-launcher-bin ulauncher timeshift downgrade inxi ttf-ms-fonts mangohud lib32-mangohud qgnomeplatform goverlay-bin


#Chrome (Wayland) 
echo -ne "${VERDE}Você quer criar o arquivo chrome-flags.conf para uso do Google Chrome no Wayland? (S) sim / (N) não ${FIM}"
read resposta
case "$resposta" in
     s|S|"")
      mv $HOME/archpost-installation/chrome/chrome-flags.conf ~/.config
      echo -e "${AZUL}Arquivo criado${FIM}"
     ;;
     n|N)
      echo -e "${AZUL}Fim da instalação${FIM}"
     ;;
     *)
      echo -e "${RED}Opção inválida${FIM}"
     ;;
esac


printf "${VERDE}Fim! Reinicie o sistema.${FIM}\n"
