# Configurações necessárias após as execuções dos scripts

[1 - Tema e extensões](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#1---tema-e-extens%C3%B5es)
|
[2 - SSH](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#2---ssh)
|
[3 - NVMe](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#3---nvme)
|
[4 - Nautilus](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#4---nautilus)
|
[5 - Fstab](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#5---fstab)
|
[6 - Ext4](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#6---ext4)
|
[7 - Xpad](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#7---xpad)
|
[8 - Rclone](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#8---rclone)
|
[9 - Conservation mode - Lenovo Loq 15IRH8](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#9---conservation-mode---lenovo-loq-15irh8)
|
[10 - Steam](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#10---steam)
|
[11 - Fallback](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#11---fallback)
|
[12 - Bluetooth](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#12---bluetooth)
|
[13 - Geoclue](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#13---geoclue)
|
[14 - Aplicativos](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#14---aplicativos)
|
[15 - Piper](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#15---piper)
|
[16 - Ordem do boot](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#16---ordem-do-boot)
|
[17 - Upscayl](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#17---upscayl)
|
[18 - Zotero](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#18---zotero)
|
[19 - Incus](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#19---incus)
|
[20 - tmpfiles](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#20---tmpfiles)
|
[21 - sgpt](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#21---sgpt)
|
[22 - dns](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#22---dns)
|
[23 - easyeffects](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#23---easyeffects)
|
[24 - firefox](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#24---firefox)

### 1 - Tema e extensões

**Tema**

Nos programas que usam QT e permitem configurar a aparência (keepassxc,
kdenlive, etc.) escolha o tema breeze dark ou escuro.

**Extensões**

Uso as extensões Vitals, Blur my Shell, Alphabetical App Grid,
AppIndicator/KStatusNotifierItem e GNOME Fuzzy App Search habilitadas.

Para acessar as configurações das extensões use o
[Gerenciador de extensões](https://flathub.org/pt-BR/apps/com.mattjakeman.ExtensionManager)
(instalado pelo script n.° 4).

A extensão AppIndicator/KStatusNotifierItem foi intalada usando o repositório
oficial (instalada pelo script n.° 2 e habilitada pelo script n.° 3).

A extensão Vitals foi instalada usando o repositório oficial (script nº 3). Ela
foi configurada e habilitada pelo script nº 6.

As extensões Alphabetical App Grid, GNOME Fuzzy App Search e Blur my Shell foram
instaladas usando o AUR (script nº 5). As configurações para essas extensões
foram feitas pelo script nº 6.

### 2 - SSH

Configurar o Fail2ban - porta SSH e o SSH.

### 3 - NVMe

Não altere a identificação do ponto de montagem. Mude as flags (coloque
`defaults,noatime,x-gvfs-show,commit=60,barrier=0`) e o tipo de sistema de
arquivos (auto -> ext4) da partição do NVMe no aplicativo Discos - Opções
adicionais de partição - Editar opções de montagem. Lembrando que essa
configuração é para a partição do NVMe em que ficam instalados os jogos, VMs e
outros dados. Não é configuração a ser aplicada para a partição do sistema, do
boot ou a home. ![Screenshot1](.github/screenshots/discos.png)

### 4 - Nautilus

Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo
script número 3.

`echo "file:///mnt/ponto_de_montagem 🖴  NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 📤 Dropbox" >> ~/.config/gtk-3.0/bookmarks`

`mkdir ~/Documentos/Projetos && echo "file:///home/$USER/Documentos/Projetos 🎒 Projetos" >>~/.config/gtk-3.0/bookmarks`

### 5 - Fstab

Acrescente nos parâmetros da partição raiz **/** as seguintes especificações
`commit=60` e `barrier=0`.

`sudo nano /etc/fstab`

```
/               ext4            rw,noatime,commit=60,barrier=0  0 1
```

### 6 - Ext4

Habilite o
[fast commit](https://wiki.archlinux.org/title/Ext4#Enabling_fast_commit_in_existing_filesystems)
para todas as partições Ext4 do sistema.

`sudo tune2fs -O fast_commit /dev/caminho_da_partição`

Habilite a checagem do filesystem pelo tune2fs/e2fsck no boot para todas as
partições Ext4 do sistema (no comando abaixo a verificação está definida para
ser efetuada depois de 20 montagens da partição)

`sudo tune2fs -c 20 /dev/caminho_da_partição`

Para verificar se a configuração foi habilitada, execute:

`sudo dumpe2fs -h /dev/caminho_da_partição`

```
Maximum mount count:      20
```

Faça a configuração no fstab para habilitar a checagem do fsck nas partições que
são montadas na incialização do sistema e que **não** sejam a partição raiz (/)
e a partição do boot (/boot). Lembrando que as partições **devem** ser Ext4. Sem
essa configuração para a checagem do fsck na sexta coluna (0 2) essas partições
não serão verificadas pelo tune2fs na inicialização do sistema. Veja mais em
<https://wiki.archlinux.org/title/Fsck#fstab_options>

Verifique se as partições Ext4 estão em 64-bit, com o
[metadata checksums](https://wiki.archlinux.org/title/Ext4#Enabling_metadata_checksums_in_existing_filesystems),
o metadata_csum_seed e o orphan_file habilitados.

`sudo dumpe2fs -h /dev/caminho_da_partição | grep features`

Exemplo com as flags habilitadas:

```
Filesystem features: has_journal ext_attr resize_inode dir_index fast_commit orphan_file 
filetype needs_recovery extent 64bit flex_bg metadata_csum_seed sparse_super large_file 
huge_file dir_nlink extra_isize metadata_csum orphan_present
```

Caso alguma das flags mencionadas acima não estejam na saída do comando, faça o
seguinte:

A partição objeto do procedimento não pode estar montada para a execução dos
comandos abaixo.

`sudo e2fsck -Df /dev/caminho_da_partição` (otimização da partição -
obrigatório)

`sudo resize2fs -b /dev/caminho_da_partição` (conversão para 64-bit - somente se
o 64bit não estiver disponível na lista)

`sudo tune2fs -O metadata_csum /dev/caminho_da_partição` (habilitando o metadata
checksums - execute somente se o metadata_csum não estiver disponível na lista)

`sudo tune2fs -O metadata_csum_seed /dev/caminho_da_partição` (execute somente
se o metadata_csum_seed não estiver disponível na lista)

`sudo tune2fs -O orphan_file /dev/caminho_da_partição` (execute somente se o
orphan_file não estiver disponível na lista)

Verifique a lista novamente usando
`sudo dumpe2fs -h /dev/camimho_da_partição | grep features`

### 7 - Xpad

O controle Multilaser JS091 (Shanwan Controler) está funcionando corretamente
como Microsoft Corp. Xbox360 Controller (verifique com `lsusb`). Caso não
funcione instale a atualização para o Xpad disponível no site
<https://github.com/paroj/xpad> ou utilize o pacote disponível no AUR
`game-devices-udev` <https://codeberg.org/fabiscafe/game-devices-udev>

### 8 - Rclone

Configurar o remote no rclone e fazer o scprit de sincronização.

### 9 - Conservation mode - Lenovo Loq 15IRH8

Modo de conservação da bateria. Se for habilitado manterá a carga máxima da
bateria em 80%. Verifique se o módulo do kernel ideapad_laptop está carregado
com o comando `lsmod | grep ideapad`. Se não estiver os comandos indicados a
seguir não irão funcionar. Apure o valor presente no sistema com o seguinte
comando:

`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Pode acontecer da pasta VPC2004:00 ter outra nomenclatura. Averigue no sistema.

Se o módulo estiver carregado no sistema e a pasta VPC2004:00 for a correta
execute como root os comandos abaixo:

Para Habilitar

`echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Para desabilitar

`echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

### 10 - Steam

**Proton**

Para jogos que não sejam nativos do Linux, utilize o Proton para ter a
compatibilidade com o sistema. Para informações sobre como habilitar o Proton na
Steam, acesse <https://wiki.archlinux.org/title/Steam#Proton_Steam-Play>

**DXVK - Vulkan - Nvidia**

Usado para jogos que necessitam do Proton.

`STAGING_WRITECOPY=1 STAGING_SHARED_MEMORY=1 mangohud prime-run %command%`

O prime-run no Arch Linux faz o mesmo que
`__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia`

O parâmetro `VKD3D_CONFIG=dxr11,dxr` habilita o raytracing.

O parâmetro `PROTON_ENABLE_WAYLAND=1` habilita o wine-wayland usando o
[Proton-CachyOS](https://github.com/CachyOS/proton-cachyos) ou o
[Proton-ge-custom](https://github.com/GloriousEggroll/proton-ge-custom). Utilize
o app ProtonPlus (instalado pelo script nº 4) para instalar esses protons
modificados pela comunidade.

**Ntsync**

Para usar o [ntsync](https://wiki.archlinux.org/title/Wine#xSync) com o
Proton-GE (>=GE-Proton10-10) é preciso habilitar o módulo desse recurso no
kernel (>=6.15.7-arch1-1).

`sudo nano /etc/modules-load.d/ntsync.conf`

```
# Automaticaly load ntsync kernel module at every boot

ntsync
```

Reinicie o sistema e verifique o funcionamento do módulo com os comandos
`modinfo ntsync` e `ls /dev/ntsync`.

O ntsync é ativado por padrão, caso o módulo esteja carregado com o kernel. Não
é mais necessário o parâmetro `PROTON_USE_NTSYNC=1` para habilitar o ntsync no
jogo. Para verificar o funcionamento utilize o Goverlay para configurar a opção
_Wine Sync_ no mangohud. Não é mais preciso utilizar o parâmetro
`PROTON_USE_WOW64=1` para jogos mais antigos (32 bits) ao usar o ntsync com o
Proton-GE. Esse parâmetro é habilitado por padrão.

**OpenGL + Nvidia**

Utilizado em jogos nativos do sistema e que não precisam da compatibilidade do
Proton.

`__GL_MaxFramesAllowed=1 mangohud --dlsym prime-run %command%`

É possível utilizar o parâmetro `__GL_THREADED_OPTIMIZATIONS=1`, mas é preciso
efetuar testes. Tem jogos que não funcionam com ele.

O parâmetro `__GL_SYNC_TO_VBLANK=0` pode ajudar em jogos que estejam muito
lentos, mas o uso da GPU sobe consideravelmente.

Caso o jogo não inicie use a variável `SDL_VIDEODRIVER=X11`. Se ela não
funcionar, substitua por `SDL_DYNAMIC_API=/usr/lib64/libSDL2-2.0.so`

Se o jogo apresentar o erro
`gameoverlayrenderer.so' from LD_PRELOAD cannot be preloaded` (execute a Steam
pelo terminal para verificar), use os parâmetros
`LD_PRELOAD="libpthread.so.0 libGL.so.1" __GL_MaxFramesAllowed=1 mangohud --dlsym prime-run %command%`.
Caso ele não funcione faça um teste usando os parâmetros
`LD_PRELOAD=~/.local/share/Steam/ubuntu12_64/gameoverlayrenderer.so __GL_MaxFramesAllowed=1 mangohud --dlsym prime-run %command%`
Esse erro não costuma impedir a abertura do jogo ou interferir na jogabilidade.

Se porventura o Mangohud não inicializar, use o parâmetro
`LD_PRELOAD=/usr/lib/mangohud/libMangoHud.so:/usr/lib32/mangohud/libMangoHud.so`

**Gamescope + Nvidia**

Se for usar o Gamescope (instalado pelo script nº3) em vez de DXVK - Vulkan ou
OpenGL, utilize os parâmetros abaixo.

`gamescope -W 1920 -H 1080 -r 60 -f --mangoapp -- prime-run %command%`

O comando acima executa os jogos através do xwayland, com resolução de 1920x1080
`-W 1920 -H 1080`, limitado a 60 fps `-r 60`, fullscreen `-f`, com o mangohud
habilitado `--mangoapp`, usando a placa dedicada `prime-run`. A flag `-e` serve
apenas para executar o Steam dentro do Gamescope, ou seja,
`gamescope -e -- steam`. A flag `--expose-wayland` é para aplicativos Wayland
nativos que não funcionam em xwayland. Para mais informações acesse
<https://wiki.archlinux.org/title/Gamescope> e
<https://github.com/ValveSoftware/gamescope/issues/1819#issuecomment-2817280797>

**SOM**

Na eventualidade de o som não funcionar, tente executar os jogos com o parâmetro
`SDL_AUDIODRIVER=alsa`

**Gamemode**

Não uso o gamemode. O funcionamento do gamemode conflita com o ananicy-cpp.

**FPS**

Uso o Mangohud para controlar o fps. Faço a configuração desse recurso pelo
Goverlay.

**Shaders**

Aumente a quantidade de cores para pré-compilar os shaders.

`echo "unShaderBackgroundProcessingThreads 10" >> ~/.steam/steam/steam_dev.cfg`

Habilite o download prévio dos sombreadores nas configurações da Steam
(Configurações - Download - Sombreadores).

**Problemas com a transmissão ao vivo na Steam**

Execute no terminal (com a Steam fechada)

`steam-runtime steam://unlockh264/` ou `steam steam://unlockh264/`

### 11 - Fallback

Caso a imagem para o kernel fallback esteja sendo gerada pelo mkinitcpio, faça o
seguinte:

`sudo nano /etc/mkinitcpio.d/linux.preset`

Mude a linha `PRESETS=('default' 'fallback')` para

`PRESETS=('default')`

Se o sistema possui outros kernels instalados, eles estarão na mesma pasta. Ex.:
o kernel lts estará com o preset `linux-lts.preset`

É preciso deletar as entradas para o loader do systemd-boot e as imagens do
fallback. Os arquivos possuem fallback no nome. Fique atento a esse detalhe.

`sudo rm /boot/loader/entries/linux-fallback.conf`

`sudo rm /boot/initramfs-linux-fallback.img`

Regenere o initramfs:

`sudo mkinitcpio -P`

### 12 - Bluetooth

Caso o bluetooth não esteja funcionando, execute
`sudo rfkill unblock bluetooth && sudo systemctl restart bluetooth`. Os pacotes
necessários para o funcionamento do bluetooth já foram instalados no sistema e
as configurações para os recursos experimentais do bluetooth foram executadas no
script número n.° 3.

### 13 - Geoclue

**Geoclue estático**

Se preferir usar o geoclue estático, faça as configurações abaixo.

No arquivo de configuração abaixo deixe `enable=true` somente na opção
`[static-source]`

`sudo nano /etc/geoclue/geoclue.conf`

Construa o arquivo para o Geoclue estático

`sudo nano /etc/geolocation`

Exemplo de conteúdo para o arquivo `gelocation`. Verifique a latitude e a
longitude usando o Google Maps. Coloque 1.0 na altura e 20.00 no radius. Remova
os comentários.

```
# Example static location file for a machine inside Statue of Liberty torch
40.6893129   # latitude
-74.0445531  # longitude
96           # altitude
1.83         # accuracy radius (the diameter of the torch is 12 feet)
```

Execute: `sudo chown geoclue /etc/geolocation` e
`sudo chmod 600 /etc/geolocation`

Reinicie o serviço `sudo systemctl restart geoclue.service`

Verifique o status do serviço `sudo systemctl status geoclue.service`

Verifique o funcionamento do Geoclue estático com o comando
`/usr/lib/geoclue-2.0/demos/where-am-i` e no programa GNOME Maps.

**Desabilitar o serviço**

Se quiser desabilitar o Geoclue use os seguintes comandos:

`gsettings set org.gnome.system.location enabled false` ou

`sudo systemctl mask geoclue.service`

Manual do [Geoclue](https://man.archlinux.org/man/extra/geoclue/geoclue.5.en)

### 14 - Aplicativos

**Falhas na renderização**

Se a renderização de um aplicativo GTK não funcionar adequadamente utilizando o
vulkan, utilize a variável `GSK_RENDERER=ngl`. Caso o app seja um flatpak suas
configurações podem ser alteradas no app Flatseal, mudando a variável em
Environment. Confira as variáveis do sistema (globais) para flatpaks com o
comando `cat /var/lib/flatpak/overrides/global` Para retirar essas variáveis
apague a entrada no arquivo `/var/lib/flatpak/overrides/global`. As variáveis
configuradas para um determinado aplicativo flatpak estão localizadas em
`~/.local/share/flatpak/overrides`

**Início no startup**

Habilite a inicialização do Dropbox junto com o sistema. Use o app Ajustes e
faça a configuração em Aplicativos de inicialização.

**Segundo plano**

Desabilite o funcionamento dos aplicativos Apostrophe e Discord em segundo
plano. Pode ser feito pelo Flatseal ou pelas configurações do Gnome
(Aplicativos).

### 15 - Piper

Se optar por alterar a vozes usadas no speech-dispatcher para as
disponibilizadas pelo projeto [Piper](https://github.com/rhasspy/piper), faça os
procedimentos abaixo.

Efetue o [download](https://github.com/rhasspy/piper/releases) do último binário
(piper_linux_x86_64.tar.gz) para sistemas Linux disponibilizado no site do
projeto no Github.

Descompacte o arquivo `tar -xf piper_linux_x86_64.tar.gz` no seu diretório
$HOME. Crie o diretório voices no diretório descompactado.
`mkdir -p ~/piper/voices`

Crie o arquivo urls.txt e insira o seguinte conteúdo:

```
https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/pt/pt_BR/faber/medium/pt_BR-faber-medium.onnx.json
https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/pt/pt_BR/faber/medium/pt_BR-faber-medium.onnx
https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/ryan/medium/en_US-ryan-medium.onnx.json
https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/ryan/medium/en_US-ryan-medium.onnx
```

O site [huggingface.co](https://huggingface.co/rhasspy/piper-voices/tree/main)
disponibiliza outras vozes.

Para download utilize o comando
`wget --directory-prefix ~/piper/voices --input-file urls.txt`

Configure o módulo piper no speech-dispatcher.

`mkdir -p ~/.config/speech-dispatcher/modules`

`nano ~/.config/speech-dispatcher/modules/piper.conf`

Insira o conteúdo abaixo.

```
GenericExecuteSynth "if command -v sox > /dev/null; then\
        PROCESS=\'sox -r 22050 -c 1 -b 16 -e signed-integer -t raw - -t wav - tempo $RATE pitch $PITCH norm\'; OUTPUT=\'$PLAY_COMMAND\';\
    elif command -v paplay > /dev/null; then\
        PROCESS=\'cat\'; OUTPUT=\'$PLAY_COMMAND --raw --channels 1 --rate 22050\';\
    else\
        PROCESS=\'cat\'; OUTPUT=\'aplay -t raw -c 1 -r 22050 -f S16_LE\';\
    fi;\
    echo \'$DATA\' | ~/piper/piper --model ~/piper/voices/pt_BR-faber-medium.onnx --output_raw | $PROCESS | $OUTPUT;"
GenericRateAdd 2
GenericPitchAdd 1
GenericVolumeAdd 1
GenericRateMultiply 1
GenericPitchMultiply 1000
AddVoice "pt-BR" "male1" "pt_BF-faber-medium"
AddVoice "en-US" "male1" "en_US-ryan-medium"
```

Crie o arquivo speechd.conf

`nano ~/.config/speech-dispatcher/speechd.conf`

Insira o conteúdo abaixo.

```
## Fonte: /etc/speech-dispatcher/speechd.conf
##
AddModule "piper" "sd_generic" "piper.conf"
DefaultVoiceType  "male1"
#DefaultLanguage   pt-BR
DefaultModule   piper
LogLevel  3
LogDir  "default"
DefaultVolume 100
SymbolsPreproc "char"
SymbolsPreprocFile "gender-neutral.dic"
SymbolsPreprocFile "font-variants.dic"
SymbolsPreprocFile "symbols.dic"
SymbolsPreprocFile "emojis.dic"
SymbolsPreprocFile "orca.dic"
SymbolsPreprocFile "orca-chars.dic"
Include "clients/*.conf"
```

As configurações anteriores ajustam o speech-dispatcher para o idioma pt-BR.
Para alterar para o inglês ou voltar para o pt-BR, use os seguintes alias:

```
alias piper-pt="sed -i 's/en_US-ryan-medium.onnx/pt_BR-faber-medium.onnx/g' ~/.config/speech-dispatcher/modules/piper.conf"
alias piper-en="sed -i 's/pt_BR-faber-medium.onnx/en_US-ryan-medium.onnx/g' ~/.config/speech-dispatcher/modules/piper.conf"
```

Para testar o funcionamento use o comando spd-say ou habilite o Screen Reader
nas configurações de acessibilidade do GNOME.

```
spd-say "oi como você está?"
spd-say "You’re playing a dangerous game Carl"
```

### 16 - Ordem do boot

Verifique o ID do kernel com o comando `bootctl list`. Selecione o kernel que
você deseja para a inicialização do sistema com o comando
`sudo bootctl set-default ID_do_kernel` Faça o update do
[systemd-boot](https://wiki.archlinux.org/title/Systemd-boot) com o comando
`sudo bootctl update`. Para alterar o tempo de exibição ou esconder a tela de
apresentação das opções de inicialização do sistema edite o arquivo
`loader.conf` em `/boot/loader/loader.conf`. Na opção `timeout` defina o tempo
desejado (em segundos) da exibição ou coloque 0 para esconder as opções de
inicialização. Para acessar a tela, caso opte por escondê-la, após ligar o
notebook pressione a barra de espaço do teclado.

### 17 - Upscayl

Caso queira utilizar a versão em Appimage efetue o download na página do
[github](https://github.com/upscayl/upscayl). A versão em flatpak foi instalada
pelo script número n.° 4. Se o app não funcionar com a placa dedicada out of the
box, use o app flatpak Gear Lever para configurar o appimage. Após selecionar
para colocar o app no grid, coloque como variáveis de ambiente (última opção da
tela) o seguinte: Key = `VK_DRIVER_FILES` Value =
`/usr/share/vulkan/icd.d/nvidia_icd.json` e Key =
`__EGL_VENDOR_LIBRARY_FILENAMES` Value =
`/usr/share/glvnd/egl_vendor.d/10_nvidia.json` Isso fará com que o aplicativo
funcione com a placa dedicada.

### 18 - Zotero

Faça o download do arquivo xpi das seguintes extensões:

- [better notes](https://github.com/windingwind/zotero-better-notes)
- [OCR](https://github.com/UB-Mannheim/zotero-ocr)

Para a extensão OCR funcionar é necessária a instalação dos pacotes poppler,
poppler-data, tesseract, tesseract-data-eng e tesseract-data-por. Esses pacotes
foram instalados pelo script n.º 3. Nas configurações da extensão no Zotero
configure a localização para o tesseract `/usr/bin/tesseract` e para o pdftoppm
`/usr/bin/pdftoppm`.

### 19 - Incus

Execute os seguintes comandos para configurar o Incus.

Configuração do profile

`incus admn init`

O Arch Linux não distribui firmware ovmf com secure boot assinado. Para iniciar
máquinas virtuais, você precisa desativar o secure boot. Inclua a configuração
no profile padrão.
[Arch Wiki - Incus](https://wiki.archlinux.org/title/Incus#Starting_a_virtual_machine_fails)

`incus profile set default security.secureboot=false`

Com o uso do firewalld, é necessário desabilitar as regras de firewall incluídas
no Incus e adicionar as regras para o Incus no firewalld.
[Incus Firewall](https://linuxcontainers.org/incus/docs/main/howto/network_bridge_firewalld/)

O nome da interface da rede `incusbr0` é a escolhida por padrão nas
configurações do profile. Caso altere o nome, substitua nos comandos abaixo.

`incus network set incusbr0 ipv4.firewall false`

`sudo firewall-cmd --zone=trusted --change-interface=incusbr0 --permanent`

`sudo firewall-cmd --reload`

### 20 - tmpfiles

O arquivo de configuração para cada ação deve ser alocado em `/etc/tmpfiles.d/`

Exemplo:

`sudo nano /etc/tmpfiles.d/captura.conf`

o `e` significa que a ação de remoção dos arquivos se dará sobre uma pasta
existente

Os números `0755` indicam as permissões. Se usar o `e`, coloque as mesmas
permissões da pasta existente.

`user user` Refere-se ao usuário e ao grupo

`2d` refere-se ao tempo. No caso, remoção dos arquivos criados há dois dias na
pasta Capturas de tela.

```
e /home/user/Imagens/'Capturas de tela' 0755 user user 2d
```

Para pastas criadas pelo serviço, ao invés de usar `e`, usa-se `d`.

Existe a opção de remoção para pasta ou somente para um arquivo específico.

Veja mais opções em `man tmpfiles.d` e `man systemd-tmpfiles`

Depois de concebido o arquivo, execute

`sudo systemd-tmpfiles --create`

### 21 - sgpt

**Instalação**

Use vinculado com o Ollama (instalado pelo script nº 3).

`pipx install "shell-gpt[litellm]"`

**Configuração**

Execute o comando abaixo. Depois de `--model` coloque um modelo que esteja
instalado no Ollama (gemma3:4b é um exemplo).

`sgpt --model ollama/gemma3:4b "como saber a versão do shell"`

Após executar o comando será requisitada OpenAI API key.

Insira somente letras. Não use números ou caracteres especiais. Ex.:
jdsnsdjjkajnsjsjjs

Após digitar e teclar enter, possivelmente será apresentado um erro, mas mesmo
se não acontecer o erro, modifique o arquivo de configuração.

`nano ~/.config/shell_gpt/.sgptrc`

Altere as variáveis abaixo. (lembrando que gema3:4b é um exemplo)

```
DEFAULT_MODEL=ollama/gemma3:4b
OPENAI_USE_FUNCTIONS=false
USE_LITELLM=true
```

Se ainda não funcionar, experimente substituir a variável da URL do Ollama.

```
API_BASE_URL=http://127.0.0.1:11434
```

[Fonte - github shell_gpt](https://github.com/TheR1D/shell_gpt/wiki/Ollama)

### 22 - dns

A instalação do
[systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved) e a
configuração para o NetworkManager foi feita no script nº 2.

Utilizo pelo systemd-resolved o dns da Quad9 com o DNS over TLS e o DNSSEC
habilitados. Desabilite o DNS over HTTPS nos navegadores web.

Verifique o funcionamento do systemd-resolved e se a configuração do dns foi
aplicada.

`resolvectl status`

Teste se o dns da Quad9 está funcionando adequadamente.

`sudo pacman -S bind --needed`

`dig +short txt proto.on.quad9.net`

Se a resposta for `dot.`, _está funcionando_! Se a resposta for `do53-udp.`,
ainda está usando plaintext. Se não houver resposta, significa que o Quad9 não
foi configurado adequadamente. Veja mais informações em
[quad9](https://docs.quad9.net/)

Teste - DNSSEC

`resolvectl query sigok.verteiltesysteme.net`

Deve retornar o IP e mostrar "authenticated: yes", se o DNSSEC estiver
habilitado corretamente no sistema.

Domínio com assinatura inválida

`resolvectl query sigfail.verteiltesysteme.net`

Deve falhar com erro "DNSSEC validation failed: invalid"

### 23 - easyeffects

Configuração do EasyEffects para aplicar a equalização paramétrica para o
Headset HyperX Cloud Stinger.

Nas preferências do aplicativo habilite a opção "Iniciar o Serviço na
Inicialização do Sistema"

Faça o download do arquivo
[hyperx.json](https://github.com/henriqueffc/archpost-installation/blob/main/easyeffects/hyperx.json)
que está no diretório `easyeffects` do repositório.

Na aba "Saídas", clique em "Predefinições" e acesse a opção "Importe uma
predefinição do armazenamento local".

Depois em "Predefinições" clique em "Carregar" na frente do nome da predefinição
(hyperx).

A predefinição habilita a equalização de áudio aplicando as definições
disponíveis no repositório
[AutoEq](https://github.com/jaakkopasanen/AutoEq/tree/master/results/Rtings/HMS%20II.3%20over-ear/HyperX%20Cloud%20Stinger)

Selecione como dispositivo de saída de som nas configurações do GNOME o
Headphones. Não selecione o
[Easy Effects Skin](https://github.com/wwmm/easyeffects?tab=readme-ov-file#warning).

É possível usar a extensão do GNOME
[EasyEffects Preset Selector](https://extensions.gnome.org/extension/4907/easyeffects-preset-selector/)
para alternar rapidamente entre as predefinições do EasyEffects.

### 24 - firefox

Uso o tema
[Gnome Adwaita GTK4 Dark](https://addons.mozilla.org/pt-BR/firefox/addon/gnome-adwaita-gtk4-dark/)

Configurações feitas em `about:config`

| Configuração                                                                                                       | Valor   |
| ------------------------------------------------------------------------------------------------------------------ | ------- |
| browser.cache.disk.enable                                                                                          | false   |
| browser.cache.memory.capacity (131072 = 128 MB)                                                                    | 131072  |
| browser.cache.memory.max_entry_size (20480 = 20 MB)                                                                | 20480   |
| browser.cache.memory.enable                                                                                        | true    |
| browser.display.document_color_use                                                                                 | 0       |
| browser.ml.chat.enabled                                                                                            | true    |
| browser.ml.linkPreview.enabled                                                                                     | true    |
| browser.profiles.enabled                                                                                           | true    |
| browser.theme.native-theme (para o gnome, teste o valor false, mas não precisa com o tema Gnome Adwaita GTK4 Dark) | false   |
| browser.newtabpage.activity-stream.newtabWallpapers.enabled                                                        | true    |
| browser.newtabpage.activity-stream.showWeather                                                                     | true    |
| browser.newtabpage.activity-stream.system.showWeather                                                              | true    |
| browser.sessionstore.interval                                                                                      | 60000   |
| browser.tabs.groups.enabled                                                                                        | true    |
| browser.toolbars.bookmarks.visibility                                                                              | always  |
| browser.urlbar.scotchBonnet.enableOverride                                                                         | true    |
| dom.enable_web_task_scheduling                                                                                     | true    |
| dom.ipc.forkserver.enable                                                                                          | true    |
| dom.security.https_only_mode                                                                                       | true    |
| extensions.pocket.enabled                                                                                          | false   |
| general.smoothScroll                                                                                               | true    |
| general.smoothScroll.msdPhysics.enabled                                                                            | true    |
| gfx.canvas.remote                                                                                                  | true    |
| gfx.canvas.accelerated.cache-size                                                                                  | 512     |
| image.jxl.enabled (nightly)                                                                                        | true    |
| dom.webgpu.enabled (nightly)                                                                                       | true    |
| gfx.content.skia-font-cache-size                                                                                   | 20      |
| gfx.webrender.all                                                                                                  | true    |
| gfx.webrender.compositor                                                                                           | true    |
| gfx.webrender.compositor.force-enabled                                                                             | true    |
| gfx.webrender.precache-shaders                                                                                     | true    |
| gfx.x11-egl.force-disabled                                                                                         | true    |
| layout.css.prefers-color-scheme.content-override                                                                   | 0       |
| layout.css.grid-template-masonry-value.enabled                                                                     | true    |
| layout.frame_rate                                                                                                  | 60      |
| javascript.options.wasm_branch_hinting                                                                             | true    |
| javascript.options.wasm_relaxed_simd                                                                               | true    |
| media.av1.enabled                                                                                                  | true    |
| media.eme.enabled                                                                                                  | true    |
| media.gmp.decoder.multithreaded                                                                                    | true    |
| media.gpu-process-decoder                                                                                          | true    |
| media.peerconnection.video.vp9_preferred                                                                           | false   |
| media.webrtc.camera.allow-pipewire                                                                                 | true    |
| mousewheel.default.delta_multiplier_x                                                                              | 70      |
| mousewheel.default.delta_multiplier_y                                                                              | 70      |
| mousewheel.default.delta_multiplier_z                                                                              | 70      |
| mousewheel.min_line_scroll_amount                                                                                  | 3       |
| network.trr.mode //habilito o DNS over TLS, DNSSEC e o uso da Quad9 como resolvedor de DNS no systemd-resolved     | 5       |
| reader.color_scheme                                                                                                | dark    |
| reader.text_alignment                                                                                              | justify |
| sidebar.revamp                                                                                                     | true    |
| sidebar.verticalTabs                                                                                               | true    |
| widget.gtk.non-native-titlebar-buttons.enabled                                                                     | false   |
| widget.gtk.rounded-bottom-corners.enabled (não estou usando, bug nos cantos inferiores)                            | true    |
| widget.use-xdg-desktop-portal.file-picker                                                                          | 1       |
