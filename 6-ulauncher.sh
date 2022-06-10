#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

#Pacotes
sudo pacman -S libappindicator-gtk3 wmctrl --needed

#Inicializar junto com o sistema
systemctl --user enable --now ulauncher

echo -e "$AZUL 
-------------------------------------------------------------------------
        	Iniciando as configurações do Ulauncher
-------------------------------------------------------------------------
$FIM" && sleep 9

#Copiando os ícones
tar -Jxxvf ./ulauncher/imagens.tar.xz -C ~/Imagens

#Backup das configurações 
cp ~/.config/ulauncher/settings.json ~/.config/ulauncher/settings.json.bak

#Movendo o arquivo das configurações dos atalhos
mv ./ulauncher/shortcuts.json ~/.config/ulauncher/

#Mudando a tecla de atalho / não é necessário. o atalho já foi definido nas configurações de atalhos de teclado do GNOME pelo script 2-pacote.sh
#sed -i 's/<Primary>space/\<Super>backslash/' ~/.config/ulauncher/settings.json

#Instalando as extenções
git clone https://github.com/leinardi/ulauncher-exit-gnome ~/.local/share/ulauncher/extensions/ulauncher-exit-gnome
git clone https://github.com/dalanicolai/gnome-tracker-extension ~/.local/share/ulauncher/extensions/gnome-tracker-extension
git clone https://github.com/fisadev/ulauncher-better-file-browser ~/.local/share/ulauncher/extensions/ulauncher-better-file-browser
git clone https://github.com/Doekeb/ulauncher-gnome-calculator ~/.local/share/ulauncher/extensions/ulauncher-gnome-calculator
git clone https://github.com/isacikgoz/ukill ~/.local/share/ulauncher/extensions/ukill
git clone https://github.com/friday/ulauncher-clipboard ~/.local/share/ulauncher/extensions/github-friday-ulauncher-clipboard
git clone https://github.com/KuenzelIT/ulauncher-firefox-bookmarks ~/.local/share/ulauncher/extensions/github-kuenzelit-ulauncher-firefox-bookmarks

#Instalando os temas
git clone https://github.com/dracula/ulauncher.git ~/.config/ulauncher/user-themes/dracula-ulauncher
git clone https://github.com/tom-james-watson/ulauncher-popdark.git ~/.config/ulauncher/user-themes/ulauncher-popdark
git clone https://github.com/lighttigerXIV/ulauncher-adwaita-gtk4/
cd ulauncher-adwaita-gtk4 
cp -r src/* ~/.config/ulauncher/user-themes/

#Substituindo o tema
sed -i 's/light/\popdark/' ~/.config/ulauncher/settings.json

printf "%s $VERDE Fim! O atalho para o Ulauncher foi defino no script 2-pacote.sh (Super + \). REINICIE o computador para que as mudanças sejam aplicadas no Ulauncher $FIM \n"
