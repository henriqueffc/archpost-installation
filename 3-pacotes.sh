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
sudo pacman --needed -Syu - <./pacotes/pkg.txt

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
sudo systemctl enable thermald.service
echo -e "$AZUL \t thermald habilitado $FIM"
sudo systemctl enable --now firewalld.service
echo -e "$AZUL \t firewalld.service habilitado $FIM"
sudo systemctl start pkgstats.timer
echo -e "$AZUL \t pkgstats.timer habilitado $FIM"
sudo systemctl enable pacman-filesdb-refresh.timer
echo -e "$AZUL \t pacman-filesdb-refresh habilitado $FIM"
systemctl enable --user gcr-ssh-agent.socket
echo -e "$AZUL \t GCR ssh-agent wrapper habilitado $FIM"
sudo systemctl enable --now nvidia-persistenced.service
echo -e "$AZUL \t nvidia-persistenced.service habilitado $FIM"
sudo systemctl enable nvidia-powerd.service
echo -e "$AZUL \t nvidia-powerd.service habilitado $FIM"
sudo systemctl enable bluetooth.service
systemctl enable --user obex.service
echo -e "$AZUL \t bluetooth.service e obex.service habilitados $FIM"
sudo systemctl enable --now systemd-oomd.service
echo -e "$AZUL \t systemd-oomd.service habilitado $FIM"

# Bluetooth
sudo sed -i 's/#Experimental =.*/Experimental = true/g' /etc/bluetooth/main.conf
sudo sed -i 's/#KernelExperimental =.*/KernelExperimental = true/g' /etc/bluetooth/main.conf
sudo sed -i 's/#Testing =.*/Testing = true/g' /etc/bluetooth/main.conf

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

# x86_energy_perf_policy
sudo mv ./service/cpupowerperf.service /etc/systemd/system
sudo systemctl enable cpupowerperf.service
echo -e "$AZUL \t x86_energy_perf_policy habilitado $FIM"

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

# Inserir o usuário nos grupos libvirt kvm
sudo usermod -aG libvirt,kvm "$USERNAME"

# Wireplumber
## Necessário para resolver o problema de acesso a webcam.
## https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3960#note_2373850
mkdir -p /home/$USER/.config/systemd/user/wireplumber.service.d/
echo -e "[Service]\nExecStartPre=/bin/sleep 5" >>override.conf
mv override.conf /home/$USER/.config/systemd/user/wireplumber.service.d/
## configurando o libcamera para ser o default no Wireplumber
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
mv ./pipewire/disable-v4l2.conf ~/.config/wireplumber/wireplumber.conf.d/

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
mkdir /home/$USER/AppImages
mv ~/Downloads/*.AppImage /home/$USER/AppImages
chmod +x /home/$USER/AppImages/*.AppImage

# Fontes
sudo mkdir -p /usr/local/share/fonts
tar -xf ./pacotes/fonts.tar.xz -C ~/Downloads
sudo mv ~/Downloads/*.ttf /usr/local/share/fonts
sudo mv ~/Downloads/*.TTF /usr/local/share/fonts
sudo fc-cache -fv

# Alias
mv ./aliases/.bash_aliases ~/
mv ./aliases/.atalhos.md ~/

# Modelos de arquivos para o Files
touch $HOME/Modelos/novo.txt

# Equalização paramétrica para o Headset HyperX Cloud Stinger
mkdir -p ~/.config/pipewire/pipewire.conf.d
mv ./pipewire/sink-eq6.conf ~/.config/pipewire/pipewire.conf.d/

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

echo -e "$AZUL Alterando o tema e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema e os atalhos do sistema em 3 $FIM" && sleep 1

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
gsettings set org.gnome.nautilus.preferences show-image-thumbnails "always"

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

# Desabilitar os cantos ativos
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

# Numlock
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

# Ao pesquisar no overview não serão exibidos os resultados da pesquisa realizada pelos aplicativos contidos nesta lista
gsettings set org.gnome.desktop.search-providers disabled "['org.gnome.Contacts.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.Weather.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Software.desktop', 'org.gnome.Boxes.desktop']"

# Ordem dos resultados da pesquisa realizada no overview
gsettings set org.gnome.desktop.search-providers sort-order "['firefox.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Settings.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.Boxes.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Contacts.desktop', 'org.gnome.seahorse.Application.desktop', 'org.gnome.Software.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Weather.desktop']"

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

# Mostrar relógio UTC no painel de notificações
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Coordinated Universal Time (UTC)', '@UTC', false, @a(dd) [], @a(dd) [])>)>}]"

# super + tab = muda de aplicativos / alt + tab = muda de janela
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"

# Configurações para o Text editor
gsettings set org.gnome.TextEditor highlight-current-line true
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor use-system-font false
gsettings set org.gnome.TextEditor custom-font "JetBrainsMonoNL Nerd Font Mono 14"
gsettings set org.gnome.TextEditor style-scheme "classic-dark"
gsettings set org.gnome.TextEditor style-variant "dark"

# mudar diretamente para o workspace desejado (Super + Shift + número de 2 a 6). Para ir para o primeiro workspace use Super + Home e para ir para o último Super + End.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Shift><Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Shift><Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Shift><Super>4']"

# Plocate
sudo pacman -S plocate --needed --noconfirm
sudo updatedb
sudo systemctl enable --now plocate-updatedb.timer
echo -e "$AZUL \t Plocate habilitado $FIM"

# Pacman hooks
sudo mkdir /etc/pacman.d/hooks
sudo cp ./hooks/*.hook /etc/pacman.d/hooks/

# Sensors
sudo sensors-detect

# Fonte do GNOME terminal
font=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ font 'JetBrainsMonoNL Nerd Font Mono 14'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ visible-name 'Padrão'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-columns '106'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$font/ default-size-rows '26'

# fonte do sistema
gsettings set org.gnome.desktop.interface font-name "Noto Sans 11"
gsettings set org.gnome.desktop.interface document-font-name "Noto Sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMonoNL Nerd Font Mono 10"
gsettings set org.gnome.desktop.interface font-antialiasing rgba

# Clamav
sudo freshclam
sudo systemctl enable clamav-freshclam-once.timer

# mpv
mkdir -p $HOME/.config/mpv/
cp ./mpv/mpv.conf $HOME/.config/mpv/

# Fastfetch
mkdir -p $HOME/.config/fastfetch/
cp ./fastfetch/config.jsonc $HOME/.config/fastfetch/

# wireless-regdb - instalado pelo script 1.
sudo sed -i '$a WIRELESS_REGDOM="BR"' /etc/conf.d/wireless-regdom

# Arquivos com as flags para o Chromium e Vivaldi
cp ./flags/chromium-flags.conf $HOME/.config/
cp ./flags/vivaldi-stable.conf $HOME/.config/

# Arquivo com as flags para o Obsidian
mkdir -p $HOME/.config/obsidian/
cp ./flags/user-flags.conf $HOME/.config/obsidian/

# Sincronizando a database para a pesquisa de pacotes
sudo pacman -Fy

# Yazi plugin
ya pack -a yazi-rs/plugins:max-preview

# Rio Termninal
mkdir -p $HOME/.config/rio
mv ./rio/config.toml ~/.config/rio/

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
