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

echo -e "$AZUL
-------------------------------------------------------------------------
                          Instalando os pacotes
-------------------------------------------------------------------------
$FIM"

# Pacotes
sudo pacman --needed -S - <./pacotes/pkg.txt

# Fontes
sudo pacman --needed -S - <./pacotes/fontes.txt

# Virt-Mananger
sudo pacman --needed -S - <./pacotes/virt.txt

# TESSERACT
while :; do
    echo -ne "$VERDE Você quer instalar os pacotes para OCR-Tesseract? $FIM $LVERDE (S) sim / (N) não $FIM"
    read -r resposta
    case "$resposta" in
    s | S | "")
        sudo pacman --needed -S - <./pacotes/tesseract.txt
        break
        ;;
    n | N)
        echo -e "$AZUL Continuando a instalação. $FIM"
        break
        ;;
    *)
        echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
        ;;
    esac
done

echo -e "$AZUL
-------------------------------------------------------------------------
                      Habilitando os serviços
-------------------------------------------------------------------------
$FIM"

# Habilitar os serviços
sudo systemctl enable libvirtd
echo -e "$AZUL \t libvirt habilitado $FIM"
sudo systemctl enable fstrim.timer
echo -e "$AZUL \t fstrim.timer habilitado $FIM"
sudo systemctl enable thermald
echo -e "$AZUL \t thermald habilitado $FIM"
sudo systemctl enable systemd-boot-update
echo -e "$AZUL \t systemd-boot-update habilitado $FIM"
sudo systemctl enable bluetooth.service
echo -e "$AZUL \t bluetooth.service habilitado $FIM"
sudo systemctl enable --now ufw.service
sudo ufw enable
echo -e "$AZUL \t ufw.service habilitado $FIM"

# Offpowersave
sudo mv ./service/offpowersave.service /etc/systemd/system
sudo systemctl enable offpowersave.service
echo -e "$AZUL \t WIFI - Powersave desabilitado $FIM"

# Intelparanoid.service
sudo mv ./service/intelparanoid.service /etc/systemd/system
sudo systemctl enable intelparanoid.service
echo -e "$AZUL \t Intel-Paranoid habilitado $FIM"

echo -e "$AZUL
-------------------------------------------------------------------------
                      Restante das configurações
-------------------------------------------------------------------------
$FIM"

# Grupos
sudo usermod -aG libvirt "$USERNAME"

# Appimage e outros
aria2c -d ~/Downloads -i ./urls/urls.txt

#Fontes
sudo mv ~/Downloads/*.ttf /usr/share/fonts/TTF
sudo fc-cache -fv

#Alias
mv ./aliases/.bash_aliases ~/

#Modelos de arquivos para o Files
mv ./modelo/arquivo.txt ~/Modelos

# Desabilitar o core dumps

sudo sed -i 's/#Storage=external/Storage=none/' /etc/systemd/coredump.conf

sudo systemctl daemon-reload

#Limite do tamanho do Journal

sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=300M/' /etc/systemd/journald.conf

sudo systemctl restart systemd-journald.service

sudo journalctl --vacuum-size=100M
sudo journalctl --vacuum-time=2weeks

# Variáveis
echo 'source ~/.bash_aliases' >>~/.bashrc

echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 3 $FIM" && sleep 1

#Tema e ícones do Gnome
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

#Mostrar porcentagem da bateria na top bar
gsettings set org.gnome.desktop.interface show-battery-percentage true

#Comportamento do botão de energia - Desligar
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive

#Desabilitar a redução do brilho da tela quando o computador está inativo
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

#Suspensão automática - Desabilitada quando conectado a energia e na bateria
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing

#Desabilitar o tempo antes da sessão ser considerada ociosa
gsettings set org.gnome.desktop.session idle-delay "0"

#Abrir os aplicativos centralizados na tela
gsettings set org.gnome.mutter center-new-windows true

#Desabilitar os cantos ativos
gsettings set org.gnome.desktop.interface enable-hot-corners false

#Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

#Numlock
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

#Ao pesquisar, não serão exibidos os resultados de aplicativos contidos nesta lista.
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Contacts.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.Photos.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Software.desktop']"

#Tamanho da fonte do sistema
gsettings set org.gnome.desktop.interface font-name "Cantarell 12"
gsettings set org.gnome.desktop.interface document-font-name "Cantarell 12"
gsettings set org.gnome.desktop.interface monospace-font-name "Source Code Pro 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Cantarell Bold 12"

#GNOME Software
gsettings set org.gnome.software download-updates false

#Tempo
gsettings set org.gnome.Weather locations "[<(uint32 2, <('Uberlândia', 'SBUL', true, [(-0.3295763346004984, -0.84183047006083411)], [(-0.3301581226533582, -0.84299402871326112)])>)>]"

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
mkdir "$HOME"/Imagens/Wallpaper
sudo cp ./wallpapers/*.* ~/Imagens/Wallpaper
sed -i 's|/home/user1|'$HOME'|g' ~/Imagens/Wallpaper/dynamic_wallpaper.xml
dir=$HOME
gsettings set org.gnome.desktop.background picture-uri file://$dir/Imagens/Wallpaper/dynamic_wallpaper.xml

#Steam (prime-run)
rm ~/Área\ de\ trabalho/steam.desktop
cp /usr/share/applications/steam.desktop ~/.local/share/applications
sed -i 's/steam-runtime/\prime-run steam-runtime/' ~/.local/share/applications/steam.desktop
echo -e "$AZUL \t steam.desktop modificado $FIM"

# Mlocate - necessário para a busca no Ulauncher
sudo pacman -S --needed mlocate
sudo updatedb
echo -e "$AZUL \t Mlocate habilitado $FIM"

# Limitador de FPS
while :; do
    echo -ne "$VERDE Você quer instalar o limitador de FPS - Libstrangle? $FIM $LVERDE (S) sim / (N) não $FIM"
    read -r resposta
    case "$resposta" in
    s | S | "")
        git clone https://gitlab.com/torkel104/libstrangle.git
        cd libstrangle
        make
        sudo make install
        break
        ;;
    n | N)
        echo -e "$AZUL Continuando a instalação. $FIM"
        break
        ;;
    *)
        echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
        ;;
    esac
done

#Sensors
sudo sensors-detect

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
