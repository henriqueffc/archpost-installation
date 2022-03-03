#!/bin/bash

# Locale.gen
sed -i 's/#pt_BR.UTF-8 UTF-8/\pt_BR.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Vconsole.conf (Já foi configurado pelo Archinstall)
# echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

# Idioma e Localhost
echo 'LANG=pt_BR.UTF-8' > /etc/locale.conf
#echo "archlinux" > /etc/hostname (já foi feito pelo Archinstall)
line=$(cat /etc/hostname)
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1       localhost' >> /etc/hosts
echo "127.0.1.1 $line.localdomain $line" >> /etc/hosts

# Visudo
sed -i '82s/..//' /etc/sudoers
echo '# Defaults specification' >> /etc/sudoers
echo 'Defaults editor=/usr/bin/nano' >> /etc/sudoers

# Caso queira o vim ao invés do nano, comente (#) a linha acima e descomente a linha abaixo.
# echo "Defaults editor=/usr/bin/vim" >> /etc/sudoers

# Pacman.conf
cp /etc/pacman.conf /etc/pacman.conf.bak
sed -i '32s/#//' /etc/pacman.conf
sed -i 's/#Color/\Color/' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/\VerbosePkgLists/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/\ParallelDownloads = 5/' /etc/pacman.conf
sed -i 's/#CheckSpace/\CheckSpace/' /etc/pacman.conf
sed -i '93s/#//' /etc/pacman.conf
sed -i '94s/#//' /etc/pacman.conf
#sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf (outra forma para habilitar o multilib)

# NANO - Line number e syntax-highlighting
sed -i 's/# set linenumbers/\set linenumbers/' /etc/nanorc
sed -i '243s/..//' /etc/nanorc

# Swappiness
mv 99-swappiness.conf /etc/sysctl.d/

#Mirrorlist
echo -ne "
-------------------------------------------------------------------------
                        Mirrorlist - Brasil
-------------------------------------------------------------------------
"
cat mirrorlist
echo -n "Você quer alterar o mirrorlist do sistema de acordo com o exposto acima? (S) sim / (N) não "
read resposta
case "$resposta" in
     s|S|"")
          mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
          mv mirrorlist /etc/pacman.d/
          echo "Fim da instalação"
     ;;
     n|N)
          echo "Fim da instalação"
     ;;
     *)
          echo "Opção inválida"
     ;;
esac

pacman -Syy --noconfirm --needed

printf "\e[1;32mFim! Escreva exit, pressione enter e reinicie com o comando reboot.\e[0m"
