#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
FIM='\e[0m'

echo -e "$AZUL
-------------------------------------------------------------------------
		    Instalando e habilitando o Podman
-------------------------------------------------------------------------
$FIM"

sudo pacman -Syu podman podman-compose fuse-overlayfs slirp4netns xorg-xhost --needed

UNPRIVILEGED=$(sysctl kernel.unprivileged_userns_clone | grep -o '[[:digit:]]*')
if [[ $UNPRIVILEGED == 1 ]]; then
	echo -e "$VERDE sysctl kernel.unprivileged_userns_clone = 1 $FIM"
	sudo touch /etc/subuid /etc/subgid
	sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$USERNAME"
	sudo podman system migrate
	mkdir $HOME/.config/containers/
	mv ./podman/registries.conf $HOME/.config/containers/

else
	echo -e "$RED O parametro kernel.unprivileged_userns_clone deve estar especificado como 1.
É preciso habilitá-lo usando o sysctl ou como um parâmetro para o kernel.$FIM"
	exit
fi

echo -e "$AZUL
-------------------------------------------------------------------------
	               Instalando o Distrobox
-------------------------------------------------------------------------
$FIM"

sudo pacman -S distrobox

echo -e "$AZUL
-------------------------------------------------------------------------
	                 Instalando o Pods
-------------------------------------------------------------------------
$FIM"

flatpak install flathub com.github.marhkb.Pods -y

# É necessário habilitar o podman.service para o funcionamento do Pods
sudo systemctl --user enable --now podman.service

printf "%s $VERDE Fim da instalação! $FIM \n"
