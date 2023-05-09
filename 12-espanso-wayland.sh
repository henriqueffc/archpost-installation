#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Instalação do Espanso

yay espanso-wayland

# Inicialização do Espanso

espanso service register

# Mudança do laytout do teclado para br

echo -e "\n keyboard_layout:" >>$HOME/.config/espanso/config/default.yml
echo "  { layout: br }" >>$HOME/.config/espanso/config/default.yml
echo " search_shortcut: ALT+SHIFT+SPACE" >>$HOME/.config/espanso/config/default.yml
echo " show_notifications: false" >>$HOME/.config/espanso/config/default.yml
