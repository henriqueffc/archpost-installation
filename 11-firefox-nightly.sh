#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

AZUL='\e[1;34m'
FIM='\e[0m'

wget -O firefox-nightly.tar.bz2 -c "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=pt-BR"

tar -vxf firefox-nightly.tar.bz2

mv firefox firefox-nightly

sudo mv firefox-nightly /opt

sudo ln -s /opt/firefox-nightly/firefox-bin /usr/bin/firefox-nightly

sudo ln -s /opt/firefox-nightly/browser/chrome/icons/default/default128.png /usr/share/pixmaps/firefox-nightly.png

cat <<EOF >firefox-nightly.desktop
[Desktop Entry]
Version=1.0
Name=Firefox Nightly
GenericName=Navegador Web
Comment=Navegue na Internet
Exec=firefox-nightly %u
Icon=/opt/firefox-nightly/browser/chrome/icons/default/default128.png
Terminal=false
Type=Application
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=firefox-nightly
Categories=Network;WebBrowser;
Keywords=web;browser;internet;
Actions=new-window;new-private-window;profile-manager-window;

[Desktop Action new-window]
Name=Nova janela
Exec=firefox-nightly --new-window --class="firefox-nightly" %u

[Desktop Action new-private-window]
Name=Nova janela privativa
Exec=firefox-nightly --private-window --class="firefox-nightly" %u

[Desktop Action profile-manager-window]
Name=Open the Profile Manager
Exec=firefox-nightly --ProfileManager 
EOF

sudo mv firefox-nightly.desktop /usr/share/applications

rm firefox-nightly.tar.bz2

echo -e "$AZUL Fim da instalação. $FIM"
