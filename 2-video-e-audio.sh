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
sudo pacman -S apparmor python-notify2 python-psutil audit --needed --noconfirm
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
sudo pacman -S fail2ban --needed --noconfirm
sudo mv ./fail2ban/jail.local /etc/fail2ban
sudo systemctl enable fail2ban.service

# Parâmetros do boot
cp /boot/loader/entries/*.conf ~/
sudo sed -i '$ { s/^.*$/& nowatchdog intel_pstate=active nvme_core.default_ps_max_latency_us=0 nvidia-drm.modeset=1 nvidia.NVreg_EnablePCIeGen3=1 nvidia.NVreg_UsePageAttributeTable=1 i915.enable_dc=0 i915.enable_guc=2 i915.enable_fbc=0 i915.enable_psr=0 nouveau.modeset=0 audit=1 audit_backlog_limit=500 lsm=landlock,lockdown,yama,integrity,apparmor,bpf/ }' /boot/loader/entries/*.conf

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
