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

#Deletar a antiga pasta no /
sudo rm -r /archpost-installation

# Grupos
sudo usermod -aG brlapi "$USERNAME"
sudo usermod -aG wheel "$USERNAME"

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando os pacotes
-------------------------------------------------------------------------
${FIM}"

# Video (Intel e Nvidia)
sudo pacman --needed -S - <./pacotes/pkg-video.txt

# Áudio
sudo pacman --needed -S - <./pacotes/pkg-audio.txt

# Pipeware
sudo pacman --needed -S - <./pacotes/pipeware.txt

#Apparmor
while :; do
    echo -ne "${VERDE}Você quer instalar o Apparmor?${FIM} ${LVERDE}(S) sim / (N) não ${FIM}"
    read -r resposta
    case "$resposta" in
    s | S | "")
        sudo pacman -S --needed apparmor python-notify2 python-psutil
        sudo systemctl enable apparmor.service
        sudo touch /var/log/syslog
        mkdir ~/.config/autostart
        mv ./apparmor/apparmor-notify.desktop ~/.config/autostart
        sudo sed -i '/#write-cache/c\write-cache' /etc/apparmor/parser.conf
        sudo chown $USER:$USER ~/.config/autostart
        break
        ;;
    n | N)
        echo -e "${AZUL}Finalizando a instalação${FIM}"
        break
        ;;
    *)
        echo -e "${RED}Opção inválida${FIM}"
        ;;
    esac
done

#Mirrorlist atual
echo -e "${AZUL}Mirrorlist atual${FIM}"
cat /etc/pacman.d/mirrorlist

#Reflector
while :; do
    echo -ne "${AZUL}
Você quer executar o reflector para atualizar o mirrorlist?
Caso não tenha acontecido problemas na instalação dos pacotes não recomendamos a execução.${FIM}  ${LVERDE}(S) sim / (N) não ${FIM}"
    read -r resposta
    case "$resposta" in
    s | S | "")
        sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak2
        sudo pacman -S --needed --noconfirm reflector rsync
        sudo reflector -c Brazil -a 12 --sort rate --save /etc/pacman.d/mirrorlist
        sudo pacman -Syyu
        break
        ;;
    n | N)
        echo -e "${AZUL}Fim da instalação${FIM}"
        break
        ;;
    *)
        echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}"
        ;;
    esac
done

printf "${VERDE}Fim! Caso tenha instalado o AppArmor acrescente as instruções do arquivo -paBoot.txt/linha 7- nos parâmetros do boot e depois reinicie o sistema. Se você não instalou o Apparmor acrescente somente as instruções da linha 12 do mesmo arquivo e proceda com a reinicialização do sistema.${FIM}\n"
