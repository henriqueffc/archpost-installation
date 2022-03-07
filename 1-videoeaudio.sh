#!/bin/bash

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
FIM='\e[0m'

#Deletar a antiga pasta no /
sudo rm -r /archpost-installation

# Grupos
sudo usermod -aG brlapi $USERNAME
sudo usermod -aG wheel $USERNAME

echo -e "${AZUL}
-------------------------------------------------------------------------
                    Instalando os pacotes
-------------------------------------------------------------------------
${FIM}"

# Video (Intel e Nvidia)
sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings opencl-nvidia vulkan-icd-loader libvdpau-va-gl libva-vdpau-driver libvdpau vulkan-tools ocl-icd mesa mesa-vdpau libva vdpauinfo libva-utils intel-ucode intel-media-sdk lib32-mesa vulkan-intel intel-media-driver intel-compute-runtime intel-graphics-compiler nvidia-prime clinfo nvtop

# Audio
sudo pacman -S --needed vlc ffmpeg gst-plugins-ugly gst-plugins-good gst-plugins-base gst-plugins-bad gst-libav gstreamer-vaapi gstreamer a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore

# Pipeware
sudo pacman -S --needed pipewire pipewire-alsa pipewire-jack wireplumber pipewire-pulse gst-plugin-pipewire libpulse pipewire-x11-bell xdg-desktop-portal

#Apparmor
echo -ne "${VERDE}Você quer instalar o Apparmor? (S) sim / (N) não ${FIM}"
read resposta
case "$resposta" in
     s|S|"")
        sudo pacman -S --needed apparmor python-notify2 python-psutil 
        sudo systemctl enable apparmor.service
        sudo touch /var/log/syslog
        mkdir ~/.config/autostart
        mv $HOME/archpost-installation/apparmor/apparmor-notify.desktop ~/.config/autostart
        sudo sed -i '34s/#//' /etc/apparmor/parser.conf
        sudo chown $USER:$USER ~/.config/autostart
     ;;
     n|N)
         echo -e "${AZUL}Finalizando a instalação${FIM}"
     ;;
     *)
         echo -e "${RED}Opção inválida${FIM}"
     ;;
esac

#Mirrorlist atual
echo -e "${AZUL}Mirrorlist atual${FIM}"
cat /etc/pacman.d/mirrorlist

#Reflector
echo -ne "${AZUL}
Você quer executar o reflector para atualizar o mirrorlist?
Caso não tenha acontecido problemas na instalação dos pacotes não recomendamos a execução.  (S) sim / (N) não 
${FIM}"
read resposta
case "$resposta" in
     s|S|"")
         sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak2
         sudo pacman -S --needed --noconfirm reflector rsync
         sudo reflector -c Brazil -a 12 --sort rate --save /etc/pacman.d/mirrorlist
         sudo pacman -Syyu
     ;;
     n|N)
         echo -e "${AZUL}Fim da instalação${FIM}"
     ;;
     *)
         echo -e "${RED}Opção inválida${FIM}"
     ;;
esac

printf "${VERDE}Fim! Caso tenha instalado o AppArmor acrescente as instruções do arquivo -paBoot.txt/linha 7- nos parâmetros do boot e depois reinicie o sistema. Se você não instalou o Apparmor acrescente somente as instruções da linha 12 do mesmo arquivo e proceda com a reinicialização do sistema.${FIM}"
