#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
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
sudo mv ./powersave/default-wifi-powersave-on.conf /etc/NetworkManager/conf.d
echo -e "$AZUL \t WIFI - Powersave desabilitado $FIM"

# Intelparanoid.service
sudo mv ./service/intelparanoid.service /etc/systemd/system
sudo systemctl enable intelparanoid.service
echo -e "$AZUL \t Intel-Paranoid habilitado $FIM"

# CPU Power Service
sudo mv ./service/cpupowerperf.* /etc/systemd/system
sudo systemctl enable cpupowerperf.timer
echo -e "$AZUL \t CPU Power Performance.timer habilitado $FIM"

# Remover o Powerprofilesctl 
sudo pacman -R power-profiles-daemon

echo -e "$AZUL
-------------------------------------------------------------------------
                      Restante das configurações
-------------------------------------------------------------------------
$FIM"

# Grupos
sudo usermod -aG libvirt "$USERNAME"

# Appimage e outros
aria2c -d ~/Downloads -i ./urls/urls.txt
aria2c -d ~/Downloads https://github.com/upscayl/upscayl/releases/download/v1.5.5/Upscayl-1.5.5.AppImage -o Upscayl.AppImage
mkdir /home/$USER/Applications
mv ~/Downloads/*.AppImage /home/$USER/Applications
chmod +x /home/$USER/Applications/*.AppImage

# Joplin
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# Fontes
sudo mkdir -p /usr/local/share/fonts
tar -xf ./pacotes/fonts.tar.xz -C ~/Downloads
sudo mv ~/Downloads/*.ttf /usr/local/share/fonts
sudo mv ~/Downloads/*.TTF /usr/local/share/fonts
sudo fc-cache -fv

# Logos
mkdir ~/Imagens/Logo
mv ./desktop/*.png ~/Imagens/Logo

# Atalhos no Grid
sed -i 's|user|'$USER'|g' ./desktop/upscayl.desktop
mv ./desktop/*.desktop ~/.local/share/applications

# Alias
mv ./aliases/.bash_aliases ~/
mv ./aliases/.atalhos.txt ~/

# Chromium
mv ./chromium/chromium-flags.conf ~/.config

# Modelos de arquivos para o Files
touch $HOME/Modelos/novo.txt

# Desabilitar o core dumps
sudo cp /etc/systemd/coredump.conf /etc/systemd/coredump.conf.bak
sudo sed -i 's/#Storage=external/Storage=none/' /etc/systemd/coredump.conf
sudo systemctl daemon-reload

# Limite do tamanho do Journal
sudo cp /etc/systemd/journald.conf /etc/systemd/journald.conf.bak
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=300M/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald.service
sudo journalctl --vacuum-size=100M
sudo journalctl --vacuum-time=2weeks

# Variáveis
cp ~/.bashrc ~/.bashrc.bak
echo 'source ~/.bash_aliases' >>~/.bashrc

echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones, o wallpaper e os atalhos do sistema em 3 $FIM" && sleep 1

# Tema do sistema GNOME 43
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
# Tema para os aplicativos legados GNOME 43
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# Tema dos ícones 
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

# Mostrar porcentagem da bateria na top bar
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Comportamento do botão de energia - Desligar
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive

# Desabilitar a redução do brilho da tela quando o computador está inativo
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

# Suspensão automática - Desabilitada quando conectado a energia e na bateria
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type nothing

# Desabilitar o tempo antes da sessão ser considerada ociosa
gsettings set org.gnome.desktop.session idle-delay "0"

# Abrir os aplicativos centralizados na tela
gsettings set org.gnome.mutter center-new-windows true

# Bluetooth no menu aparece também estando desligado
gsettings set org.gnome.shell had-bluetooth-devices-setup true

# Desabilitar os cantos ativos
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

# Numlock
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

# Ao pesquisar no overview não serão exibidos os resultados da pesquisa realizada pelos aplicativos contidos nesta lista.
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Contacts.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.Photos.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Software.desktop']"

# Tamanho da fonte do sistema
gsettings set org.gnome.desktop.interface font-name "Noto Sans 12"
gsettings set org.gnome.desktop.interface document-font-name "Noto Sans 12"
gsettings set org.gnome.desktop.interface monospace-font-name "Noto Sans Mono 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "Noto Sans Bold 12"
gsettings set org.gnome.desktop.interface font-antialiasing rgba

# GNOME Software
gsettings set org.gnome.software download-updates false
gsettings set org.gnome.software first-run false

# Mutter
gsettings set org.gnome.mutter experimental-features '["kms-modifiers"]'

# Desabilitar a suspensão do notebook quando a tela do dispositivo é fechada. 
# primeira opção (habilitada) precisa do Gnome Tweaks instalado no sistema e desabilita somente para o usuário.
# segunda (comentada) desabilita para todo o sistema e não precisa do Gnome Tweaks instalado.
mv ./autostart/ignore-lid-switch-tweak.desktop ~/.config/autostart
#sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# RDP - remote desktop protocol
gsettings set org.gnome.desktop.remote-desktop.rdp screen-share-mode extend

# Tempo
gsettings set org.gnome.Weather locations "[<(uint32 2, <('Uberlândia', 'SBUL', true, [(-0.3295763346004984, -0.84183047006083411)], [(-0.3301581226533582, -0.84299402871326112)])>)>]"

# Atalhos do teclado (abnt2 com teclado numérico)
# abaixar o volume - Shift + - teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Shift>KP_Subtract']"
# aumentar o volume - Shift + + teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['<Shift>KP_Add']"
# reproduzir ou pausar reprodução de mídia - Shift + * teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Shift>KP_Multiply']"
# mudar para a próxima faixa - Shift + / teclado numérico
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift>KP_Divide']"
# abrir navegador - Super + B
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
# abrir o Files na home - Super + F
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>f']"
# fechar a janela - Super + Q
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"

# Atalho personalizado para lançar o Terminal - Super + T
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "kgx"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"

# Atalho personalizado para aumentar o brilho usando o teclado - Crtl + Para cima
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Aumentar o brilho"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Primary>Up"

# Atalho personalizado para diminuir o brilho usando o teclado - Crtl + Para baixo
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name "Diminuir o brilho"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepDown"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Primary>Down"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

# Mlocate
sudo pacman -S --needed mlocate
sudo updatedb
echo -e "$AZUL \t Mlocate habilitado $FIM"

# Pacman hooks
sudo mkdir /etc/pacman.d/hooks
sudo cp ./hooks/*.hook /etc/pacman.d/hooks/

# Sensors
sudo sensors-detect

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
