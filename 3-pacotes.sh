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
systemctl enable --user speech-dispatcher.socket
echo -e "$AZUL speech-dispatcher.socket habilitado $FIM"
sudo systemctl enable --now avahi-daemon.service
echo -e "$AZUL \t avahi-daemon.service habilitado $FIM"
sudo systemctl enable switcheroo-control.service
echo -e "$AZUL \t switcheroo-control.service habilitado $FIM"

# Ollama
sudo mkdir -p /etc/systemd/system/ollama.service.d/
sudo cp ./ollama/override.conf /etc/systemd/system/ollama.service.d/
sudo systemctl daemon-reload
sudo systemctl enable ollama.service
echo -e "$AZUL \t ollama.service habilitado $FIM"

# Bluetooth
sudo sed -i 's/#Experimental =.*/Experimental = true/g' /etc/bluetooth/main.conf
sudo sed -i 's/#KernelExperimental =.*/KernelExperimental = true/g' /etc/bluetooth/main.conf
sudo sed -i 's/#Testing =.*/Testing = true/g' /etc/bluetooth/main.conf

# FirewallD - Applet
cp /etc/xdg/autostart/firewall-applet.desktop ~/.config/autostart
sed -i '$a Hidden=true' ~/.config/autostart/firewall-applet.desktop

# Intelparanoid.service
sudo cp ./service/intelparanoid.service /etc/systemd/system/
sudo systemctl enable intelparanoid.service
echo -e "$AZUL \t Intel-Paranoid habilitado $FIM"

# hwp_dynamic_boost
sudo cp ./service/hwpdynamicboost.service /etc/systemd/system/
sudo systemctl enable hwpdynamicboost.service
echo -e "$AZUL \t hwp_dynamic_boost habilitado $FIM"

# Habilitando o Tuned
sudo systemctl enable --now tuned
sudo systemctl enable --now tuned-ppd
echo -e "$AZUL \t Tuned habilitado $FIM"

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

# Inserir o usuário nos grupos libvirt, video e kvm
sudo usermod -aG libvirt,video,kvm "$USERNAME"

# Wireplumber
# configurando o libcamera para ser o default no Wireplumber
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
cp ./pipewire/99-libcamera.conf ~/.config/wireplumber/wireplumber.conf.d/

# Virt-manager
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.bak
sudo sed -i 's|#user = "libvirt-qemu"|user = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo sed -i 's|#group = "libvirt-qemu"|group = "'$USER'"|g' /etc/libvirt/qemu.conf
sudo cp /etc/libvirt/libvirtd.conf /etc/libvirt/libvirtd.conf.bak
sudo sed -i 's|#unix_sock_ro_perms = "0777"|unix_sock_ro_perms = "0777"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0770"|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|#unix_sock_group = "libvirt"|unix_sock_group = "libvirt"|g' /etc/libvirt/libvirtd.conf

# Appimage
#aria2c -d ~/Downloads -i ./urls/urls.txt
mkdir /home/$USER/AppImages
#mv ~/Downloads/*.AppImage /home/$USER/AppImages
#chmod +x /home/$USER/AppImages/*.AppImage

# Fontes
sudo mkdir -p /usr/local/share/fonts
tar -xf ./pacotes/fonts.tar.xz -C ~/Downloads
sudo mv ~/Downloads/*.ttf /usr/local/share/fonts
sudo mv ~/Downloads/*.TTF /usr/local/share/fonts
sudo fc-cache -fv

# Alias, atalhos e functions
cp ./aliases/bash_aliases ~/.bash_aliases
cp ./aliases/atalhos.md ~/.atalhos.md
cp ./aliases/functions ~/.functions

# Modelos de arquivos para o Files
touch $HOME/Modelos/novo.txt

# Desabilitar o coredump
sudo mkdir /etc/systemd/coredump.conf.d/
sudo cp ./coredump/custom.conf /etc/systemd/coredump.conf.d/
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
echo -e '\nsource ~/.functions' >>~/.bashrc
echo -e '\nif [ -d "$HOME/bin" ] ; then\nPATH="$HOME/bin:$PATH"\nfi' >>~/.bashrc
echo -e '\nif [ -d "$HOME/.local/bin" ] ; then\nPATH="$HOME/.local/bin:$PATH"\nfi' >>~/.bashrc

# Copiar scripts para a pasta ~/bin
cp ./bin/* $HOME/bin/
chmod +x $HOME/bin/*

echo -e "$AZUL Alterando o tema e os atalhos do sistema em 1 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema e os atalhos do sistema em 2 $FIM" && sleep 1
echo -e "$AZUL Alterando o tema e os atalhos do sistema em 3 $FIM" && sleep 1

# Tema do sistema
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
# Tema para os aplicativos legados
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"

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

# Abrir os aplicativos centralizados na tela. É o padrão no GNOME 48
#gsettings set org.gnome.mutter center-new-windows true

# Desabilitar os cantos ativos
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Touchpad
gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

# Numlock
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

# Desabilitar os provedores de  pesquisa externos no overview
gsettings set org.gnome.desktop.search-providers disable-external true

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
gsettings set org.gnome.mutter experimental-features '["kms-modifiers", "variable-refresh-rate"]'

# Desabilitar a suspensão do notebook quando a tela do dispositivo é fechada.
sudo sed -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf

# RDP - remote desktop protocol
gsettings set org.gnome.desktop.remote-desktop.rdp screen-share-mode extend

# Tempo
gsettings set org.gnome.Weather locations "[<(uint32 2, <('Uberlândia', 'SBUL', true, [(-0.3295763346004984, -0.84183047006083411)], [(-0.3301581226533582, -0.84299402871326112)])>)>]"

# Atalhos do teclado (abnt2 com teclado numérico)
# abaixar o volume - Shift + - teclado numérico
# aumentar o volume - Shift + + teclado numérico
# reproduzir ou pausar reprodução de mídia - Shift + * teclado numérico
# mudar para a próxima faixa - Shift + / teclado numérico
# abrir navegador - Super + b
# abrir o Files na home - Super + f
# aumentar o brilho da tela usando o teclado - Crtl + Para cima
# diminuir o brilho da tela usando o teclado - Crtl + Para baixo
# abrir o configurações do GNOME - Super + c
# abrir o cliente de email - Super + e
# Atalhos de teclado para o Gradia (Ctrl + Print e Ctrl + Shift + Print)
dconf load /org/gnome/settings-daemon/plugins/media-keys/ <./dconf/mediakeys.txt

# Mostrar relógio UTC no painel de notificações
gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Coordinated Universal Time (UTC)', '@UTC', false, @a(dd) [], @a(dd) [])>)>}]"

# Configurações para o Text editor
dconf load /org/gnome/TextEditor/ <./dconf/gnomeedt.txt

# Super + Q = fechar a janela
# Super + Tab = muda de aplicativos
# Alt + Tab = muda de janela
# Super + para cima = Maximizar a janela
# Super + para baixo = Desfazer a janela maximizada
# mudar diretamente para o workspace desejado (Super + Shift + número de 2 a 6).
# Para ir para o primeiro workspace use Super + Home e para ir para o último Super + End.
dconf load /org/gnome/desktop/wm/keybindings/ <./dconf/keybindings.txt

# fonte do sistema
gsettings set org.gnome.desktop.interface font-antialiasing rgba

# Kvantum
mkdir -p $HOME/.config/Kvantum/
cp ./kvantum/kvantum.kvconfig $HOME/.config/Kvantum/

# Plocate
sudo pacman -S plocate --needed --noconfirm
sudo updatedb
echo -e "$AZUL \t Plocate habilitado $FIM"

# Pacman hooks
sudo mkdir /etc/pacman.d/hooks
sudo cp ./hooks/*.hook /etc/pacman.d/hooks/

# Sensors
sudo sensors-detect --auto

# Clamav
sudo freshclam
sudo systemctl enable clamav-freshclam-once.timer

# mpv
mkdir -p $HOME/.config/mpv/
cp ./mpv/mpv.conf $HOME/.config/mpv/

# Fastfetch
mkdir -p $HOME/.config/fastfetch/
cp ./fastfetch/config.jsonc $HOME/.config/fastfetch/

# wireless-regdb - instalado pelo script n.° 1.
sudo sed -i '$a WIRELESS_REGDOM="BR"' /etc/conf.d/wireless-regdom

# Arquivos com as flags para o Chromium e Electron
cp ./flags/chromium-flags.conf $HOME/.config/
cp ./flags/electron-flags.conf $HOME/.config/

# Sincronizando a database para a pesquisa de pacotes
sudo pacman -Fy

# Yazi config e plugin
mkdir -p $HOME/.config/yazi/plugins/
cp ./yazi/yazi.toml $HOME/.config/yazi/
cp ./yazi/keymap.toml $HOME/.config/yazi/
ya pkg add yazi-rs/plugins:toggle-pane
ya pkg add yazi-rs/plugins:mount
ya pkg add yazi-rs/plugins:chmod

# Firejail + AppArmor
sudo apparmor_parser -r /etc/apparmor.d/firejail-default

# Ghostty terminal
mkdir -p $HOME/.config/ghostty/
cp ./ghostty/config $HOME/.config/ghostty/

# mise
mkdir -p $HOME/.config/mise/
cp ./mise/config.toml $HOME/.config/mise/

# Habilitando permanentemente os serviços mDNS e o samba-client no Firewalld
sudo firewall-cmd --zone=public --add-service=mdns --permanent
sudo firewall-cmd --zone=public --add-service=samba-client --permanent
sudo firewall-cmd --reload

# Habilitando a extensão Appindicator
# A extensão appindicator foi instalada no script n.° 2.
gnome-extensions enable $(gnome-extensions list | grep -m 1 appindicatorsupport)

# Desabilitabdo o suporte ao legacy tray icons support na Appindicator
gsettings set org.gnome.shell.extensions.appindicator legacy-tray-enabled false

# mostrar imagens usando o w3m
mkdir -p $HOME/.w3m/
tee $HOME/.w3m/config >/dev/null <<'EOF'
inline_img_protocol 3
imgdisplay iterm2

EOF

# Habilitando o profile throughput-performance no Tuned
tuned-adm profile throughput-performance

printf "%s $VERDE Fim! Reinicie o sistema. $FIM \n"
