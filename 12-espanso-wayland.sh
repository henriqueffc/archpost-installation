#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Instalação do Espanso

yay espanso-wayland

# Mudança do laytout do teclado para br

cat ./espanso/espanso.txt >> $HOME/.config/espanso/config/default.yml

# Execução do Espanso 20 segundos após inicialização do Gnome. Não será usada a opção padrão pelo systemd. Pois, quando usada, na inicialização do Gnome ela apresenta um irritante ícone no centro da tela. Prefiro usar o método abaixo.

mv ./espanso/espanso.desktop $HOME/.config/autostart

# Inicialização do Espanso

espanso service start --unmanaged
