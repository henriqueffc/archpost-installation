#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

AZUL='\e[1;34m'
FIM='\e[0m'

echo -e "$AZUL Selecione o número do pacote AUR com o nome espanso-wayland $FIM" && sleep 3

# Instalação do Espanso

yay espanso-wayland

echo -e "$AZUL Ao aparecer a janela de instalação do Espanso clique em Start. Não demore em clicar, senão a instalação será interrompida $FIM" && sleep 7

# Inicialização do Espanso

espanso service register

# Inicializando o Espanso

espanso start

# Mudança do laytout do teclado para br

echo -e "\n keyboard_layout:" >>$HOME/.config/espanso/config/default.yml
echo "  { layout: br }" >>$HOME/.config/espanso/config/default.yml
echo " search_shortcut: ALT+SHIFT+SPACE" >>$HOME/.config/espanso/config/default.yml
echo " show_notifications: false" >>$HOME/.config/espanso/config/default.yml

# Atalhos personalizados

mv ./espanso/*.yml $HOME/.config/espanso/match/packages

# Alterações no arquivo base.yml

sed -i 's|%m/%d/%Y|%d/%m/%Y|g' $HOME/.config/espanso/match/base.yml
sed -i 's|:date|;date;|g' $HOME/.config/espanso/match/base.yml
sed -i 's|:espanso|;espanso;|g' $HOME/.config/espanso/match/base.yml
sed -i 's|:shell|;shell;|g' $HOME/.config/espanso/match/base.yml
