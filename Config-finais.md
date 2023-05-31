# Configurações necessárias após as execuções dos scripts:

### 1 - SSD
Habilite o cache de escrita e o APM com o valor de 254 no programa Discos.
<br><br>

### 2 - Tema
Configurar no Flatseal as variáveis de ambiente para os aplicativos que estejam com problemas de tema. Se usar o script nº10 não será necessária essa configuração. Veja o item 10 dessa lista. Exemplo:

`GTK_THEME=Adwaita-dark` ou `QT_STYLE_OVERRIDE=adwaita-dark` 
<br><br>

### 3 - ImageMagick
Verifique o policy.xml do ImageMagick.

`sudo nano /etc/ImageMagick-7/policy.xml`

Comente as linhas `<policy domain= com <!-- (início) e --> (final da linha)`. Ex.:

`<!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->`
<br><br>

### 4 - SSH
Configurar rkhunter, Fail2ban - porta SSH, SSH e Lynis (https://github.com/CISOfy/Lynis)
<br><br>

### 5 - NVMe
Altere a identificação do ponto de montagem das partições do NVMe no aplicativo discos.
<br><br>

### 6 - Nautilus
Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo script número 3.

`echo "file:///mnt/nvme0n1p1 🖴 NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 🗃 Dropbox" >> ~/.config/gtk-3.0/bookmarks`
<br><br>

### 7 - Fstab
Acrescente nos parâmetros das partições ext4 e montadas pelo sistema no boot as seguintes especificações `commit=60` e `barrier=0`.

`sudo nano /etc/fstab`
<br><br>

### 8 - tune2fs
Habilite o fast commit para todas as partições ext4 do sistema.

`sudo tune2fs -O fast_commit /dev/nome_da_partição`

Habilite a checagem do filesystem pelo tune2fs/e2fsck no boot para todas as partições ext4 do sistema (no comando abaixo a verificação está definida para ser efetuada depois de 20 montagens da partição)

`sudo tune2fs -c 20 /dev/nome_da_partição`

Verifique as informações das partições ext4

`sudo dumpe2fs -h /dev/nome_da_partição`

Faça as configurações no fstab disponíveis no link https://wiki.archlinux.org/title/Fsck#fstab_options para as partições do sistema que são montadas no boot e que não sejam a partição root (ext4) e a partição boot. Lembrando que as partições devem ser ext4. Sem essa configuração (0 2) essas partições não serão verificadas pelo tune2fs na inicialização.
<br><br>

### 9 - Heroic Game Launcher - Wayland.

`sudo nano /usr/share/applications/heroic.desktop`

`Exec=/opt/Heroic/heroic --ozone-platform-hint=auto %U`
<br><br>

### 10 - Gradience
Gradience - Aplicando o tema Classic Dark (script 10)

Aplique o tema Classic Dark. É preciso abrir o aplicativo antes de executar os comandos abaixo.

`flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience download -n "Classic Dark"`

`flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience apply -n "Classic Dark" --gtk both`
<br><br>

### 11 - Tmux

Instale os plugins no Tmux

^B + Shift + I (i maiúsculo)
<br><br>

### 12 - Obsidian

Configuração do Obsidian - Wayland  

`sudo nano /usr/share/applications/obsidian.desktop `

`Exec=/usr/bin/obsidian --ozone-platform-hint=auto %U`
<br><br>

### 13 - Spotify-launcher

Inicie o Spotify-launcher para completar a instalação do Spotify.

Depois execute os comandos abaixo para o Spotify funcionar no Wayland e não no Xwayland.

`sudo cp /etc/spotify-launcher.conf /etc/spotify-launcher.conf.bak`

`sudo sed -i '$a extra_arguments = ["--enable-features=UseOzonePlatform", "--ozone-platform=wayland"]' /etc/spotify-launcher.conf`
<br><br>

### 14 - Extensões do GNOME

Configure as extensões instaladas no GNOME (backup do App Icons Taskbar está no Dropbox e a imagem svg do Arch usada na Just Perfection está na pasta `~/Imagens/Logo`
<br><br>

### 15 - Firefox
Copie o arquivo user.js da pasta firefox para o seu profile do navegador em `/.mozilla/firefox`
<br><br>

### 16 - Xpad

Para o controle Multilaser JS091 (Shanwan Controler) funcionar instale a atualização para o Xpad disponível no site abaixo.

https://github.com/paroj/xpad
<br><br>

### 17 - Distrobox

Caso use alguma distro pelo distrobox não se esqueça de configurar o atalho do desktop (executar usando o bash. pelo zsh ocorrem alguns problemas)
Exemplo com o Ubuntu:

`nano .local/share/applications/ubuntu.desktop`

`Exec=/usr/local/bin/distrobox enter --name ubuntu -- bash -l`

Caso queira criar um atalho de teclado para lançar o distrobox usando o terminal do Gnome, faça o seguinte:

Acesse o menu de Preferências do terminal do Gnome e crie um novo perfil com o nome ubuntu (p.ex) e, na opção Comando personalizado (marque a opção Executar um comando personalizado ...), coloque `distrobox enter --name ubuntu -- bash -l` . O restante fica no padrão. Mude as cores do perfil para especificar a diferença de uso do terminal (padrão ou distrobox).

Nas configurações do sistema acesse Teclado - Atalhos de teclado.

Crie um atalho personalizado.

Nome : terminal ubuntu

Comando : `gnome-terminal --profile=ubuntu`

Atalho : Ctrl + U