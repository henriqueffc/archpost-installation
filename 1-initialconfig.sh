#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos
AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

# 1. Verifica se é root
if [ "$EUID" -ne 0 ]; then
    echo "Erro: Este primeiro script precisa ser executado como root."
    echo "Por favor, mude para o usuário root usando 'su' e execute o script novamente."
    echo "Leia o README do projeto para mais detalhes"
    exit 1
fi

# 2. Verifica se foi invocado via sudo
if [ -n "$SUDO_USER" ]; then
    echo "Erro: Este primeiro script NÃO deve ser executado via 'sudo'."
    echo "Por favor, mude para o usuário root usando 'su' e execute o script novamente."
    echo "Leia o README do projeto para mais detalhes"
    exit 1
fi

# Localhost
cp /etc/hosts /etc/hosts.bak
line=$(cat /etc/hostname)
echo -e "127.0.1.1\t$line.localdomain\t$line" >>/etc/hosts

# Micro, nano, vim, Linux-firmware, lz4, wireless-regdb e headers para o kernel stable e lts
pacman -Syu micro nano vim linux-firmware linux-firmware-whence linux linux-headers linux-lts linux-lts-headers linux-zen linux-zen-headers scx-tools wireless-regdb lz4 --needed --noconfirm

# Visudo
cp /etc/sudoers /etc/sudoers.bak
sed -i '/# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL' /etc/sudoers
echo -e "# Enable insults\nDefaults insults" >>/etc/sudoers
echo -e "# Defaults specification\nDefaults editor=/usr/bin/micro" >>/etc/sudoers
# Caso queira o vim ao invés do micro, comente (#) a linha acima e descomente a linha abaixo.
# echo 'Defaults editor=/usr/bin/vim' >>/etc/sudoers

# Pacman.conf
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/#UseSyslog/c\UseSyslog' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/\VerbosePkgLists/' /etc/pacman.conf
if command -v grep "#Color" /etc/pacman.conf >/dev/null; then
    sed -i 's/#Color/\Color/' /etc/pacman.conf
fi
if [ ! -f /var/lib/pacman/sync/multilib.db ]; then
    sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
    pacman -Syu
fi

# Environment
mkdir -p /etc/environment.d/
mv ./environment/90-environment.conf /etc/environment.d/

# PC speaker - turn off beep shutdown
echo -e 'blacklist pcspkr' >/etc/modprobe.d/blacklist.conf

# Configurações para o kernel
cp ./sysctl/99-sysctl.conf /etc/sysctl.d/

# udev.rules
## Ioschedulers
cp ./udev/*.rules /etc/udev/rules.d/

# Makeflags
cp /etc/makepkg.conf /etc/makepkg.conf.bak
nv=$(nproc --ignore=2)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nv\"/g" /etc/makepkg.conf
sed -i 's/-march=x86-64 -mtune=generic/-march=native/g' /etc/makepkg.conf

# RUSTFLAGS
cp /etc/makepkg.conf.d/rust.conf /etc/makepkg.conf.d/rust.conf.bak
sed -i 's/-C force-frame-pointers=yes/-C force-frame-pointers=yes -C target-cpu=native/g' /etc/makepkg.conf.d/rust.conf

# HOOKS / mkinitcpio.conf
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
sed -i 's/MODULES=.*/MODULES=(i915 nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g' /etc/mkinitcpio.conf
sed -i 's/HOOKS=.*/HOOKS=(systemd autodetect microcode modconf keyboard sd-vconsole block filesystems fsck)/g' /etc/mkinitcpio.conf
sed -i 's/#COMPRESSION="lz4"/COMPRESSION="lz4"/g' /etc/mkinitcpio.conf
sed -i 's/#MODULES_DECOMPRESS="no"/MODULES_DECOMPRESS="yes"/g' /etc/mkinitcpio.conf
mkinitcpio -P

# zram
cp /etc/systemd/zram-generator.conf /etc/systemd/zram-generator.conf.bak
cp ./zram/zram-generator.conf /etc/systemd/zram-generator.conf

echo -e "$AZUL
-------------------------------------------------------------------------
  Instalando os pacotes para Intel, Nvidia, áudio e pipewire/wireplumber.
  Digite s (SIM) para todas as requisições feitas pelo sistema
  para as instalações desses pacotes.
-------------------------------------------------------------------------
$FIM" && sleep 3

# Video (Intel e Nvidia)
pacman --needed -S - <./pacotes/pkg-video.txt

# Pipewire
pacman --needed -S - <./pacotes/pipewire.txt

# Áudio - Codecs
pacman --needed -S - <./pacotes/pkg-audio.txt

# Parâmetros do boot
# O zswap.enabled=0 é configurado pelo archinstall, por isso não está definido nas opções acima.
# O notebook suporta o Sound Open Firmware, em razão disso o parâmetro snd_intel_dspcfg.dsp_driver=3 foi definido para o kernel. O pacote necessário para o firmware (sof-firmware) está na lista de pacotes para o Pipewire.
# O scaling driver intel_pstate está definido como ativo. https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html / https://wiki.archlinux.org/title/CPU_frequency_scaling
mkdir -p /etc/entries.kernel/
cp /boot/loader/entries/*.conf /etc/entries.kernel/
sed -i '$ { s/^.*$/& quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3 modprobe.blacklist=iTCO_wdt nowatchdog intel_pstate=active intel_iommu=on iommu=pt nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_EnableResizableBar=1 i915.enable_fbc=0 i915.enable_psr=0 i915.enable_dc=0 snd_intel_dspcfg.dsp_driver=3 transparent_hugepage=madvise pcie_aspm.policy=performance audit=1 audit_backlog_limit=1200 lsm=landlock,lockdown,yama,integrity,apparmor,bpf/ }' /boot/loader/entries/*.conf
echo -e "$AZUL Os backups das entries dos kernels estão em /etc/entries.kernel/ $FIM"

printf "%s $VERDE Fim! Reinicie com o comando reboot. $FIM \n"
