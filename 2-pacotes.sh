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

echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 1${FIM}"
sleep 1
echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 2${FIM}"
sleep 1
echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 3${FIM}"
sleep 1

#Tema e ícones do Gnome
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"


#Atalhos do teclado (abnt2 com teclado numérico)
# abaixar o volume - Ctrl + - teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Primary>KP_Subtract']" 
# aumentar o volume - Ctrl + + teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Primary>KP_Add']" 
#reproduzir ou pausar reprodução de mídia - Crtl + * teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Primary>KP_Multiply']" 
#mudar para a próxima faixa - Ctrl + / teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Primary>KP_Divide']" 
# abrir navegador - Super + B
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']" 
#abrir o Files na home - Super + F
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>f']" 
#fechar a janela - Super + Q
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']" 

# Atalho personalizado para lançar o Terminal - Super + T
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "gnome-terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"


# Atalho personalizado para aumentar o brilho usando o teclado - Crtl + Para cima
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Aumentar o brilho"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Primary>Up"


# Atalho personalizado para diminuir o brilho usando o teclado - Crtl + Para baixo
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "Diminuir o brilho"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepDown"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Primary>Down"

# Atalho personalizado para lançar o Ulauncher (Wayland) - Super + \
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ name "Ulauncher"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ command "ulauncher-toggle"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/ binding "<Super>backslash"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/']" 

#Wallpaper dinâmico
sudo cp $HOME/archpost-installation/wallpapers/*.* /usr/share/backgrounds/gnome
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/gnome/dynamic_wallpaper.xml

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
