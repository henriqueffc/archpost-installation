#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Instalação do Espanso

yay espanso-wayland

# Inicialização do Espanso

espanso service start --unmanaged

# Execução do Espanso 20 segundos após inicialização do Gnome. Não será usada a opção padrão pelo systemd. Pois, quando usada, na inicialização do Gnome ela apresenta um irritante ícone no centro da tela. Prefiro usar o método abaixo.

mv ./espanso/espanso.desktop $HOME/.config/autostart

# Mudança do laytout do teclado para br

echo -e "\n keyboard_layout:" >>$HOME/.config/espanso/config/default.yml
echo -e "  { layout: br }" >>$HOME/.config/espanso/config/default.yml

# Reinicialização do Espanso
espanso service start --unmanaged
