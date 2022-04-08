#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
#
# AVISO: Execute o script por sua conta e risco.

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

# Locale.gen
sed -i 's/#pt_BR.UTF-8 UTF-8/\pt_BR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Vconsole.conf (Já foi configurado pelo Archinstall)
# echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

# Idioma e Localhost
echo 'LANG=pt_BR.UTF-8' >/etc/locale.conf
#echo "archlinux" > /etc/hostname (já foi feito pelo Archinstall)
line=$(cat /etc/hostname)
echo '127.0.0.1 localhost' >>/etc/hosts
echo '::1       localhost' >>/etc/hosts
echo "127.0.1.1 $line.localdomain $line" >>/etc/hosts

# Visudo
sed -i '/# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL' /etc/sudoers
echo '# Defaults specification' >>/etc/sudoers
echo 'Defaults editor=/usr/bin/nano' >>/etc/sudoers

# Caso queira o vim ao invés do nano, comente (#) a linha acima e descomente a linha abaixo.
# echo "Defaults editor=/usr/bin/vim" >> /etc/sudoers

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

# NANO - Line number e syntax-highlighting
sed -i 's/# set linenumbers/\set linenumbers/' /etc/nanorc
linenumber=$(cat /etc/nanorc | grep -n '*.nanorc' | gawk '{print $1}' FS=":")
sed -i "${linenumber}s/..//" /etc/nanorc

# Swappiness
mv ./swappiness/99-swappiness.conf /etc/sysctl.d/

# Makeflags e compress
nc=$(grep -c ^processor /proc/cpuinfo)
nv=$(nproc --ignore=2)
RAM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
echo -e "$AZUL
-------------------------------------------------------------------------
		     MAKEFLAGS e compressão XZ e ZSTD
	  O sistema possui o total de $nc cores e $RAM de ram
-------------------------------------------------------------------------
$FIM"

while :; do
     echo -ne "$VERDE Você quer estabelecer a MAKEFLAGS em /etc/makepkg.conf com o número total de cores do sistema ($nc) ou com dois cores a menos que o total do sistema ($nv)?
Se o sistema possuir menos que 8G de ram ou menos que 4 cores pule essa etapa. $FIM $LVERDE (T) total / (M) menor / (P) Pular $FIM"
     read -r resposta
     case "$resposta" in
     t | T | "")
          sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nc\"/g" /etc/makepkg.conf
          sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z --threads=0 -)/g' /etc/makepkg.conf
          sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q --threads=0 -)/g' /etc/makepkg.conf
          echo -e "$AZUL Continuando a instalação. $FIM"
          break
          ;;
     m | M)
          sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$nv\"/g" /etc/makepkg.conf
          sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z --threads=0 -)/g' /etc/makepkg.conf
          sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q --threads=0 -)/g' /etc/makepkg.conf
          echo -e "$AZUL Continuando a instalação. $FIM"
          break
          ;;
     p | P)
          echo -e "$AZUL Pulando essa etapa e continuando a instalação. $FIM"
          break
          ;;
     *)
          echo -e "$RED Opção inválida. $FIM"
          ;;
     esac
done

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

pacman -Syy --noconfirm --needed

printf "%s $VERDE Fim! Escreva exit, pressione enter e reinicie com o comando reboot. $FIM \n"
