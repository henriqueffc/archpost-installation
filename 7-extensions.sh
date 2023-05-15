#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

sudo pacman -S aria2 libgtop lm_sensors git gettext unzip ninja meson jq eslint --needed --noconfirm

# Instalação das extensões

vap="53"
echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM"
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v$vap.zip
unzip gnome-shell-extension-appindicator-$vap.zip
meson setup ./gnome-shell-extension-appindicator-$vap /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install

vclip="1.3.4"
# Em caso de update altere a versão na linha 29 também.
echo -e "$AZUL Clipboard History $FIM"
aria2c https://github.com/SUPERCILEX/gnome-clipboard-history/archive/refs/tags/$vclip.zip
gnome-extensions install --force 'gnome-clipboard-history-1.3.4.zip'
make -C $HOME/.local/share/gnome-shell/extensions/clipboard-history@alexsaveau.dev

vfuz="5.0.14"
# Em caso de update altere a versão na linha 36 também.
echo -e "$AZUL Fuzzy App Search for GNOME $FIM"
aria2c https://gitlab.com/Czarlie/gnome-fuzzy-app-search/-/archive/v$vfuz/gnome-fuzzy-app-search-v$vfuz.zip
gnome-extensions install --force 'gnome-fuzzy-app-search-v5.0.14.zip'

vvit="61.0.0"
echo -e "$AZUL Vitals $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v$vvit/vitals.zip
gnome-extensions install --force 'vitals.zip'

vjust="24.0"
echo -e "$AZUL Just Perfection $FIM"
aria2c https://gitlab.gnome.org/jrahmatzadeh/just-perfection/-/archive/$vjust/just-perfection-$vjust.zip
unzip just-perfection-$vjust.zip
mv just-perfection-$vjust just-perfection
./just-perfection/scripts/build.sh
gnome-extensions install --force './just-perfection/just-perfection-desktop@just-perfection.shell-extension.zip'

vblur="46"
echo -e "$AZUL Blur My Shell $FIM"
wget https://github.com/aunetx/blur-my-shell/releases/download/v$vblur/blur-my-shell@aunetx.shell-extension.zip
gnome-extensions install --force 'blur-my-shell@aunetx.shell-extension.zip'

vappi="16"
echo -e "$AZUL App Icons Taskbar $FIM"
aria2c https://gitlab.com/AndrewZaech/aztaskbar/-/archive/v$vappi/aztaskbar-v$vappi.zip
unzip aztaskbar-v$vappi.zip
make install -C ./aztaskbar-v$vappi

echo -e "$AZUL Workspace indicator $FIM"
gnome-extensions enable workspace-indicator@gnome-shell-extensions.gcampax.github.com

sudo pacman -Rn ninja meson eslint

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
