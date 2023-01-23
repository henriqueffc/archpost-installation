#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

echo -e "$AZUL
-------------------------------------------------------------------------
		    Instalando e habilitando o Podman
-------------------------------------------------------------------------
$FIM"

sudo pacman -S podman podman-compose fuse-overlayfs slirp4netns xorg-xhost --needed

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
	 Instalando o Distrobox, a imagem do Ubuntu e o Spotify
-------------------------------------------------------------------------
$FIM"

curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
distrobox-create --name ubuntu --image ubuntu:22.04
sed -i 's/distrobox enter ubuntu/\distrobox enter --name ubuntu -- bash -l/' ~/.local/share/applications/ubuntu.desktop
distrobox-enter ubuntu -- sudo apt update
distrobox-enter ubuntu -- sudo apt -y upgrade
distrobox-enter ubuntu -- sudo apt -y install neofetch nano exa bat ripgrep git thefuck tzdata curl wget
distrobox-enter ubuntu -- wget https://github.com/wimpysworld/deb-get/releases/download/0.3.6/deb-get_0.3.6-1_all.deb
distrobox-enter ubuntu -- sudo apt-get install ./deb-get_0.3.6-1_all.deb
# Preferi instalar o Spotify usando o distrobox para testes. O repositório oficial do Arch Linux possui o pacote "spotify-launcher" para a instalação do Spotify. 
distrobox-enter ubuntu -- deb-get install spotify-client

# Copiar script para a pasta ~/bin
mv ./bin/update-ubuntu ~/bin
chmod +x ~/bin/update-ubuntu

# Atalho no Grid. O comando "distrobox-export --app spotify" não funcionou na instalação do Spotify.
mv ./desktop/spotify.desktop ~/.local/share/applications

# Criando o perfil no Gnome Terminal (atalho do teclado criado no script número 3)
dconf load /org/gnome/terminal/legacy/profiles:/:0e137972-e494-484f-bcb9-7d629397a19f/ < ./desktop/ubuntu.dconf
font=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.ProfilesList list "['$font', '0e137972-e494-484f-bcb9-7d629397a19f']"

printf "%s $VERDE Fim! Super + U abre o terminal do GNOME com o Ubuntu$FIM \n"
