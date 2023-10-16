#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

sudo pacman -S aria2 libappindicator-gtk3 libgtop lm_sensors git gettext unzip ninja meson jq eslint --needed --noconfirm

# Instalação das extensões

vap="57"
echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM"
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v$vap.zip
unzip gnome-shell-extension-appindicator-$vap.zip
meson setup ./gnome-shell-extension-appindicator-$vap /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install

vvit="63.0.0"
echo -e "$AZUL Vitals $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v$vvit/vitals.zip
gnome-extensions install --force 'vitals.zip'

vow="45"
echo -e "$AZUL No overview at start-up $FIM"
aria2c https://github.com/fthx/no-overview/archive/refs/tags/v$vow.zip -o no-overview.zip
gnome-extensions install --force 'no-overview.zip'

echo -e "$AZUL Clipboard Indicator $FIM"
git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com

sudo pacman -Rn ninja meson eslint jq

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
