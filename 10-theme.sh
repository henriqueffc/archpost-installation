#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

AZUL='\e[1;34m'
RED='\e[1;31m'
FIM='\e[0m'

# Dark Theme

if test -f "/usr/bin/flatpak"; then

	echo -e "$AZUL Flatpak instalado. Continuando a instalação. $FIM"

	# Tema do sistema GNOME 43
	gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

	# Gradience
	flatpak install flathub com.github.GradienceTeam.Gradience -y
	sudo flatpak override --filesystem=xdg-config/gtk-4.0

	# adw-gtk3
	wget https://github.com/lassekongo83/adw-gtk3/releases/download/v4.1/adw-gtk3v4-1.tar.xz
	sudo tar -xf adw-gtk3v4-1.tar.xz -C /usr/share/themes
	gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
	flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
	sudo flatpak override --filesystem=xdg-config/gtk-3.0
	echo -e "$AZUL Fim da instalação. $FIM"

else

	echo -e "$AZUL Flatpak não instalado. Faça a instalação do Flatpak para continuar. $FIM $RED sudo pacman -S flatpak && reboot $FIM"

fi
