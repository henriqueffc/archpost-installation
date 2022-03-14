#!/bin/bash

# Henrique Custódio
# https://github.com/henriqueffc
# 
# AVISO: Execute o script por sua conta e risco.

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando o YAY
-------------------------------------------------------------------------
${FIM}"

# YAY 
sudo pacman -S --needed git base-devel go wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando os pacotes AUR
-------------------------------------------------------------------------
${FIM}"

# Pacotes AUR
yay --needed -S - < ./pacotes/aur.txt


#Chrome (Wayland) 
while :;  do
      echo -ne "${VERDE}Você quer criar o arquivo chrome-flags.conf para uso do Google Chrome no Wayland?${FIM} ${LVERDE}(S) sim / (N) não ${FIM}"
      read resposta
case "$resposta" in
      s|S|"")
        mv ./chrome/chrome-flags.conf ~/.config
        echo -e "${AZUL}Arquivo criado${FIM}"; break;;
     n|N)
        break;;
     *)
        echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;
esac
done

printf "${VERDE}Fim! Reinicie o sistema.${FIM}\n"
