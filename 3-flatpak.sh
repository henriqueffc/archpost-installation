#!/bin/bash

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
FIM='\e[0m'

echo -e "${AZUL}
-------------------------------------------------------------------------
                   Instalando os aplicativos Flatpaks
-------------------------------------------------------------------------
${FIM}"

# Flatpak Aplicativos
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub net.davidotek.pupgui2 -y
flatpak install flathub org.flozz.yoga-image-optimizer -y
flatpak install flathub org.gtkhash.gtkhash -y
flatpak install flathub com.github.rajsolai.textsnatcher -y
flatpak install flathub io.github.wereturtle.ghostwriter -y
flatpak install flathub org.gnome.Solanum -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.github.jeromerobert.pdfarranger -y
flatpak install flathub com.skype.Client -y
flatpak install flathub com.github.unrud.VideoDownloader -y
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

# Flatpak Remote-Beta
echo -ne "${VERDE}Você quer adicionar o remote Flathub Beta? (S) sim / (N) não ${FIM}"
read resposta
case "$resposta" in
     s|S|"")
      flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
      echo -e "${AZUL}Fim da instalação${FIM}"
     ;;
     n|N)
      echo -e "${AZUL}Fim da instalação${FIM}"
     ;;
     *)
      echo -e "${RED}Opção inválida${FIM}"
     ;;
esac
