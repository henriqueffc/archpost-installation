#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

echo -e "$AZUL
-------------------------------------------------------------------------
                   Fonte do Terminal - MesloLGS NF 14
-------------------------------------------------------------------------
$FIM"

echo -e "$AZUL Alterando a fonte e o tamanho do terminal em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando a fonte e o tamanho do terminal em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando a fonte e o tamanho do terminal em 3 $FIM" && sleep 1

#Fonte do terminal
font=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ font 'MesloLGS NF 14'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ visible-name 'Padrão'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-columns '106'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-rows '26'

echo -e "$AZUL
-------------------------------------------------------------------------
                   Instalando os aplicativos Flatpaks
-------------------------------------------------------------------------
$FIM"

# Flatpak Aplicativos
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub net.davidotek.pupgui2 -y
flatpak install flathub org.flozz.yoga-image-optimizer -y
flatpak install flathub org.gtkhash.gtkhash -y
flatpak install flathub com.github.rajsolai.textsnatcher -y
flatpak install flathub org.gnome.Solanum -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.github.jeromerobert.pdfarranger -y
flatpak install flathub com.skype.Client -y
flatpak install flathub com.github.unrud.VideoDownloader -y
flatpak install flathub org.linux_hardware.hw-probe -y
flatpak install flathub fr.handbrake.ghb -y
flatpak install flathub fr.romainvigier.MetadataCleaner -y
flatpak install flathub org.gnome.gitlab.YaLTeR.VideoTrimmer -y
flatpak install flathub io.github.arunsivaramanneo.GPUViewer -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub com.belmoussaoui.Obfuscate -y
flatpak install flathub com.system76.Popsicle -y
flatpak install flathub com.github.wwmm.easyeffects -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub org.gtk.Gtk3theme.Adwaita-dark -y
flatpak install flathub com.github.alexkdeveloper.dwxmlcreator -y
flatpak install flathub com.github.huluti.Curtail -y
flatpak install flathub de.haeckerfelix.Shortwave -y
flatpak install flathub org.gnome.TextEditor -y
flatpak install flathub com.github.micahflee.torbrowser-launcher -y
flatpak install flathub org.zotero.Zotero -y

# Flatpak Remote-Beta

while :; do
       echo -ne "$VERDE Você quer adicionar o remote Flathub Beta? $FIM $LVERDE (S) sim / (N) não $FIM"
       read -r resposta
       case "$resposta" in
       s | S | "")
              flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
              echo -e "$VERDE Fim da instalação. $FIM"
              break
              ;;
       n | N)
              echo -e "$VERDE Fim da instalação. $FIM"
              break
              ;;
       *)
              echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
              ;;
       esac
done

echo -e "$AZUL
-------------------------------------------------------------------------
                 Instalando o tema do Midnight Commander
-------------------------------------------------------------------------
$FIM"

aria2c https://raw.githubusercontent.com/dracula/midnight-commander/master/skins/dracula256.ini
mkdir -p ~/.local/share/mc/skins
mv dracula256.ini ~/.local/share/mc/skins
sed -i 's/marked = rgb253;color0/\marked = color0;rgb253/' ~/.local/share/mc/skins/dracula256.ini
