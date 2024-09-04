#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

# Add user nos grupos brlapi e wheel
sudo usermod -aG brlapi,wheel "$USERNAME"

echo -e "$AZUL
-------------------------------------------------------------------------
  Instalando os pacotes para Intel, Nvidia, áudio e pipewire/wireplumber. 
  Digite s (SIM) para todas as requisições feitas pelo sistema 
  para as instalações desses pacotes.
-------------------------------------------------------------------------
$FIM" && sleep 3

# Video (Intel e Nvidia)
sudo pacman --needed -Syu - <./pacotes/pkg-video.txt

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

# Fail2ban
sudo pacman -S fail2ban --needed --noconfirm
sudo mv ./fail2ban/jail.local /etc/fail2ban
sudo systemctl enable fail2ban.service

# Parâmetros do boot
cp /boot/loader/entries/*.conf ~/
sudo sed -i '$ { s/^.*$/& quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3 modprobe.blacklist=iTCO_wdt nowatchdog intel_pstate=active intel_iommu=on iommu=pt nvidia_drm.modeset=1 nvidia.NVreg_UsePageAttributeTable=1 nvidia.NVreg_EnableResizableBar=1 i915.enable_fbc=0 i915.enable_psr=0 i915.enable_dc=0 transparent_hugepage=madvise audit=1 audit_backlog_limit=800 lsm=landlock,lockdown,yama,integrity,apparmor,bpf/ }' /boot/loader/entries/*.conf

# O zswap.enabled=0 é configurado pelo archinstall, por isso não está definido nas opções acima.
# O scaling driver intel_pstate está definido como ativo. https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html / https://wiki.archlinux.org/title/CPU_frequency_scaling
# O meu notebook suporta o Sound Open Firmware, em razão disso o parâmetro snd_intel_dspcfg.dsp_driver=3 foi definido para o kernel. O pacote necessário para o firmware (sof-firmware) está na lista de pacotes para o Pipewire.

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
