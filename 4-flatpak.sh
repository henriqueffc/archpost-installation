#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
FIM='\e[0m'

# Instalação dos aplicativos flatpaks
echo -e "$AZUL Instalando os aplicativos Flatpaks $FIM"

sudo pacman -Syu flatpak --needed --noconfirm

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Flatpak Aplicativos
flatpak install --user flathub com.vysp3r.ProtonPlus -y
flatpak install --user flathub com.github.tchx84.Flatseal -y
flatpak install --user flathub com.github.jeromerobert.pdfarranger -y
flatpak install --user flathub org.nickvision.tubeconverter -y
flatpak install --user flathub com.github.wwmm.easyeffects -y
flatpak install --user flathub org.gtk.Gtk3theme.Adwaita-dark -y
flatpak install --user flathub org.gtk.Gtk3theme.adw-gtk3 -y
flatpak install --user flathub org.gtk.Gtk3theme.adw-gtk3-dark -y
flatpak install --user flathub com.github.PintaProject.Pinta -y
flatpak install --user flathub it.mijorus.gearlever -y
flatpak install --user flathub me.iepure.devtoolbox -y
flatpak install --user flathub com.github.ADBeveridge.Raider -y
flatpak install --user flathub org.gnome.World.PikaBackup -y
flatpak install --user flathub io.github.flattool.Warehouse -y
flatpak install --user flathub com.github.finefindus.eyedropper -y
flatpak install --user flathub com.bilingify.readest -y
flatpak install --user flathub org.cryptomator.Cryptomator -y
flatpak install --user flathub info.febvre.Komikku -y
flatpak install --user flathub org.gnome.gitlab.somas.Apostrophe -y
flatpak install --user flathub org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive -y
flatpak install --user flathub com.ranfdev.DistroShelf -y
flatpak install --user flathub io.gitlab.theevilskeleton.Upscaler -y
flatpak install --user flathub nl.emphisia.icon -y
flatpak install --user flathub com.saivert.pwvucontrol -y
flatpak install --user flathub be.alexandervanhee.gradia -y
flatpak install --user flathub io.github.flattool.Ignition -y
flatpak install --user flathub io.github.fabrialberio.pinapp -y
flatpak install --user flathub io.github.vmkspv.lenspect -y
flatpak install --user flathub com.bitwarden.desktop -y
flatpak install --user flathub io.ente.auth -y
flatpak install --user flathub org.zdoom.UZDoom -y
flatpak install --user flathub io.github.dimtpap.coppwr -y
flatpak install --user flathub io.gitlab.metadatacleaner.metadatacleaner -y
flatpak install --user flathub app.drey.Warp -y
flatpak install --user flathub io.github.radiolamp.mangojuice -y
flatpak install --user flathub org.gnome.Podcasts -y
flatpak install --user flathub cx.modal.TestCenter -y
flatpak install --user flathub io.github.ronniedroid.concessio -y
flatpak install --user flathub org.gnome.Fractal -y

# Flathub Remote-Beta
echo -e "$AZUL Adicionando o remote flathub-beta $FIM"
flatpak remote-add --if-not-exists --user flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# GNOME Nightly remote
echo -e "$AZUL Adicionando o remote gnome-nightly $FIM"
flatpak remote-add --if-not-exists --user gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

# Configurações do tema,variáveis e permissões para aplicativos flatpaks
#echo -e "$AZUL Alterando variáveis para determinados apps flatpaks $FIM"

echo -e "$AZUL Configurando o tema globalmente para os apps flatpaks $FIM"
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --filesystem=xdg-config/gtk-3.0

echo -e "$AZUL Define como não permitida a execução em segundo plano para determinados apps flatpaks $FIM"
flatpak permission-set background background com.github.finefindus.eyedropper no
