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

sudo pacman -Syu podman podman-compose crun netavark aardvark-dns --needed

UNPRIVILEGED=$(sysctl kernel.unprivileged_userns_clone | grep -o '[[:digit:]]*')
if [[ $UNPRIVILEGED == 1 ]]; then
    echo -e "$VERDE sysctl kernel.unprivileged_userns_clone = 1 $FIM"
    sudo touch /etc/subuid /etc/subgid
    sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 "$USERNAME"
    sudo podman system migrate
    mkdir $HOME/.config/containers/
    cp ./podman/registries.conf $HOME/.config/containers/

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
	        	Instalando o Podman Desktop
-------------------------------------------------------------------------
$FIM"

flatpak install flathub io.podman_desktop.PodmanDesktop -y
flatpak override --user --socket=wayland io.podman_desktop.PodmanDesktop

echo -e "$AZUL
-------------------------------------------------------------------------
	                 Instalando o Incus
-------------------------------------------------------------------------
$FIM"

sudo pacman -S incus cdrtools lvm2 btrfs-progs xdelta3 incus-ui incus-tools --needed
sudo systemctl enable --now incus.socket
sudo usermod -aG incus-admin "$USERNAME"
sudo usermod -v 1000000-1000999999 -w 1000000-1000999999 root

echo -e "$AZUL
-------------------------------------------------------------------------
                         Instalando o Podlet
-------------------------------------------------------------------------
$FIM"

# Configurações para a pasta ~/bin (criação da pasta e path no .zshrc.local) foram feitas no script n.º 7.
# Coloquei o comando mkdir como um lembrete e para evitar algum erro caso a pasta não tenha sido criada anteriormente.
mkdir -p $HOME/bin
pkgver=0.3.0
wget https://github.com/containers/podlet/releases/download/v${pkgver}/podlet-x86_64-unknown-linux-gnu.tar.xz
tar -xf podlet-x86_64-unknown-linux-gnu.tar.xz
mv ./podlet-x86_64-unknown-linux-gnu/podlet ~/bin
rm podlet-x86_64-unknown-linux-gnu.tar.xz
rm -rf podlet-x86_64-unknown-linux-gnu

printf "%s $VERDE Fim da instalação! $FIM \n"
