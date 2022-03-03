#!/bin/bash

echo -ne "
-------------------------------------------------------------------------
                    Instalando o YAY
-------------------------------------------------------------------------
"

# YAY 
sudo pacman -S --needed git base-devel go wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

echo -ne "
-------------------------------------------------------------------------
                    Instalando os pacotes AUR
-------------------------------------------------------------------------
"

# Pacotes AUR
yay -S google-chrome dropbox appimagelauncher visual-studio-code-bin heroic-games-launcher-bin ulauncher timeshift downgrade inxi ttf-ms-fonts mangohud lib32-mangohud qgnomeplatform goverlay-bin


#Chrome (Wayland) 
echo -n "Você quer criar o arquivo chrome-flags.conf para uso do Google Chrome no Wayland? (S) sim / (N) não "
read resposta
case "$resposta" in
     s|S|"")
      mv $HOME/archpost-installation/chrome/chrome-flags.conf ~/.config
      echo "Arquivo criado"
     ;;
     n|N)
      echo "Fim da instalação"
     ;;
     *)
      echo "Opção inválida"
     ;;
esac


printf "\e[1;32mFim! Reinicie o sistema.\e[0m"
