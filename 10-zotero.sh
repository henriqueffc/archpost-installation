#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

AZUL='\e[1;34m'
FIM='\e[0m'

wget -O zotero.tar.bz2 -c "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64"

tar -vxf zotero.tar.bz2

sudo mv ./Zotero_linux-x86_64 /opt

cat <<EOF >zotero.desktop
[Desktop Entry]
Name=Zotero
Exec=/opt/Zotero_linux-x86_64/zotero -url %U
Icon=/opt/Zotero_linux-x86_64/icons/icon128.png
Type=Application
Terminal=false
Categories=Office;
MimeType=text/plain;x-scheme-handler/zotero;application/x-research-info-systems;text/x-research-info-systems;text/ris;application/x-endnote-refer;application/x-inst-for-Scientific-info;application/mods+xml;application/rdf+xml;application/x-bibtex;text/x-bibtex;application/marc;application/vnd.citationstyles.style+xml
X-GNOME-SingleWindow=true
EOF

sudo mv zotero.desktop ~/.local/share/applications/

rm zotero.tar.bz2

echo -e "$AZUL Fim da instalação. $FIM"
