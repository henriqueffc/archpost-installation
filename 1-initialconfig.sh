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
#sed -i 's/#CheckSpace/\CheckSpace/' /etc/pacman.conf (já é padrão pelo archinstall)
#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf (habilito na instalação do sistema pelo archinstall)

# Environment
cp /etc/environment /etc/environment.bak
echo 'MOZ_ENABLE_WAYLAND=1' >>/etc/environment
echo 'EGL_PLATFORM=wayland' >>/etc/environment
echo 'VDPAU_DRIVER=va_gl' >>/etc/environment
echo 'QT_QPA_PLATFORM="wayland;xcb"' >>/etc/environment
echo 'QT_QPA_PLATFORMTHEME=qt6ct' >>/etc/environment
echo 'GDK_BACKEND="wayland,x11"' >>/etc/environment
echo 'SDL_VIDEODRIVER="wayland,x11"' >>/etc/environment
echo 'SDL_AUDIODRIVER=pipewire' >>/etc/environment
echo 'CLUTTER_BACKEND=wayland' >>/etc/environment
echo 'CLUTTER_DEFAULT_FPS=60' >>/etc/environment
echo 'PROTON_ENABLE_NVAPI=1' >>/etc/environment
echo '__GL_SHADER_DISK_CACHE=1' >>/etc/environment
echo '__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1' >>/etc/environment
echo '__GL_ExperimentalPerfStrategy=1' >>/etc/environment
echo 'mesa_glthread=true' >>/etc/environment
echo 'FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"' >>/etc/environment
echo 'FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"' >>/etc/environment
echo 'GST_PLUGIN_FEATURE_RANK=vah264dec:MAX,vah265dec:MAX,vavp9dec:MAX,vavp8dec:MAX,vampeg2dec:MAX,av1dec:NONE' >>/etc/environment
echo 'ANV_VIDEO_DECODE=1' >>/etc/environment
echo 'VK_DRIVER_FILES=/usr/share/vulkan/icd.d/intel_icd.x86_64.json' >>/etc/environment
echo '__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json:/usr/share/glvnd/egl_vendor.d/10_nvidia.json' >>/etc/environment
echo 'ELECTRON_OZONE_PLATFORM_HINT=wayland' >>/etc/environment
echo 'MUTTER_ALLOW_HYBRID_GPUS=1' >>/etc/environment

# PC speaker - turn off beep shutdown e desabilitar o Bluetooth
echo -e 'blacklist pcspkr\nblacklist btusb' >/etc/modprobe.d/blacklist.conf

# Linux-firmware e wireless-regdb
pacman -Syu linux-firmware linux-firmware-whence wireless-regdb --needed --noconfirm

# NANO - Line number e syntax-highlighting
pacman -S nano --needed --noconfirm
cp /etc/nanorc /etc/nanorc.bak
sed -i 's/# set linenumbers/\set linenumbers/' /etc/nanorc
sed -i 's/# set mouse/\set mouse/' /etc/nanorc
sed -i 's/# set minibar/\set minibar/' /etc/nanorc
sed -i 's/# set indicator/\set indicator/' /etc/nanorc
sed -i 's/# set speller "aspell -x -c"/\set speller "aspell -x -c"/' /etc/nanorc
linenumber=$(cat /etc/nanorc | grep -n '*.nanorc' | gawk '{print $1}' FS=":")
sed -i "${linenumber}s/..//" /etc/nanorc

# Configurações para o kernel
mv ./sysctl/99-sysctl.conf /etc/sysctl.d/

# udev.rules
## Ioschedulers
## Reabilitar o Wayland no GDM com o drive proprietário da Nvidia
mv ./udev/*.rules /etc/udev/rules.d/
ln -s /dev/null /etc/udev/rules.d/61-gdm.rules

# Makeflags e compress
cp /etc/makepkg.conf /etc/makepkg.conf.bak
nv=$(nproc --ignore=2)
sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nv\"/g" /etc/makepkg.conf
sed -i 's/-march=x86-64 -mtune=generic/-march=native/g' /etc/makepkg.conf
sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z --threads=0 -)/g' /etc/makepkg.conf

# HOOKS / mkinitcpio.conf
cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak
sed -i 's/HOOKS=.*/HOOKS=(systemd autodetect microcode modconf kms keyboard sd-vconsole block filesystems fsck)/g' /etc/mkinitcpio.conf
echo 'MODULES_DECOMPRESS="yes"' >>/etc/mkinitcpio.conf
mkinitcpio -P

# FSTAB
cp /etc/fstab /etc/fstab.bak
sed -i 's/relatime/noatime/' /etc/fstab

printf "%s $VERDE Fim! Reinicie com o comando reboot. $FIM \n"
