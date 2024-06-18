#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
FIM='\e[0m'

# Instalação dos aplicativos flatpaks
echo -e "$AZUL
-------------------------------------------------------------------------
                   Instalando os aplicativos Flatpaks
-------------------------------------------------------------------------
$FIM"

sudo pacman -Syu flatpak --needed --noconfirm

# Flatpak Aplicativos
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.vysp3r.ProtonPlus -y
flatpak install flathub io.gitlab.adhami3310.Converter -y
flatpak install flathub org.gtkhash.gtkhash -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.github.jeromerobert.pdfarranger -y
flatpak install flathub org.nickvision.tubeconverter -y
flatpak install flathub fr.romainvigier.MetadataCleaner -y
flatpak install flathub org.gnome.gitlab.YaLTeR.VideoTrimmer -y
flatpak install flathub com.belmoussaoui.Obfuscate -y
flatpak install flathub com.github.wwmm.easyeffects -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark -y
flatpak install flathub com.github.huluti.Curtail -y
flatpak install flathub io.github.nokse22.teleprompter -y
flatpak install flathub com.github.PintaProject.Pinta -y
flatpak install flathub com.dropbox.Client -y
flatpak install flathub com.github.dynobo.normcap -y
flatpak install flathub it.mijorus.gearlever -y
flatpak install flathub me.iepure.devtoolbox -y
flatpak install flathub com.github.ADBeveridge.Raider -y
flatpak install flathub org.gnome.World.PikaBackup -y
flatpak install flathub io.github.flattool.Warehouse -y
flatpak install flathub com.github.finefindus.eyedropper -y
flatpak install flathub com.github.johnfactotum.Foliate -y
flatpak install flathub fr.handbrake.ghb -y
flatpak install flathub fr.handbrake.ghb.Plugin.IntelMediaSDK -y
flatpak install flathub app.drey.Dialect -y
flatpak install flathub org.cryptomator.Cryptomator -y
flatpak install flathub io.github.fabrialberio.pinapp -y
flatpak install flathub info.febvre.Komikku -y
flatpak install flathub app.drey.KeyRack -y
flatpak install flathub com.belmoussaoui.Authenticator -y
flatpak install flathub de.haeckerfelix.Shortwave -y
flatpak install flathub org.gnome.Podcasts -y
flatpak install flathub org.gnome.gitlab.somas.Apostrophe -y
flatpak install flathub org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive -y
flatpak install flathub io.github.dvlv.boxbuddyrs -y
flatpak install flathub org.gnome.Fractal -y
flatpak install flathub garden.jamie.Morphosis -y
flatpak install flathub org.telegram.desktop -y

# Flathub Remote-Beta
echo -e "$AZUL
-------------------------------------------------------------------------
                 Adicionando o remote flathub-beta
-------------------------------------------------------------------------
$FIM"

flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo

# GNOME Nightly remote
echo -e "$AZUL
-------------------------------------------------------------------------
                 Adicionando o remote gnome-nightly
-------------------------------------------------------------------------
$FIM"

flatpak remote-add --if-not-exists gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo

# Configurações do tema e das variáveis para alguns aplicativos
echo -e "$AZUL Configurando o tema globalmente e as variáveis de alguns aplicativos flatpaks $FIM"

flatpak override --user --env=GSK_RENDERER=ngl org.gnome.gitlab.somas.Apostrophe
flatpak override --user --env=GSK_RENDERER=ngl com.github.johnfactotum.Foliate
flatpak override --user --socket=wayland io.podman_desktop.PodmanDesktop
flatpak override --user --filesystem=home io.github.dvlv.boxbuddyrs
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo flatpak override --filesystem=xdg-config/gtk-3.0

# Gnome Web - Flatpak
echo -e "$AZUL
-------------------------------------------------------------------------
           Trocando o Gnome Web para a versão em flatpak
-------------------------------------------------------------------------
$FIM"

sudo pacman -R epiphany --noconfirm
flatpak install flathub org.gnome.Epiphany -y
flatpak override --user --env=GSK_RENDERER=ngl org.gnome.Epiphany
