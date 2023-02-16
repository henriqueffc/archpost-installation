#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

sudo pacman -S aria2 libgtop lm_sensors git bluez-utils gettext unzip ninja meson jq eslint --needed --noconfirm

# Instalação das extensões

echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM" 
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v46.zip
unzip gnome-shell-extension-appindicator-46.zip
meson setup ./gnome-shell-extension-appindicator-46 /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install

echo -e "$AZUL Clipboard History $FIM" 
aria2c https://github.com/SUPERCILEX/gnome-clipboard-history/archive/refs/tags/1.3.0.zip
gnome-extensions install --force 'gnome-clipboard-history-1.3.0.zip'
make -C $HOME/.local/share/gnome-shell/extensions/clipboard-history@alexsaveau.dev

echo -e "$AZUL Fuzzy App Search for GNOME $FIM"
aria2c https://gitlab.com/Czarlie/gnome-fuzzy-app-search/-/archive/v5.0.14/gnome-fuzzy-app-search-v5.0.14.zip
gnome-extensions install --force 'gnome-fuzzy-app-search-v5.0.14.zip'

echo -e "$AZUL Bluetooth Quick Connect $FIM"
aria2c https://github.com/bjarosze/gnome-bluetooth-quick-connect/archive/refs/tags/v33.zip
gnome-extensions install --force 'gnome-bluetooth-quick-connect-33.zip'
make -C $HOME/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com

echo -e "$AZUL Vitals $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v59.0.6/vitals.zip
gnome-extensions install --force 'vitals.zip'

echo -e "$AZUL Just Perfection $FIM"
aria2c https://gitlab.gnome.org/jrahmatzadeh/just-perfection/-/archive/23.0/just-perfection-23.0.zip
unzip just-perfection-23.0.zip
./just-perfection-23.0/scripts/build.sh
gnome-extensions install --force './just-perfection-23.0/just-perfection-desktop@just-perfection.shell-extension.zip'

echo -e "$AZUL Blur My Shell $FIM"
wget https://github.com/aunetx/blur-my-shell/releases/download/v44/blur-my-shell@aunetx.shell-extension.zip
gnome-extensions install --force 'blur-my-shell@aunetx.shell-extension.zip'

echo -e "$AZUL App Icons Taskbar $FIM"
aria2c https://gitlab.com/AndrewZaech/aztaskbar/-/archive/v14/aztaskbar-v14.zip
unzip aztaskbar-v14.zip
make install -C ./aztaskbar-v14

sudo pacman -Rn ninja meson jq eslint

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
