#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

sudo pacman -S aria2 libgtop lm_sensors git --needed

# Instalação das extensões

echo -e "$AZUL No overview at start-up $FIM"
aria2c https://github.com/fthx/no-overview/archive/refs/tags/v11.zip
gnome-extensions install --force 'no-overview-11.zip'

echo -e "$AZUL AppIndicator and KStatusNotifierItem Support $FIM" 
aria2c https://github.com/ubuntu/gnome-shell-extension-appindicator/archive/refs/tags/v42.zip
gnome-extensions install --force 'gnome-shell-extension-appindicator-42.zip'

echo -e "$AZUL Sound Input & Output Device Chooser $FIM"
git clone https://github.com/kgshank/gse-sound-output-device-chooser.git
cp -r gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net .
mv sound-output-device-chooser@kgshank.net $HOME/.local/share/gnome-shell/extensions
rm -rf "gse-sound-output-device-chooser"

echo -e "$AZUL Clipboard History $FIM" 
aria2c https://github.com/SUPERCILEX/gnome-clipboard-history/archive/refs/tags/1.2.1.zip
gnome-extensions install --force 'gnome-clipboard-history-1.2.1.zip'
make -C $HOME/.local/share/gnome-shell/extensions/clipboard-history@alexsaveau.dev

echo -e "$AZUL Vitals  $FIM" 
aria2c https://github.com/corecoding/Vitals/releases/download/v54.0.4/vitals.zip
gnome-extensions install --force 'vitals.zip'

#Só funcionará depois de reinicializar o sistema. Melhor habilitar as extensões pelo programa Extensões do GNOME após a reinicialização do sistema.
#gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
#gnome-extensions enable no-overview@fthx
#gnome-extensions enable clipboard-history@alexsaveau.dev
#gnome-extensions enable sound-output-device-chooser@kgshank.net
#gnome-extensions enable Vitals@CoreCoding.com

printf "%s $VERDE Fim! Reinicie com o comando reboot e habilite as extensões usando o app Extensões após a reinicialização do sistema $FIM \n"
