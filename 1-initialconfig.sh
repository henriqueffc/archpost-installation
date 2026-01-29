#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos
VERDE='\e[1;32m'
FIM='\e[0m'

# Localhost
cp /etc/hosts /etc/hosts.bak
line=$(cat /etc/hostname)
echo -e "127.0.1.1\t$line.localdomain\t$line" >>/etc/hosts

# Micro, nano, vim, Linux-firmware, lz4, wireless-regdb e headers para o kernel stable e lts
pacman -Syu micro nano vim linux-firmware linux-firmware-whence linux linux-headers linux-lts linux-lts-headers wireless-regdb lz4 --needed --noconfirm

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
sed -i 's/#Color/\Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/\VerbosePkgLists/' /etc/pacman.conf
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

printf "%s $VERDE Fim! Reinicie com o comando reboot. $FIM \n"
