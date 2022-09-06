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

# Localhost
line=$(cat /etc/hostname)
echo '127.0.0.1 localhost' >>/etc/hosts
echo '::1       localhost' >>/etc/hosts
echo "127.0.1.1 $line.localdomain $line" >>/etc/hosts

# Visudo
sed -i '/# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL' /etc/sudoers
echo '# Defaults specification' >>/etc/sudoers
echo 'Defaults editor=/usr/bin/nano' >>/etc/sudoers

# Caso queira o vim ao invés do nano, comente (#) a linha acima e descomente a linha abaixo.
# echo 'Defaults editor=/usr/bin/vim' >>/etc/sudoers

# Pacman.conf
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '/#UseSyslog/c\UseSyslog' /etc/pacman.conf
sed -i 's/#Color/\Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/\VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/\ParallelDownloads = 5/' /etc/pacman.conf
sed -i 's/#CheckSpace/\CheckSpace/' /etc/pacman.conf
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

#Firefox
echo 'MOZ_ENABLE_WAYLAND=1' >>/etc/environment
echo 'MOZ_WAYLAND_DRM_DEVICE=/dev/dri/renderD128' >>/etc/environment
echo 'MOZ_WAYLAND_USE_VAAPI=1' >>/etc/environment
echo 'LIBVA_DRIVERS_PATH=/usr/lib/dri/' >>/etc/environment
echo 'LIBVA_DRIVER_NAME=iHD' >>/etc/environment
echo 'MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0' >>/etc/environment
echo 'CLUTTER_PAINT=disable-dynamic-max-render-time' >>/etc/environment
echo 'EGL_PLATFORM=wayland' >>/etc/environment
echo 'VDPAU_DRIVER=va_gl' >>/etc/environment

#PC speaker - turn off beep shutdown
echo 'blacklist pcspkr' >/etc/modprobe.d/nobeep.conf

# NANO - Line number e syntax-highlighting
sed -i 's/# set linenumbers/\set linenumbers/' /etc/nanorc
sed -i 's/# set speller "aspell -x -c"/\set speller "aspell -x -c"/' /etc/nanorc
linenumber=$(cat /etc/nanorc | grep -n '*.nanorc' | gawk '{print $1}' FS=":")
sed -i "${linenumber}s/..//" /etc/nanorc

# Swappiness
mv ./swappiness/99-swappiness.conf /etc/sysctl.d/

# Makeflags e compress
nv=$(nproc --ignore=2)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nv\"/g" /etc/makepkg.conf
sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z --threads=0 -)/g' /etc/makepkg.conf
sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q --threads=0 -)/g' /etc/makepkg.conf
 

#Mirrorlist
echo -e "$AZUL
-------------------------------------------------------------------------
                        Mirrorlist - Brasil
-------------------------------------------------------------------------
$FIM"

while :; do
     cat mirrorlistbr/mirrorlist
     echo -ne "$VERDE Você quer alterar o mirrorlist do sistema de acordo com o exposto acima? $FIM $LVERDE (S) sim / (N) não $FIM"
     read -r resposta
     case "$resposta" in
     s | S | "")
          mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
          mv ./mirrorlistbr/mirrorlist /etc/pacman.d/
          echo -e "$AZUL Fim da instalação. $FIM"
          break
          ;;
     n | N)
          echo -e "$AZUL Fim da instalação. $FIM"
          break
          ;;
     *)
          echo -e "$RED Opção inválida. $FIM"
          ;;
     esac
done

pacman -Syy --noconfirm

#Intel - i915 / mkinitcpio.conf
sed -i 's/MODULES=.*/MODULES=(intel_agp i915)/g' /etc/mkinitcpio.conf
mkinitcpio -P

#FSTAB
sudo cp /etc/fstab ~/
sudo sed -i 's/relatime/noatime/' /etc/fstab

printf "%s $VERDE Fim! Reinicie com o comando reboot. $FIM \n"
