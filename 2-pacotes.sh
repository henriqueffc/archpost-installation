#!/bin/bash

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

echo -e "${AZUL}
-------------------------------------------------------------------------
                          Instalando os pacotes
-------------------------------------------------------------------------
${FIM}"

# Pacotes
sudo pacman --needed -S - <./pacotes/pkg.txt

# Fontes
sudo pacman --needed -S - <./pacotes/fontes.txt

# Virt-Mananger
sudo pacman --needed -S - <./pacotes/virt.txt

# TESSERACT
while :; do
    echo -ne "${VERDE}Você quer instalar os pacotes para OCR-Tesseract?${FIM} ${LVERDE}(S) sim / (N) não ${FIM}"
    read resposta
    case "$resposta" in
    s | S | "")
        sudo pacman --needed -S - <./pacotes/tesseract.txt
        break
        ;;
    n | N)
        echo -e "${AZUL}Continuando a instalação.${FIM}"
        break
        ;;
    *)
        echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}"
        ;;
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
sudo mv ./service/offpowersave.service /etc/systemd/system
sudo systemctl enable offpowersave.service
echo -e "  ${AZUL}WIFI - Powersave desabilitado${FIM}"

# Intelparanoid.service
sudo mv ./service/intelparanoid.service /etc/systemd/system
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
wget -P ~/Downloads -i ./urls/urls.txt

#Fontes
sudo mv ~/Downloads/*.ttf /usr/share/fonts/TTF
sudo fc-cache -fv

#Alias
mv ./aliases/.bash_aliases ~/

#Modelos de arquivos para o Files
mv ./modelo/arquivo.txt ~/Modelos

# Variáveis
echo "source ~/.bash_aliases" >>~/.bashrc

echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 1${FIM}" && sleep 1
echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 2${FIM}" && sleep 1
echo -e "${AZUL}Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 3${FIM}" && sleep 1

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
mkdir $HOME/Imagens/Wallpaper
sudo cp ./wallpapers/*.* ~/Imagens/Wallpaper
sed -i 's|/home/user1|'$HOME'|g' ~/Imagens/Wallpaper/dynamic_wallpaper.xml
dir=$(echo $HOME)
gsettings set org.gnome.desktop.background picture-uri file://$dir/Imagens/Wallpaper/dynamic_wallpaper.xml

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
while :; do
    echo -ne "${VERDE}Você quer instalar o limitador de FPS - Libstrangle?${FIM} ${LVERDE}(S) sim / (N) não${FIM}"
    read resposta
    case "$resposta" in
    s | S | "")
        git clone https://gitlab.com/torkel104/libstrangle.git
        cd libstrangle
        make
        sudo make install
        break
        ;;
    n | N)
        echo -e "${AZUL}Continuando a instalação${FIM}"
        break
        ;;
    *)
        echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}"
        ;;
    esac
done

#Sensors
sudo sensors-detect

printf "${VERDE}Fim! Reinicie o sistema.${FIM}\n"
