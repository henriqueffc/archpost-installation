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
sudo pkgfile --update
sudo systemctl enable pkgfile-update.timer
echo -e "$AZUL \t pkgfile-update.timer habilitado $FIM"
sudo systemctl start pkgstats.timer
echo -e "$AZUL \t pkgstats.timer habilitado $FIM"
sudo systemctl enable switcheroo-control.service
echo -e "$AZUL \t switcheroo-control habilitado $FIM"
sudo systemctl enable pacman-filesdb-refresh.timer
echo -e "$AZUL \t pacman-filesdb-refresh habilitado $FIM"

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
echo -e "$AZUL \t CPU Power timer habilitado $FIM"

# tealdeer (implementação do tldr)
tldr --update
tldr --seed-config
cp ~/.config/tealdeer/config.toml ~/.config/tealdeer/config.toml.bak
sed -i 's|auto_update = false|auto_update = true|g' ~/.config/tealdeer/config.toml

echo -e "$AZUL
-------------------------------------------------------------------------
                      Restante das configurações
-------------------------------------------------------------------------
$FIM"

# Grupos
sudo usermod -aG libvirt "$USERNAME"

# Virt-manager
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.bak
sudo sed -i 's|#user = "libvirt-qemu"|user = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo sed -i 's|#group = "libvirt-qemu"|group = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.bak
sudo sed -i 's|#unix_sock_ro_perms = "0777"|unix_sock_ro_perms = "0777"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0770"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_group = "libvirt"|unix_sock_group = "libvirt"|g' /etc/libvirt/libvirtd.conf

# Appimage e outros
aria2c -d ~/Downloads -i ./urls/urls.txt
aria2c -d ~/Downloads https://github.com/upscayl/upscayl/releases/download/v2.0.1/upscayl-2.0.1-linux.AppImage -o Upscayl.AppImage
aria2c -d ~/Downloads https://github.com/pop-os/popsicle/releases/download/1.3.1/Popsicle_USB_Flasher-1.3.1-x86_64.AppImage
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
mv ./desktop/*.svg ~/Imagens/Logo

# Atalhos no Grid
sed -i 's|user|'$USER'|g' ./desktop/upscayl.desktop
mv ./desktop/upscayl.desktop ~/.local/share/applications

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

# Pasta ~/bin para o $PATH
mkdir $HOME/bin

# Variáveis
cp ~/.bashrc ~/.bashrc.bak
echo -e '\nsource ~/.bash_aliases' >>~/.bashrc
echo -e '\nif [ -d "$HOME/bin" ] ; then\nPATH="$HOME/bin:$PATH"\nfi' >>~/.bashrc
# echo -e '\nsource /usr/share/doc/pkgfile/command-not-found.bash' >>~/.bashrc (usando a específica para o .zshrc, script 8)

# Copiar scripts para a pasta ~/bin
mv ./bin/* $HOME/bin
chmod +x $HOME/bin/*

# Tema dos ícones Kora
git clone https://github.com/bikass/kora.git
sudo cp -r ./kora/kora /usr/share/icons/
rm -rf kora

echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 3 $FIM" && sleep 1

# Tema do sistema GNOME 43
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
# Tema para os aplicativos legados GNOME 43
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# Tema dos ícones
gsettings set org.gnome.desktop.interface icon-theme "kora"

# Mostrar porcentagem da bateria na top bar
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Comportamento do botão de energia - Desligar
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive

# Nautilus
gsettings set org.gnome.nautilus.icon-view captions "['size', 'permissions', 'detailed_type']"
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

# File-chooser gtk3
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Desabilitar as animações do Gnome
gsettings set org.gnome.desktop.interface enable-animations false

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

# Acessibilidade
gsettings set org.gnome.desktop.a11y.magnifier mag-factor "1.25"
gsettings set org.gnome.desktop.a11y.magnifier mouse-tracking push

# GNOME Software
gsettings set org.gnome.software download-updates false
gsettings set org.gnome.software first-run false

# Privacy
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy old-files-age "3"

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

# aumentar o brilho da tela usando o teclado - Crtl + Para cima
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-up "['<Primary>Up']"

# diminuir o brilho da tela usando o teclado - Crtl + Para baixo
gsettings set org.gnome.settings-daemon.plugins.media-keys screen-brightness-down "['<Primary>Down']"

# mudar diretamente para o workspace desejado (Super + Shift + número de 2 a 6). Para ir para o primeiro workspace use Super + Home e para ir para o último Super + End.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Shift><Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Shift><Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Shift><Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Shift><Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Shift><Super>6']"

# atalho personalizado para lançar o Terminal - Super + T
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "prime-run alacritty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"

# atalho personalizado para lançar o Crow Translate (tradução do trecho de texto selecionado) - Alt + Z
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "crow-translate"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "dbus-send --type=method_call --dest=io.crow_translate.CrowTranslate /io/crow_translate/CrowTranslate/MainWindow io.crow_translate.CrowTranslate.MainWindow.translateSelection"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Alt>z"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

# Alacritty
mkdir $HOME/.config/alacritty
mv ./alacritty/alacritty.yml $HOME/.config/alacritty/
sudo sed -i 's/\<Exec=alacritty\>/Exec=prime-run alacritty/g' /usr/share/applications/Alacritty.desktop

# Alacritty - Tmux - Nautilus
mkdir -p ~/.local/share/nautilus-python/extensions
mv ./alacritty/alacritty-tmux-nautilus.py $HOME/.local/share/nautilus-python/extensions/
nautilus -q

# Tmux
mv ./tmux/.tmux.conf $HOME
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.tmux.conf

# Mlocate
sudo pacman -S mlocate --needed --noconfirm
sudo updatedb
echo -e "$AZUL \t Mlocate habilitado $FIM"

# Pacman hooks
sudo mkdir /etc/pacman.d/hooks
sudo cp ./hooks/*.hook /etc/pacman.d/hooks/

# Sensors
sudo sensors-detect

# Fonte do GNOME terminal 
font=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ font 'JetBrains Mono NL 14'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ visible-name 'Padrão'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-columns '106'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-rows '26'

# Remover o Powerprofilesctl
# sudo pacman -R power-profiles-daemon

# Neofetch
cp ./neofetch/config.conf $HOME/.config/neofetch/

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
