#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
FIM='\e[0m'

# Localhost
cp /etc/hosts /etc/hosts.bak
line=$(cat /etc/hostname)
echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$line.localdomain\t$line" >>/etc/hosts

# Visudo
cp /etc/sudoers /etc/sudoers.bak
sed -i '/# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL' /etc/sudoers
echo -e "# Defaults specification\nDefaults editor=/usr/bin/nano" >>/etc/sudoers
echo -e "# Enable insults\nDefaults insults" >>/etc/sudoers

# Caso queira o vim ao invés do nano, comente (#) a linha acima e descomente a linha abaixo.
# echo 'Defaults editor=/usr/bin/vim' >>/etc/sudoers

# Pacman.conf
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/#UseSyslog/c\UseSyslog' /etc/pacman.conf
sed -i 's/#Color/\Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/\VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/\ParallelDownloads = 5/' /etc/pacman.conf
sed -i 's/#CheckSpace/\CheckSpace/' /etc/pacman.conf
#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Environment
cp /etc/environment /etc/environment.bak
echo 'MOZ_ENABLE_WAYLAND=1' >>/etc/environment
echo 'MOZ_WAYLAND_DRM_DEVICE=/dev/dri/renderD128' >>/etc/environment
echo 'MOZ_WAYLAND_USE_VAAPI=1' >>/etc/environment
echo 'LIBVA_DRIVERS_PATH=/usr/lib/dri/' >>/etc/environment
echo 'LIBVA_DRIVER_NAME=iHD' >>/etc/environment
echo 'MUTTER_DEBUG_FORCE_KMS_MODE=simple' >>/etc/environment
echo 'CLUTTER_PAINT=disable-dynamic-max-render-time' >>/etc/environment
echo 'EGL_PLATFORM=wayland' >>/etc/environment
echo 'VDPAU_DRIVER=va_gl' >>/etc/environment
echo 'QT_QPA_PLATFORM=wayland' >>/etc/environment

# PC speaker - turn off beep shutdown
echo 'blacklist pcspkr' >/etc/modprobe.d/nobeep.conf

# Linux-firmware
pacman -S linux-firmware linux-firmware-whence --needed

# NANO - Line number e syntax-highlighting
pacman -Syu nano --needed --noconfirm
cp /etc/nanorc /etc/nanorc.bak
sed -i 's/# set linenumbers/\set linenumbers/' /etc/nanorc
sed -i 's/# set speller "aspell -x -c"/\set speller "aspell -x -c"/' /etc/nanorc
linenumber=$(cat /etc/nanorc | grep -n '*.nanorc' | gawk '{print $1}' FS=":")
sed -i "${linenumber}s/..//" /etc/nanorc

# Swappiness
mv ./swappiness/99-swappiness.conf /etc/sysctl.d/

# udev.rules
mv ./udev/60-ioschedulers.rules /etc/udev/rules.d/

# Makeflags e compress
cp /etc/makepkg.conf /etc/makepkg.conf.bak
nv=$(nproc --ignore=2)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nv\"/g" /etc/makepkg.conf
sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z --threads=0 -)/g' /etc/makepkg.conf
sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q --threads=0 -)/g' /etc/makepkg.conf

# Mirrorlist
echo -e "$AZUL
-------------------------------------------------------------------------
                        Alterando o mirrorlist
-------------------------------------------------------------------------
$FIM"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
cat ./mirrorlistbr/mirrorlist >/etc/pacman.d/mirrorlist
pacman -Syu

# Intel - i915 / mkinitcpio.conf
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
sed -i 's/MODULES=.*/MODULES=(i915)/g' /etc/mkinitcpio.conf
mkinitcpio -P

# FSTAB
cp /etc/fstab /etc/fstab.bak
sed -i 's/relatime/noatime/' /etc/fstab

printf "%s $VERDE Fim! Reinicie com o comando reboot. $FIM \n"
