# Configurações necessárias após as execuções dos scripts

### 1 - Tema

Configure o tema dos programas que usam QT através dos aplicativos _Qt5
Settings_ e _Qt6 Settings_

Escolha o estilo breeze, paleta personalizada darker e tema de ícones breeze
dark. Na aba Fonts selecione a fonte Inter Variable (tamanho 11).

Nos programas que usam QT e permitem configurar a aparência (keepassxc, etc.)
escolha o tema breeze dark ou escuro.
<br><br>

### 2 - SSH

Configurar o Fail2ban - porta SSH e o SSH.
<br><br>

### 3 - NVMe

Não altere a identificação do ponto de montagem. Mude as flags (coloque
`defaults,noatime,x-gvfs-show,commit=60,barrier=0`) e o tipo de sistema de
arquivos (auto -> ext4) da partição do NVMe no aplicativo Discos. Lembrando que
essa configuração é para a partição do NVMe em que ficam instalados os jogos,
VMs e outros dados. Não é configuração a ser aplicada para a partição do
sistema, do boot ou a home.
<br><br>

### 4 - Nautilus

Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo
script número 3.

`echo "file:///mnt/ponto_de_montagem 🖴  NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 📤 Dropbox" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/.var/app/org.gnome.Podcasts/data/gnome-podcasts/Downloads 📻 Podcast" >>~/.config/gtk-3.0/bookmarks`
<br><br>

### 5 - Fstab

Acrescente nos parâmetros das partições **ext4** e montadas pelo sistema no boot
as seguintes especificações `commit=60` e `barrier=0`.

`sudo nano /etc/fstab`
<br><br>

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

Faça as configurações no fstab disponíveis no link
<https://wiki.archlinux.org/title/Fsck#fstab_options> para as partições do
sistema que são montadas no boot e que não sejam a partição root (Ext4) e a
partição boot. Lembrando que as partições devem ser Ext4. Sem essa configuração
(0 2) essas partições não serão verificadas pelo tune2fs na inicialização.

Verifique se as partições Ext4 estão em 64-bit, com o
[metadata checksums](https://wiki.archlinux.org/title/Ext4#Enabling_metadata_checksums_in_existing_filesystems),
o metadata_csum_seed e o orphan_file habilitados.

`sudo dumpe2fs -h /dev/caminho_da_partição | grep features`

Exemplo com as flags habilitadas:

```
Filesystem features: has_journal ext_attr resize_inode dir_index fast_commit
orphan_file filetype needs_recovery extent 64bit flex_bg metadata_csum_seed sparse_super large_file huge_file
dir_nlink extra_isize metadata_csum
```

Caso alguma das flags mencionadas acima não estejam na saída do comando, faça o
seguinte:

Verifique se o [módulo](https://wiki.archlinux.org/title/Kernel_module)
crc32c_intel está ativo (o i7-8565U possui a flag SSE 4.2 e pode operar com esse
módulo):

`lsmod | grep crc32c`

Se o módulo não estiver habilitado inclua-o nos
[módulos do mkinitcpio](https://wiki.archlinux.org/title/Mkinitcpio#MODULES).

A partição objeto do procedimento não pode estar montada para a execução dos
comandos abaixo.

`sudo e2fsck -Df /dev/caminho_da_partição` (otimização da partição -
obrigatório)

`sudo resize2fs -b /dev/caminho_da_partição` (conversão para 64-bit - somente se
o 64bit não estiver disponível na lista)

`sudo tune2fs -O metadata_csum /dev/caminho_da_partição` (habilitando o metadata
checksums - somente se o metadata_csum não estiver disponível na lista)

`sudo tune2fs -O metadata_csum_seed /dev/caminho_da_partição`

`sudo tune2fs -O orphan_file /dev/caminho_da_partição`

Verifique a lista novamente usando
`sudo dumpe2fs -h /dev/camimho_da_partição | grep features`

É possível habilitar o
[casefold](https://wiki.archlinux.org/title/Ext4#Enabling_case-insensitive_mode)
para case-insensitive mode. Lembrando que essa configuração não é aplicada
globalmente, necessitando que seja habilitada localmente na pasta desejada. Use
se tiver erros com jogos que precisem do wine e essa configuração seja indicada
em tutoriais para a solução do problema.

Verifique se o kernel possui o suporte para o casefold:

`cat /sys/fs/ext4/features/casefold`

Se suportar, habilite a flag com o comando abaixo:

`sudo tune2fs -O casefold /dev/caminho_da_partição`

Para habilitar o casefold em uma pasta, ela precisa estar vazia:

`chattr +F /caminho/para/a/pasta`

Para verificar se funcionou execute:

`lsattr /caminho/para/a/pasta`

```
----------------F--- /pasta
```

A letra F indica que a pasta está com o casefold habilitado.

Para retirar o casefold da pasta é preciso que o diretório esteja vazio. O
comando é o seguinte:

`chattr -F /caminho/para/a/pasta`
<br><br>

### 7 - Xpad

O controle Multilaser JS091 (Shanwan Controler) está funcionando corretamente
como Microsoft Corp. Xbox360 Controller (verifique com `lsusb`). Caso não
funcione instale a atualização para o Xpad disponível no site
<https://github.com/paroj/xpad> ou utilize o pacote disponível no AUR
`game-devices-udev` <https://codeberg.org/fabiscafe/game-devices-udev>
<br><br>

### 8 - Rclone

Configurar o remote no rclone e fazer o scprit de sincronização.
<br><br>

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
<br><br>

### 10 - Steam

Opções de inicialização para os jogos na Steam usando a placa dedicada Nvidia.

**OpenGL + Nvidia**

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

O prime-run no Arch Linux faz o mesmo que
`__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia`

Se porventura o Mangohud não inicializar, use o parâmetro
`LD_PRELOAD=/usr/lib/mangohud/libMangoHud.so:/usr/lib32/mangohud/libMangoHud.so`

**SOM**

Na eventualidade de o som não funcionar, tente executar os jogos com o parâmetro
`SDL_AUDIODRIVER=alsa`

**DXVK - Vulkan - Nvidia**

`STAGING_WRITECOPY=1 STAGING_SHARED_MEMORY=1 mangohud prime-run %command%`

O parâmetro `VKD3D_CONFIG=dxr11,dxr` habilita o raytracing.

**Gamemode**

Para executar o Gamemode acrescente `gamemoderun` nas opções de inicialização
dos jogos na Steam.

**FPS**

Uso o Mangohud para controlar o fps. Faço a configuração desse recurso pelo
Goverlay. Se possível, desabilito o VSync nas configurações dos jogos.

**Shaders**

Aumente a quantidade de cores para pré-compilar os shaders.

`echo "unShaderBackgroundProcessingThreads 10" >> ~/.steam/steam/steam_dev.cfg`

**Problemas com a transmissão ao vivo na Steam**

Execute no terminal (com a Steam fechada)

`steam-runtime steam://unlockh264/` ou `steam steam://unlockh264/`
<br><br>

### 11 - Heroic Games Launcher

Nas configurações do jogo, na opção "outros", habilite o MangoHud e o uso da
placa dedicada.

**Vulkan**

Na opção "avançado", configure as variáveis de ambiente para o Vulkan. Ex.: nome
da variável `STAGING_WRITECOPY` - Valor `1` Veja os restantes das variáveis no
item Steam / DXVK - Vulkan - Nvidia.

**OpenGL**

Para jogos OpenGL use a seguinte variável: nome da variável
`__GL_MaxFramesAllowed` valor `1`. Veja mais variáveis no item Steam / OpenGL +
Nvidia.
<br><br>

### 12 - Fallback

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
<br><br>

### 13 - Upscayl

Faça o download do appimage na página do
[github](https://github.com/upscayl/upscayl). Se o app não funcionar com a placa
dedicada out of the box, use o app flatpak Gear Lever para configurar o
appimage. Após selecionar para colocar o app no grid, coloque como variáveis de
ambiente (última opção da tela) o seguinte: Key = `VK_DRIVER_FILES` Value =
`/usr/share/vulkan/icd.d/nvidia_icd.json` e Key =
`__EGL_VENDOR_LIBRARY_FILENAMES` Value =
`/usr/share/glvnd/egl_vendor.d/10_nvidia.json` Isso fará com que o aplicativo
funcione com a placa dedicada.
<br><br>

### 14 - Bluetooth

Caso o bluetooth não esteja funcionando, execute
`sudo rfkill unblock bluetooth && sudo systemctl restart bluetooth`. Os pacotes
necessários para o funcionamento do bluetooth já foram instalados no sistema e
as configurações para os recursos experimentais do bluetooth foram executadas no
script número 3.
<br><br>

### 15 - Geoclue

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
<br><br>

### 16 - Aplicativos

#### Falhas na renderização

Se algum aplicativo GTK não funcionar adequadamente, utilize a variável
`GSK_RENDERER=gl`. Caso o app seja um flatpak suas configurações podem ser
alteradas no app Flatseal, mudando a variável em Environment.

#### Início no startup

Habilite a inicialização do Dropbox junto com o sistema. Use o app Ajustes e
faça a configuração em Aplicativos de inicialização.

#### Segundo plano

Desabilite o funcionamento dos aplicativos Podman Desktop, Gajim, Apostrophe,
Discord e Gnome Web em segundo plano. Pode ser feito pelo Flatseal ou pelas
configurações do Gnome (Aplicativos).
<br><br>

### 17 - Piper

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

<br>

### 18 - Firefox e Thunderbird

Altere os seguintes parâmetros nas configurações avançadas.

| Configuração                              | Valor | Firefox | Thunderbird |
| ----------------------------------------- | ----- | ------- | ----------- |
| general.smoothScroll                      | true  | X       | X           |
| general.smoothScroll.msdPhysics.enabled   | true  | X       | X           |
| gfx.webrender.all                         | true  | X       | X           |
| gfx.webrender.compositor                  | true  | X       | X           |
| gfx.webrender.precache-shaders            | true  | X       | X           |
| image.decode-immediately.enabled          | true  | X       | X           |
| image.jxl.enabled                         | true  | X       | X           |
| layout.frame_rate                         | 60    | X       | X           |
| media.eme.enabled                         | true  | X       |             |
| media.gmp.decoder.multithreaded           | true  | X       |             |
| media.gpu-process-decoder                 | true  | X       |             |
| media.webrtc.camera.allow-pipewire        | true  | X       |             |
| mousewheel.default.delta_multiplier_x     | 70    | X       | X           |
| mousewheel.default.delta_multiplier_y     | 70    | X       | X           |
| mousewheel.default.delta_multiplier_z     | 70    | X       | X           |
| mousewheel.min_line_scroll_amount         | 3     | X       | X           |
| widget.use-xdg-desktop-portal.file-picker | 1     | X       | X           |

<br>

### 19 - Newsflash

Caso a versão em flatpak do app Newsflash não tenha conexão com a rede, faça o
seguinte:

`nano ~/.var/app/io.gitlab.news_flash.NewsFlash/config/news-flash/newsflash_gtk.json`

Substitua a linha `"ping_url": "http://exemple.com/"` por
`"ping_url": "http://192.168.0.1/"`. O endereço 192.168.0.1 é o gateway.
Verifique qual é o gateway da sua rede.
<br>

### 20 - Ordem do boot

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
