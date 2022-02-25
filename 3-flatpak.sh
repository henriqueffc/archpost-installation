#!/bin/bash

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
echo -n "Você quer adicionar o remote Flathub Beta? (S) sim / (N) não "
read resposta
case "$resposta" in
     s|S|"")
      flatpak remote-add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
     ;;
     n|N)
         echo "Fim da instalaç"
     ;;
     *)
         echo "Opção inválida"
     ;;
esac
