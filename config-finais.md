# Configurações necessárias após as execuções dos scripts:

### 1 - SSD
Habilite o cache de escrita e o APM com o valor de 254 no programa Discos.
<br><br>

### 2 - Tema
Configure o tema dos programas que usam QT através dos aplicativos *Qt5 Settings* e *Qt6 Settings*

Escolha o estilo kvantum e tema de ícones breeze dark.

Nos programas que usam QT e permitem configurar a aparência (kdenlive, okular, vlc, etc.) escolha o tema kvantum.

Execute os seguintes comandos para unificar os temas dos flatpaks instalados no sistema. 

O sufixo :ro (ex.: xdg-config/gtk-4:ro) indica read-only. Ele é opcional e preferi não usá-lo.

`sudo flatpak override --filesystem=xdg-config/gtk-4.0`

`sudo flatpak override --filesystem=xdg-config/gtk-3.0`
<br><br>

### 3 - ImageMagick
Verifique o policy.xml do ImageMagick.

`sudo nano /etc/ImageMagick-7/policy.xml`

Comente as linhas `<policy domain= com <!-- (início) e --> (final da linha)`. Ex.:

`<!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->`
<br><br>

### 4 - SSH
Configurar rkhunter, Fail2ban - porta SSH e o SSH.
<br><br>

### 5 - NVMe
Altere a identificação do ponto de montagem das partições do NVMe no aplicativo discos.
<br><br>

### 6 - Nautilus
Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo script número 3.

`echo "file:///mnt/nvme0n1p1 🖴  NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 🗃 Dropbox" >> ~/.config/gtk-3.0/bookmarks`
<br><br>

### 7 - Fstab
Acrescente nos parâmetros das partições ext4 e montadas pelo sistema no boot as seguintes especificações `commit=60` e `barrier=0`.

`sudo nano /etc/fstab`
<br><br>

### 8 - Ext4
Habilite o fast commit para todas as partições Ext4 do sistema.

`sudo tune2fs -O fast_commit /dev/nome_da_partição`

Habilite a checagem do filesystem pelo tune2fs/e2fsck no boot para todas as partições Ext4 do sistema (no comando abaixo a verificação está definida para ser efetuada depois de 20 montagens da partição)

`sudo tune2fs -c 20 /dev/nome_da_partição`

Verifique as informações das partições Ext4

`sudo dumpe2fs -h /dev/nome_da_partição`

Faça as configurações no fstab disponíveis no link https://wiki.archlinux.org/title/Fsck#fstab_options para as partições do sistema que são montadas no boot e que não sejam a partição root (Ext4) e a partição boot. Lembrando que as partições devem ser Ext4. Sem essa configuração (0 2) essas partições não serão verificadas pelo tune2fs na inicialização.

Verifique se as partições Ext4 estão em 64-bit e com o metadata checksums habilitado.

`sudo dumpe2fs -h /dev/nome_da_partição | grep features`

Exemplo com 64bit e metadata_csum habilitados:
```
Filesystem features: has_journal ext_attr resize_inode dir_index fast_commit
filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file
dir_nlink extra_isize metadata_csum
```
Caso alguma das duas opções destacadas no exemplo acima não constar na saída do comando, faça o seguinte:

A partição objeto do procedimento não pode estar montada para a execução dos comandos abaixo.

`sudo e2fsck -Df /dev/nome_da_partição` (otimização da partição - obrigatório)

`sudo resize2fs -b /dev/nome_da_partição` (conversão para 64-bit - somente se o 64bit não estiver disponível na lista)

`sudo tune2fs -O metadata_csum /dev/nome_da_partição` (habilitando o metadata checksums - somente se o metadata_csum não estiver disponível na lista)

Verifique a lista novamente usando `sudo dumpe2fs -h /dev/nome_da_partição | grep features`
<br><br>

### 9 - Heroic Game Launcher - Wayland.

`cp /usr/share/applications/heroic.desktop ~/.local/share/applications`

`nano ~/.local/share/applications/heroic.desktop`

`Exec=/opt/Heroic/heroic --ozone-platform-hint=auto %U`
<br><br>

### 10 - Gradience
Gradience - Aplicando o tema Classic Dark (script 11)

Aplique o tema Classic Dark. É preciso abrir o aplicativo antes de executar os comandos abaixo.

`flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience download -n "Classic Dark"`

`flatpak run --command=gradience-cli com.github.GradienceTeam.Gradience apply -n "Classic Dark" --gtk both`
<br><br>

### 11 - Tmux
Instale os plugins no Tmux

^B + Shift + I (i maiúsculo)
<br><br>

### 12 - Obsidian - Wayland
`cp /usr/share/applications/obsidian.desktop ~/.local/share/applications`

`nano  ~/.local/share/applications/obsidian.desktop`

`Exec=/usr/bin/obsidian --ozone-platform-hint=auto %U`
<br><br>

### 13 - Spotify-launcher
Inicie o Spotify-launcher para completar a instalação do Spotify.

Depois execute os comandos abaixo para o Spotify funcionar no Wayland e não no Xwayland.

`sudo cp /etc/spotify-launcher.conf /etc/spotify-launcher.conf.bak`

`sudo sed -i '$a extra_arguments = ["--enable-features=UseOzonePlatform", "--ozone-platform=wayland"]' /etc/spotify-launcher.conf`
<br><br>

### 14 - Extensões do GNOME
Configure as extensões instaladas no GNOME.
<br><br>

### 15 - Firefox
Copie o arquivo `user.js` da pasta firefox para o seu profile do navegador em `~/.mozilla/firefox/pasta_do_profile`
Caso não queira copiar o arquivo, configure o parâmetro `browser.gnome-search-provider.enabled` como `true` (booleano) em `about:config`
Esse parâmetro é necessário para habilitar a pesquisa pelo navegador (o Firefox deve estar em execução) no overview do Gnome. A configuração para o serviço de pesquisa foi realizada no script 3-pacotes.sh.
<br><br>

### 16 - Xpad
Para o controle Multilaser JS091 (Shanwan Controler) funcionar instale a atualização para o Xpad disponível no site abaixo.

https://github.com/paroj/xpad
<br><br>

### 17 - Distrobox
Caso use alguma distro pelo Distrobox não se esqueça de configurar o atalho do desktop (executar usando o bash. pelo zsh ocorrem alguns problemas)
Exemplo com o Ubuntu:

`nano .local/share/applications/ubuntu.desktop`

`Exec=/usr/local/bin/distrobox enter --name ubuntu -- bash -l`

Caso queira criar um atalho de teclado para lançar o Distrobox usando o terminal do Gnome (se for o Alacritty só é preciso configurar o comando para o atalho de teclado - veja após a descrição para o terminal do Gnome), faça o seguinte:

Acesse o menu de Preferências do terminal do Gnome e crie um novo perfil com o nome ubuntu (p.ex) e, na opção Comando personalizado (marque a opção Executar um comando personalizado ...), coloque `distrobox enter --name ubuntu -- bash -l` . O restante fica no padrão. Mude as cores do perfil para especificar a diferença de uso do terminal (padrão ou Distrobox).

Nas configurações do sistema acesse Teclado - Atalhos de teclado.

Crie um atalho personalizado.

Nome : terminal ubuntu

Comando : `gnome-terminal --profile=ubuntu`

Caso queira inicializar usando o Alacritty o comando é o seguinte:
`alacritty -o window.title=distrobox -o "colors.primary.background='#1d2b35'" --command distrobox-enter -n ubuntu`

Atalho : Shift + Ctrl + D
<br><br>

### 18 - Espanso
Para eliminar o pequeno quadro (inicialização do Espanso) mostrado quando o GNOME Shell é inicializado pela primeira vez modifique a opção "Status de inicialização" para Área de Trabalho na extensão Just Perfection.
<br><br>

### 19 - Rclone
Configurar o remote no rclone e fazer o scprit de sincronização.
<br><br>

### 20 - Conservation mode - Ideapad S145
Modo de conservação da bateria. Se for habilitado manterá a carga máxima da bateria em 60%.
Verifique se o módulo do kernel ideapad_laptop está carregado com o comando  `lsmod | grep ideapad`. Se não estiver os comandos indicados a seguir não irão funcionar.
Apure o valor presente no sistema com o seguinte comando:

`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Pode acontecer da pasta VPC2004:00 ter outra nomenclatura. Averigue no sistema.

Se o módulo estiver carregado no sistema e a pasta VPC2004:00 for a correta execute como root os comandos abaixo:

Para Habilitar

`echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Para desabilitar

`echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`
<br><br>

### 21 - Koreader - Wayland
`cp /usr/share/applications/koreader.desktop ~/.local/share/applications`

`nano ~/.local/share/applications/koreader.desktop`

`Exec=env SDL_VIDEODRIVER=wayland koreader %u`
