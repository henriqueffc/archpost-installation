#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
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

# Apparmor
sudo pacman -S --needed apparmor python-notify2 python-psutil audit
sudo systemctl enable apparmor.service
sudo systemctl enable auditd.service
sudo cp /etc/audit/auditd.conf /etc/audit/auditd.conf.bak
sudo sed -i '$i log_group = wheel' /etc/audit/auditd.conf
install -Dvm644 ./apparmor/apparmor-notify.desktop -t ~/.config/autostart/
sudo cp /etc/apparmor/parser.conf /etc/apparmor/parser.conf.bak
sudo sed -i '/#write-cache/c\write-cache' /etc/apparmor/parser.conf

# Reabilitar o Wayland no GDM com o drive proprietário da Nvidia
sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

# Fail2ban
sudo pacman -S fail2ban --needed
sudo mv ./fail2ban/jail.local /etc/fail2ban
sudo systemctl enable fail2ban.service

# Parâmetros do boot
cp /boot/loader/entries/*.conf ~/
sudo sed -i '$ { s/^.*$/& nvidia-drm.modeset=1 nvidia.NVreg_EnablePCIeGen3=1 nvidia.NVreg_UsePageAttributeTable=1 i915.enable_guc=2 i915.enable_fbc=1 nouveau.modeset=0 audit=1 audit_backlog_limit=320 lsm=landlock,lockdown,yama,integrity,apparmor,bpf/ }' /boot/loader/entries/*.conf

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
