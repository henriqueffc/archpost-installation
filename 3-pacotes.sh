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
sudo systemctl enable systemd-boot-update
echo -e "$AZUL \t systemd-boot-update habilitado $FIM"
sudo systemctl enable bluetooth.service
systemctl enable --user obex.service
echo -e "$AZUL \t bluetooth.service e obex.service habilitados $FIM"
sudo systemctl enable --now firewalld.service
echo -e "$AZUL \t firewalld.service habilitado $FIM"
sudo systemctl start pkgstats.timer
echo -e "$AZUL \t pkgstats.timer habilitado $FIM"
sudo systemctl enable pacman-filesdb-refresh.timer
echo -e "$AZUL \t pacman-filesdb-refresh habilitado $FIM"
systemctl enable --user syncthing.service
echo -e "$AZUL \t syncthing habilitado $FIM"

# Bluetooth
sudo sed -i 's/#Experimental =.*/Experimental = true/g' /etc/bluetooth/main.conf
sudo sed -i 's/#KernelExperimental =.*/KernelExperimental = true/g' /etc/bluetooth/main.conf

# Offpowersave
sudo mv ./powersave/default-wifi-powersave-on.conf /etc/NetworkManager/conf.d
echo -e "$AZUL \t WIFI - Powersave desabilitado $FIM"

# FirewallD - Applet
cp /etc/xdg/autostart/firewall-applet.desktop ~/.config/autostart
sed -i '$a Hidden=true' ~/.config/autostart/firewall-applet.desktop

# Intelparanoid.service
sudo mv ./service/intelparanoid.service /etc/systemd/system
sudo systemctl enable intelparanoid.service
echo -e "$AZUL \t Intel-Paranoid habilitado $FIM"

# CPU Power Service
sudo mv ./service/cpupowerperf.service /etc/systemd/system
sudo systemctl enable cpupowerperf.service
sudo cp /etc/default/cpupower /etc/default/cpupower.bak
sudo sed -i "$ a governor='powersave'" /etc/default/cpupower
sudo sed -i '$ a min_freq="1800MHz"' /etc/default/cpupower
sudo sed -i '$ a max_freq="4600MHz"' /etc/default/cpupower
sudo systemctl enable cpupower.service
echo -e "$AZUL \t CPU Power e x86_energy_perf_policy habilitados $FIM"

# throttled
sudo sed -i 's|Sysfs_Power_Path.*|Sysfs_Power_Path: /sys/class/power_supply/AD*/online|g' /etc/throttled.conf
sudo systemctl enable throttled.service
echo -e "$AZUL \t CPU throttled habilitado $FIM"

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
sudo usermod -aG kvm "$USERNAME"

# Virt-manager
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.bak
sudo sed -i 's|#user = "libvirt-qemu"|user = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo sed -i 's|#group = "libvirt-qemu"|group = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.bak
sudo sed -i 's|#unix_sock_ro_perms = "0777"|unix_sock_ro_perms = "0777"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0770"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_group = "libvirt"|unix_sock_group = "libvirt"|g' /etc/libvirt/libvirtd.conf

# Appimage
aria2c -d ~/Downloads -i ./urls/urls.txt
mkdir /home/$USER/Applications
mv ~/Downloads/*.AppImage /home/$USER/Applications
chmod +x /home/$USER/Applications/*.AppImage

# Fontes
sudo mkdir -p /usr/local/share/fonts
tar -xf ./pacotes/fonts.tar.xz -C ~/Downloads
sudo mv ~/Downloads/*.ttf /usr/local/share/fonts
sudo mv ~/Downloads/*.TTF /usr/local/share/fonts
sudo fc-cache -fv

# Alias
mv ./aliases/.bash_aliases ~/
mv ./aliases/.atalhos.txt ~/

# Modelos de arquivos para o Files
touch $HOME/Modelos/novo.txt

# Equalização paramétrica para o Headset HyperX Cloud Stinger
mkdir -p ~/.config/pipewire/pipewire.conf.d
mv ./pipewire/*.conf ~/.config/pipewire/pipewire.conf.d/

# Desabilitar o coredump
sudo mkdir /etc/systemd/coredump.conf.d/
sudo mv ./coredump/custom.conf /etc/systemd/coredump.conf.d/
sudo systemctl daemon-reload
echo "kernel.core_pattern=/dev/null" >50-coredump.conf
sudo mv 50-coredump.conf /etc/sysctl.d/

# Limite do tamanho do Journal
sudo cp /etc/systemd/journald.conf /etc/systemd/journald.conf.bak
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=300M/' /etc/systemd/journald.conf
sudo systemctl restart systemd-journald.service
sudo journalctl --vacuum-size=100M
sudo journalctl --vacuum-time=2weeks

# Pasta ~/bin e ~/.local/bin (para o pipx) para o $PATH do bash
mkdir $HOME/bin
mkdir -p $HOME/.local/bin

# Variáveis
cp ~/.bashrc ~/.bashrc.bak
echo -e '\nsource ~/.bash_aliases' >>~/.bashrc
echo -e '\nif [ -d "$HOME/bin" ] ; then\nPATH="$HOME/bin:$PATH"\nfi' >>~/.bashrc
echo -e '\nif [ -d "$HOME/.local/bin" ] ; then\nPATH="$HOME/.local/bin:$PATH"\nfi' >>~/.bashrc

# Copiar scripts para a pasta ~/bin
mv ./bin/* $HOME/bin
chmod +x $HOME/bin/*

echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema, os ícones e os atalhos do sistema em 3 $FIM" && sleep 1

# Tema do sistema
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
# Tema para os aplicativos legados
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# Mostrar porcentagem da bateria na top bar
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Comportamento do botão de energia - Desligar
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive

# Nautilus
gsettings set org.gnome.nautilus.icon-view captions "['size', 'detailed_type', 'none']"
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

# File-chooser
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Tecla de composição para caracteres especiais (Scroll Lock - https://en.wikipedia.org/wiki/Compose_key#Common_compose_combinations)
gsettings set org.gnome.desktop.input-sources xkb-options "['terminate:ctrl_alt_bksp', 'lv3:ralt_switch', 'compose:sclk']"

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

# Ao pesquisar no overview não serão exibidos os resultados da pesquisa realizada pelos aplicativos contidos nesta lista
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Contacts.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.Weather.desktop', 'org.gnome.Photos.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Software.desktop']"

# Ordem dos resultados da pesquisa realizada no overview
gsettings set org.gnome.desktop.search-providers sort-order "['org.gnome.Calculator.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Settings.desktop']"

# Tamanho da fonte do sistema
gsettings set org.gnome.desktop.interface font-name "NotoSans Nerd Font 12"
gsettings set org.gnome.desktop.interface document-font-name "NotoSans Nerd Font 12"
gsettings set org.gnome.desktop.interface monospace-font-name "NotoSansM Nerd Font 11"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "NotoSansM Nerd Font Bold 12"
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
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

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

# abrir o configurações do GNOME
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>c']"

# abrir o cliente de email
gsettings set org.gnome.settings-daemon.plugins.media-keys email "['<Super>e']"

# Configurações para o Text editor
gsettings set org.gnome.TextEditor highlight-current-line true
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor use-system-font false
gsettings set org.gnome.TextEditor custom-font "JetBrainsMonoNL Nerd Font 14"
gsettings set org.gnome.TextEditor style-scheme "classic-dark"
gsettings set org.gnome.TextEditor style-variant "dark"

# mudar diretamente para o workspace desejado (Super + Shift + número de 2 a 6). Para ir para o primeiro workspace use Super + Home e para ir para o último Super + End.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Shift><Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Shift><Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Shift><Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Shift><Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Shift><Super>6']"

# atalho personalizado para lançar o Terminal - Super + T
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Terminal"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "wezterm"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>t"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# wezterm
mv ./wezterm/.wezterm.lua $HOME

# Vagrant
vagrant plugin install vagrant-libvirt

# Mlocate
sudo pacman -S mlocate --needed --noconfirm
sudo updatedb
echo -e "$AZUL \t Mlocate habilitado $FIM"

# Pacman hooks
sudo mkdir /etc/pacman.d/hooks
sudo cp ./hooks/*.hook /etc/pacman.d/hooks/

# Kvantum
mkdir -p ~/.config/Kvantum
mv ./kvantum/kvantum.kvconfig ~/.config/Kvantum/

# Sensors
sudo sensors-detect

# Fonte do GNOME terminal
font=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ font 'JetBrainsMonoNL Nerd Font 14'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ visible-name 'Padrão'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-columns '106'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-rows '26'

# Clamav
sudo freshclam
sudo cp /etc/clamav/freshclam.conf /etc/clamav/freshclam.conf.bak
sudo sed -i '/#Checks 24/c\Checks 4' /etc/clamav/freshclam.conf
sudo systemctl enable --now clamav-freshclam.service

# mpv
mkdir -p $HOME/.config/mpv/
cp ./mpv/mpv.conf $HOME/.config/mpv/

# Obsidian - Wayland
cp /usr/share/applications/obsidian.desktop ~/.local/share/applications/
sed -i 's|Exec=.*|Exec=/usr/bin/obsidian --ozone-platform-hint=auto %U|g' ~/.local/share/applications/obsidian.desktop

# Heroic Games Launcher - Wayland
cp /usr/share/applications/heroic.desktop ~/.local/share/applications/
sed -i 's|Exec=.*|Exec=/opt/Heroic/heroic --ozone-platform-hint=auto %U|g' ~/.local/share/applications/heroic.desktop

# Fastfetch
mkdir -p $HOME/.config/fastfetch/
cp ./fastfetch/config.jsonc $HOME/.config/fastfetch/

# wireless-regdb - instalado pelo script 1.
sudo sed -i '$a WIRELESS_REGDOM="BR"' /etc/conf.d/wireless-regdom

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
