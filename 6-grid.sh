#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ name "Office"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ apps "['libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'info.febvre.Komikku.desktop', 'gimagereader-gtk.desktop', 'com.github.xournalpp.xournalpp.desktop', 'io.github.nokse22.teleprompter.desktop', 'com.github.dynobo.normcap.desktop', 'com.github.jeromerobert.pdfarranger.desktop', 'com.github.johnfactotum.Foliate.desktop', 'org.kde.okular.desktop', 'app.drey.Dialect.desktop', 'org.kde.ghostwriter.desktop', 'libreoffice-draw.desktop', 'libreoffice-impress.desktop', 'libreoffice-base.desktop', 'libreoffice-math.desktop', 'libreoffice-startcenter.desktop', 'calibre-gui.desktop', 'calibre-ebook-edit.desktop', 'calibre-ebook-viewer.desktop', 'calibre-lrfviewer.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Programas/ name "Programas"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Programas/ apps "['org.gnome.World.PikaBackup.desktop', 'app.drey.KeyRack.desktop', 'app.drey.Warp.desktop', 'it.mijorus.gearlever.desktop', 'org.gnome.Firmware.desktop', 'firewall-config.desktop', 'veracrypt.desktop', 'com.github.finefindus.eyedropper.desktop', 'com.github.ADBeveridge.Raider.desktop', 'gparted.desktop', 'org.gtkhash.gtkhash.desktop', 'io.github.flattool.Warehouse.desktop', 'com.github.tchx84.Flatseal.desktop', 'com.mattjakeman.ExtensionManager.desktop', 'gnome-appfolders-manager.desktop', 'alacarte.desktop', 'io.github.fabrialberio.pinapp.desktop', 'scrcpy.desktop', 'scrcpy-console.desktop', 'it.cuteworks.pacmanlogviewer.desktop', 'qt5ct.desktop', 'qt6ct.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Jogos/ name "Jogos"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Jogos/ apps "['steam.desktop', 'heroic.desktop', 'io.github.benjamimgois.goverlay.desktop', 'com.vysp3r.ProtonPlus.desktop', 'winetricks.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/GNOME/ name "GNOME"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/GNOME/ apps "['org.gnome.Contacts.desktop', 'org.gnome.Maps.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Weather.desktop', 'org.gnome.Totem.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Extensions.desktop', 'simple-scan.desktop', 'org.gnome.Snapshot.desktop', 'org.gnome.tweaks.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Music.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Characters.desktop', 'org.gnome.GHex.desktop', 'org.gnome.Meld.desktop', 'org.gnome.dfeet.desktop', 'org.gnome.font-viewer.desktop', 'yelp.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Console.desktop', 'org.gnome.Loupe.desktop', 'org.gnome.eog.desktop', 'org.gnome.Logs.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.Connections.desktop', 'org.gnome.Cheese.desktop', 'org.gnome.Tour.desktop', 'org.gnome.baobab.desktop', 'org.gnome.Evince.desktop', 'org.gnome.FileRoller.desktop', 'org.gnome.Sysprof.desktop', 'ca.desrt.dconf-editor.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ name "Internet"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ apps "['weechat.desktop', 'chromium.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name "Development"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ apps "['io.podman_desktop.PodmanDesktop.desktop', 'me.iepure.devtoolbox.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Nvidia/ name "Nvidia"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Nvidia/ apps "['nvidia-settings.desktop', 'nvtop.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimídia/ name "Multimídia"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimídia/ apps "['org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop', 'io.github.celluloid_player.Celluloid.desktop', 'com.github.PintaProject.Pinta.desktop', 'org.shotcut.Shotcut.desktop', 'audacity.desktop', 'com.obsproject.Studio.desktop', 'com.belmoussaoui.Obfuscate.desktop', 'fr.handbrake.ghb.desktop', 'com.github.unrud.VideoDownloader.desktop', 'fr.romainvigier.MetadataCleaner.desktop', 'com.github.wwmm.easyeffects.desktop', 'com.github.huluti.Curtail.desktop', 'mpv.desktop', 'org.pipewire.Helvum.desktop', 'vlc.desktop', 'io.gitlab.adhami3310.Converter.desktop', 'org.gimp.GIMP.desktop', 'soundconverter.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['gtk-lshw.desktop', 'yazi.desktop', 'gsmartcontrol.desktop', 'kdiskmark.desktop', 'btop.desktop', 'htop.desktop', 'bssh.desktop', 'bvnc.desktop', 'avahi-discover.desktop', 'qvidcap.desktop', 'vim.desktop', 'qv4l2.desktop', 'remote-viewer.desktop', 'assistant.desktop', 'designer.desktop', 'lstopo.desktop', 'qdbusviewer.desktop', 'electron28.desktop', 'linguist.desktop']"

gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'YaST', 'Office', 'Programas', 'Jogos', 'Nvidia', 'Development', 'GNOME', 'Internet', 'Multimídia']"

# Dock
gsettings set org.gnome.shell favorite-apps "['org.wezfurlong.wezterm.desktop', 'org.mozilla.Thunderbird.desktop', 'microsoft-edge.desktop', 'obsidian.desktop', 'org.gnome.Rhythmbox3.desktop', 'org.gnome.Nautilus.desktop']"

# Nautilus Bookmarks
mkdir ~/ToDo/
mkdir ~/Documentos/Projetos
echo "file:///home/$USER/Documentos/Projetos 🎒 Projetos" >>~/.config/gtk-3.0/bookmarks
echo "file:///home/$USER/ToDo 🗒 ToDo" >>~/.config/gtk-3.0/bookmarks
