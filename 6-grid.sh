#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ name "Office"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ apps "['libreoffice-math.desktop', 'libreoffice-writer.desktop', 'libreoffice-impress.desktop', 'libreoffice-draw.desktop', 'libreoffice-calc.desktop', 'org.kde.okular.desktop', 'libreoffice-startcenter.desktop', 'libreoffice-base.desktop', 'com.github.jeromerobert.pdfarranger.desktop', 'ghostwriter.desktop', 'com.calibre_ebook.calibre.desktop', 'com.calibre_ebook.calibre.ebook-edit.desktop', 'com.calibre_ebook.calibre.ebook-viewer.desktop', 'com.calibre_ebook.calibre.lrfviewer.desktop', 'org.zotero.Zotero.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Programas/ name "Programas"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Programas/ apps "['org.gnome.Firmware.desktop', 'veracrypt.desktop', 'bitwarden.desktop', 'gparted.desktop', 'gufw.desktop', 'transmission-gtk.desktop', 'vlc.desktop', 'org.gnome.tweaks.desktop', 'org.gtkhash.gtkhash.desktop', 'firetools.desktop', 'firejail-ui.desktop', 'alacarte.desktop', 'com.github.tchx84.Flatseal.desktop', 'com.mattjakeman.ExtensionManager.desktop', 'gnome-appfolders-manager.desktop', 'org.linux_hardware.hw-probe.desktop', 'ca.desrt.dconf-editor.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Jogos/ name "Jogos"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Jogos/ apps "['steam.desktop', 'heroic.desktop', 'net.lutris.Lutris.desktop', 'com.usebottles.bottles.desktop', 'io.github.benjamimgois.goverlay.desktop', 'com.discordapp.Discord.desktop', 'net.davidotek.pupgui2.desktop', 'winetricks.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/GNOME/ name "GNOME"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/GNOME/ apps "['org.gnome.Contacts.desktop', 'org.gnome.Maps.desktop', 'org.gnome.Photos.desktop', 'org.gnome.Weather.desktop', 'org.gnome.Totem.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Polari.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Extensions.desktop', 'yelp.desktop', 'org.gnome.Cheese.desktop', 'simple-scan.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Music.desktop', 'org.gnome.dfeet.desktop', 'gnome-nettool.desktop', 'org.gnome.Meld.desktop', 'org.gnome.GHex.desktop', 'org.gnome.Characters.desktop', 'org.gnome.font-viewer.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ name "Internet"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ apps "['us.zoom.Zoom.desktop', 'com.skype.Client.desktop', 'com.github.micahflee.torbrowser-launcher.settings.desktop', 'com.github.micahflee.torbrowser-launcher.desktop', 'chromium.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimídia/ name "Multimídia"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimídia/ apps "['org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop', 'com.github.maoschanz.drawing.desktop', 'org.gnome.SoundRecorder.desktop', 'com.obsproject.Studio.desktop', 'com.belmoussaoui.Obfuscate.desktop', 'fr.handbrake.ghb.desktop', 'com.github.unrud.VideoDownloader.desktop', 'upscayl.desktop', 'fr.romainvigier.MetadataCleaner.desktop', 'de.haeckerfelix.Shortwave.desktop', 'com.github.wwmm.easyeffects.desktop', 'com.github.huluti.Curtail.desktop', 'org.flozz.yoga-image-optimizer.desktop', 'org.gimp.GIMP.desktop', 'org.kde.kdenlive.desktop']"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ apps "['org.gnome.Logs.desktop', 'org.gnome.baobab.desktop', 'org.gnome.DiskUtility.desktop', 'gsmartcontrol.desktop', 'kdiskmark.desktop', 'org.gnome.eog.desktop', 'org.gnome.Evince.desktop', 'org.gnome.FileRoller.desktop', 'htop.desktop', 'bssh.desktop', 'bvnc.desktop', 'avahi-discover.desktop', 'qvidcap.desktop', 'vim.desktop', 'qv4l2.desktop', 'remote-viewer.desktop', 'assistant.desktop', 'designer.desktop', 'qdbusviewer.desktop', 'electron19.desktop', 'linguist.desktop']"

gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'YaST', 'Office', 'Programas', 'Jogos', 'GNOME', 'Internet', 'Multimídia']"
