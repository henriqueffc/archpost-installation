#!/bin/bash

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'



echo -e "${AZUL}
-------------------------------------------------------------------------
                          Instalando os pacotes
-------------------------------------------------------------------------
${FIM}"

# Pacotes
sudo pacman -S --needed flatpak zsh materia-gtk-theme openssh ufw gufw aria2 bash-completion man-db man-pages texinfo reflector rsync curl cmatrix pacman-contrib dialog unrar zip unzip p7zip okular discount ebook-tools djvulibre unrar libzip kdegraphics-mobipocket libreoffice libreoffice-fresh-pt-br jre-openjdk kdenlive kvantum-qt5 qt6-wayland qt5-wayland xorg-xkill lutris wine wine-gecko wine-mono winetricks pandoc libappindicator-gtk3 transmission-gtk gparted exa bat alacarte fwupd gnome-firmware nvme-cli coreutils progress neofetch psensor ntfs-3g cpupower intel-gpu-tools i7z xorg-xdpyinfo libgtop lm_sensors glfw-x11 glew gnome-icon-theme-symbolic steam python-magic lib32-gnutls gamemode thermald papirus-icon-theme

# Fontes
sudo pacman -S --needed noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation xorg-fonts-type1 xorg-fonts-misc ttf-bitstream-vera ttf-opensans terminus-font ttf-roboto ttf-roboto-mono xorg-fonts-100dpi 

# Virt-Mananger
sudo pacman -S --needed qemu libvirt iptables-nft virt-manager virt-viewer dmidecode bridge-utils openbsd-netcat dnsmasq


# TESSERACT 
while :;  do
echo -ne "${VERDE}Você quer instalar os pacotes para OCR-Tesseract?${FIM} ${LVERDE}(S) sim / (N) não ${FIM}"
read resposta
case "$resposta" in
    s|S|"")
        sudo pacman -S --needed tesseract tesseract-data-spa tesseract-data-frk tesseract-data-ita tesseract-data-equ tesseract-data-fra tesseract-data-deu tesseract-data-deu_frak tesseract-data-eng tesseract-data-por; break;;
    n|N)
        echo -e "${AZUL}Continuando a instalação.${FIM}"; break;;
    *)
        echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;
esac
done

echo -e "${AZUL}
-------------------------------------------------------------------------
                      Habilitando os serviços
-------------------------------------------------------------------------
${FIM}"

# Habilitar os serviços
sudo systemctl enable libvirtd
echo -e "  ${AZUL}libvirt habilitado${FIM}"
sudo systemctl enable fstrim.timer
echo -e "  ${AZUL}fstrim.timer habilitado${FIM}"
sudo systemctl enable thermald
echo -e "  ${AZUL}thermald habilitado${FIM}"
sudo systemctl enable systemd-boot-update
echo -e "  ${AZUL}systemd-boot-update habilitado${FIM}"
sudo systemctl enable bluetooth.service
echo -e "  ${AZUL}bluetooth.service habilitado${FIM}"
sudo ufw enable
sudo systemctl enable ufw.service
echo -e "  ${AZUL}ufw.service habilitado${FIM}"

# Offpowersave
sudo mv $HOME/archpost-installation/service/offpowersave.service /etc/systemd/system  
sudo systemctl enable offpowersave.service 
echo -e "  ${AZUL}WIFI - Powersave desabilitado${FIM}"

# Intelparanoid.service
sudo mv $HOME/archpost-installation/service/intelparanoid.service /etc/systemd/system
sudo systemctl enable intelparanoid.service 
echo -e "  ${AZUL}Intel-Paranoid habilitado${FIM}"

echo -e "${AZUL}
-------------------------------------------------------------------------
                      Restante das configurações
-------------------------------------------------------------------------
${FIM}"

# Grupos
sudo usermod -aG libvirt $USERNAME

# Appimage e outros
wget -P ~/Downloads -i $HOME/archpost-installation/urls/urls.txt 

#Fontes
sudo mv ~/Downloads/*.ttf /usr/share/fonts/TTF
sudo fc-cache -fv

#Alias
mv $HOME/archpost-installation/aliases/.bash_aliases ~/

#Modelos de arquivos para o Files
mv $HOME/archpost-installation/modelo/arquivo.txt ~/Modelos

# Variáveis
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile
echo "source ~/.bash_aliases" >> ~/.bashrc

#Steam (prime-run)
rm ~/Área\ de\ trabalho/steam.desktop
cp /usr/share/applications/steam.desktop ~/.local/share/applications
sed -i 's/steam-runtime/\prime-run steam-runtime/' ~/.local/share/applications/steam.desktop
echo -e "  ${AZUL}steam.desktop modificado${FIM}"

# Mlocate - necessário para a busca no Ulauncher
sudo pacman -S --needed mlocate
sudo updatedb
echo -e "  ${AZUL}Mlocate habilitado${FIM}"

# Limitador de FPS
while :;  do
echo -ne "${VERDE}Você quer instalar o limitador de FPS - Libstrangle?${FIM} ${LVERDE}(S) sim / (N) não${FIM}"
read resposta
case "$resposta" in
     s|S|"")
          git clone https://gitlab.com/torkel104/libstrangle.git
          cd libstrangle 
          make
          sudo make install; break;;
     n|N)
         echo -e "${AZUL}Continuando a instalação${FIM}"; break;;
     *)
         echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;
esac
done

#Sensors
sudo sensors-detect

printf "${VERDE}Fim! Reinicie o sistema.${FIM}\n"
