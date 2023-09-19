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

vap="56"
echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM"
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v$vap.zip
unzip gnome-shell-extension-appindicator-$vap.zip
meson setup ./gnome-shell-extension-appindicator-$vap /tmp/g-s-appindicators-build
ninja -C /tmp/g-s-appindicators-build install

vvit="61.0.1"
echo -e "$AZUL Vitals $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v$vvit/vitals.zip
gnome-extensions install --force 'vitals.zip'

vjust="26.0"
echo -e "$AZUL Just Perfection $FIM"
aria2c https://gitlab.gnome.org/jrahmatzadeh/just-perfection/-/archive/$vjust/just-perfection-$vjust.zip
unzip just-perfection-$vjust.zip
mv just-perfection-$vjust just-perfection
./just-perfection/scripts/build.sh
gnome-extensions install --force './just-perfection/just-perfection-desktop@just-perfection.shell-extension.zip'

vblur="47"
echo -e "$AZUL Blur My Shell $FIM"
wget https://github.com/aunetx/blur-my-shell/archive/refs/tags/v$vblur.zip
unzip v$vblur.zip
make install -C ./blur-my-shell-$vblur
rm v$vblur.zip
rm -rf ./blur-my-shell-$vblur

vappi="18"
echo -e "$AZUL App Icons Taskbar $FIM"
aria2c https://gitlab.com/AndrewZaech/aztaskbar/-/archive/v$vappi/aztaskbar-v$vappi.zip
unzip aztaskbar-v$vappi.zip
make install -C ./aztaskbar-v$vappi

echo -e "$AZUL IdeaPad $FIM"
mkdir $HOME/.local/share/gnome-shell/extensions/ideapad@laurento.frittella
git -C $HOME/.local/share/gnome-shell/extensions/ideapad@laurento.frittella clone https://github.com/laurento/gnome-shell-extension-ideapad.git
make -C $HOME/.local/share/gnome-shell/extensions/ideapad@laurento.frittella/gnome-shell-extension-ideapad
sudo echo "%wheel ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/platform/drivers/ideapad_acpi/VPC????\:??/conservation_mode" | sudo tee /etc/sudoers.d/ideapad

echo -e "$AZUL Clipboard Indicator $FIM"
git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com

sudo pacman -Rn ninja meson eslint

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
