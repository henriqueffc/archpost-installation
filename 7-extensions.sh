#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

sudo pacman -S aria2 libgtop lm_sensors git bluez-utils --needed --noconfirm

# Instalação das extensões

echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM" 
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v46.zip
gnome-extensions install --force 'gnome-shell-extension-appindicator-46.zip'

echo -e "$AZUL Clipboard History $FIM" 
aria2c https://github.com/SUPERCILEX/gnome-clipboard-history/archive/refs/tags/1.3.0.zip
gnome-extensions install --force 'gnome-clipboard-history-1.3.0.zip'
make -C $HOME/.local/share/gnome-shell/extensions/clipboard-history@alexsaveau.dev

echo -e "$AZUL Fuzzy App Search for GNOME $FIM"
aria2c https://gitlab.com/Czarlie/gnome-fuzzy-app-search/-/archive/v5.0.14/gnome-fuzzy-app-search-v5.0.14.zip
gnome-extensions install --force 'gnome-fuzzy-app-search-v5.0.14.zip'

echo -e "$AZUL Bluetooth Quick Connect $FIM"
aria2c https://github.com/bjarosze/gnome-bluetooth-quick-connect/archive/refs/tags/v32.zip
gnome-extensions install --force 'gnome-bluetooth-quick-connect-32.zip'
make -C $HOME/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com

echo -e "$AZUL Vitals $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v59.0.6/vitals.zip
gnome-extensions install --force 'vitals.zip'

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
