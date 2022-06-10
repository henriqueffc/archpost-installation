#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

# Grupos
sudo usermod -aG brlapi "$USERNAME"
sudo usermod -aG wheel "$USERNAME"

echo -e "$AZUL
-------------------------------------------------------------------------
  Instalando os pacotes para Intel, áudio e pipewire/wireplumber. 
  Digite S (SIM) para todas as requisições feitas pelo sistema 
  para as instalações desses pacotes.
-------------------------------------------------------------------------
$FIM" && sleep 3

# Video (Intel e Nvidia)
sudo pacman --needed -S - <./pacotes/pkg-video.txt

# Pipewire
sudo pacman --needed -S - <./pacotes/pipewire.txt

# Áudio - Codecs
sudo pacman --needed -S - <./pacotes/pkg-audio.txt

#Apparmor
sudo pacman -S --needed apparmor python-notify2 python-psutil
sudo systemctl enable apparmor.service
sudo touch /var/log/syslog
mkdir ~/.config/autostart
mv ./apparmor/apparmor-notify.desktop ~/.config/autostart
sudo sed -i '/#write-cache/c\write-cache' /etc/apparmor/parser.conf
sudo chown $USER:$USER ~/.config/autostart

#Mirrorlist atual
echo -e "$VERDE Mirrorlist atual $FIM"
cat /etc/pacman.d/mirrorlist

#Reabilitar o Wayland no GDM com o drive proprietário da Nvidia
sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

#Reflector
while :; do
    echo -ne "$VERDE 
Você quer executar o reflector para atualizar o mirrorlist?
Caso não tenha acontecido problemas na instalação dos pacotes não recomendamos a execução. $FIM  $LVERDE (S) sim / (N) não $FIM"
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
        echo -e "$AZUL Fim da instalação. $FIM"
        break
        ;;
    *)
        echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
        ;;
    esac
done

#Parâmetros do boot
cp /boot/loader/entries/*.conf ~/
sudo sed -i '$ { s/^.*$/& acpi_osi=! acpi_osi=Linux nvidia-drm.modeset=1 nvidia.NVreg_EnablePCIeGen3=1 nvidia.NVreg_UsePageAttributeTable=1 i915.enable_guc=2 i915.enable_fbc=1 nouveau.modeset=0 lsm=landlock,lockdown,yama,apparmor,bpf/ }' /boot/loader/entries/*.conf

printf "%s $VERDE Fim! Caso tenha instalado o AppArmor acrescente as instruções do arquivo -paBoot.txt/linha 7- nos parâmetros do boot e depois reinicie o sistema. Se você não instalou o Apparmor acrescente somente as instruções da linha 12 do mesmo arquivo e proceda com a reinicialização do sistema. $FIM \n"
