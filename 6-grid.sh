#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Office/ name "Office"
dconf load /org/gnome/desktop/app-folders/folders/Office/ <./grid/office.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Programas/ name "Programas"
dconf load /org/gnome/desktop/app-folders/folders/Programas/ <./grid/programas.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Jogos/ name "Jogos"
dconf load /org/gnome/desktop/app-folders/folders/Jogos/ <./grid/jogos.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/GNOME/ name "GNOME"
dconf load /org/gnome/desktop/app-folders/folders/GNOME/ <./grid/gnome.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ name "Internet"
dconf load /org/gnome/desktop/app-folders/folders/Internet/ <./grid/internet.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name "Development"
dconf load /org/gnome/desktop/app-folders/folders/Development/ <./grid/development.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Nvidia/ name "Nvidia"
dconf load /org/gnome/desktop/app-folders/folders/Nvidia/ <./grid/nvidia.txt

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Multimídia/ name "Multimídia"
dconf load /org/gnome/desktop/app-folders/folders/Multimídia/ <./grid/multimidia.txt

dconf load /org/gnome/desktop/app-folders/folders/Utilities/ <./grid/utilities.txt

gsettings set org.gnome.desktop.app-folders folder-children "['Utilities', 'Office', 'Programas', 'Jogos', 'Nvidia', 'Development', 'GNOME', 'Internet', 'Multimídia']"

# Dock
gsettings set org.gnome.shell favorite-apps "['footclient.desktop', 'obsidian.desktop', 'brave-origin.desktop', 'org.gnome.Evolution.desktop', 'zotero.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Nautilus.desktop']"

# Search Providers
dconf load /org/gnome/desktop/search-providers/ <./dconf/search-providers.txt

# Configurações para a extensão Vitals (repo oficial - instalada pelo script nº 3)
dconf load /org/gnome/shell/extensions/vitals/ <./dconf/vitals.txt

# Configuração para a extensão Alphabetical App Grid (AUR - instalada pelo script nº 5)
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'start'

# Habilitando as extensões
gnome-extensions enable AlphabeticalAppGrid@stuarthayhurst
gnome-extensions enable Vitals@CoreCoding.com
gnome-extensions enable azwallpaper@azwallpaper.gitlab.com

# Definindo os aplicativos padrão em ~/.config/mimeapps.list

cp ~/.config/mimeapps.list ~/.config/mimeapps.list.bak

set_default() { # uso: set_default app.desktop 'regex-dos-tipos'
    local app=$1 filter=$2
    grep -h '^MimeType=' /usr/share/applications/"$app" |
        cut -d= -f2 | tr ';' '\n' | grep -E "$filter" |
        while read -r t; do xdg-mime default "$app" "$t"; done
}

xdg-settings set default-web-browser brave-origin.desktop
xdg-mime default org.gnome.Evolution.desktop x-scheme-handler/mailto text/calendar x-scheme-handler/webcal
set_default mpv.desktop '^(audio|video)/'
set_default org.gnome.gthumb.desktop '^image/'
xdg-mime default org.gnome.TextEditor.desktop text/markdown application/json application/x-shellscript
xdg-mime default org.gnome.FileRoller.desktop application/zip application/vnd.rar application/x-compressed-tar application/x-xz-compressed-tar
