# Configurações necessárias após as execuções dos scripts

### 1 - SSD

Habilite o cache de escrita e o APM com o valor de 254 no programa Discos.
<br><br>

### 2 - Tema

Configure o tema dos programas que usam QT através dos aplicativos _Qt5
Settings_ e _Qt6 Settings_

Escolha o estilo kvantum (configurado pelo script nº 3) e tema de ícones breeze
dark.

Nos programas que usam QT e permitem configurar a aparência (kdenlive, okular,
vlc, etc.) escolha o tema kvantum.

Execute os seguintes comandos para unificar os temas dos flatpaks instalados no
sistema.

O sufixo :ro (ex.: xdg-config/gtk-4:ro) indica read-only. Ele é opcional e
preferi não usá-lo.

`sudo flatpak override --filesystem=xdg-config/gtk-4.0`

`sudo flatpak override --filesystem=xdg-config/gtk-3.0`
<br><br>

### 3 - ImageMagick

Verifique o policy.xml do ImageMagick.

`sudo nano /etc/ImageMagick-7/policy.xml`

Comente as linhas `<policy domain= com <!-- (início) e --> (final da linha)`.
Ex.:

`<!-- <policy domain="module" rights="none" pattern="{PS,PDF,XPS}" /> -->`
<br><br>

### 4 - SSH

Configurar rkhunter, Fail2ban - porta SSH e o SSH.
<br><br>

### 5 - NVMe

Altere a identificação do ponto de montagem das partições do NVMe no aplicativo
discos.
<br><br>

### 6 - Nautilus

Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo
script número 3.

`echo "file:///mnt/nvme0n1p1 🖴  NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 🗃 Dropbox" >> ~/.config/gtk-3.0/bookmarks`
<br><br>

### 7 - Fstab

Acrescente nos parâmetros das partições ext4 e montadas pelo sistema no boot as
seguintes especificações `commit=60` e `barrier=0`.

`sudo nano /etc/fstab`
<br><br>

### 8 - Ext4

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

### 9 - Firefox

Copie o arquivo `user.js` da pasta firefox para o seu profile do navegador em
`~/.mozilla/firefox/pasta_do_profile`.
<br><br>

### 10 - Xpad

O controle Multilaser JS091 (Shanwan Controler) está funcionando corretamente
como Microsoft Corp. Xbox360 Controller (verifique com `lsusb`). Caso não
funcione instale a atualização para o Xpad disponível no site
<https://github.com/paroj/xpad> ou utilize o pacote disponível no AUR
`game-devices-udev` <https://codeberg.org/fabiscafe/game-devices-udev>
<br><br>

### 11 - Distrobox

Caso use alguma distro pelo Distrobox configure o atalho do desktop. Executar
usando o bash, com zsh ocorrem alguns problemas.

Exemplo com o Ubuntu:

`nano ~/.local/share/applications/ubuntu.desktop`

`Exec=/usr/bin/distrobox enter --name ubuntu -- bash -l` ou se quiser lançar com
o Wezterm:

`Exec=/usr/bin/wezterm -e --always-new-process distrobox-enter -n ubuntu -- bash -l`

Se usar o Wezterm para lançar a partir do .desktop modifique a opção Terminal no
arquivo .desktop para false - `Terminal=false`

Caso queira criar um atalho de teclado para lançar o Distrobox usando o terminal
do Gnome (se for o Wezterm é preciso configurar o comando para o atalho de
teclado - veja após a descrição para o terminal do Gnome), faça o seguinte:

Acesse o menu de Preferências do terminal do Gnome e crie um novo perfil com o
nome ubuntu (p.ex) e, na opção Comando personalizado (marque a opção Executar um
comando personalizado ...), coloque `distrobox enter --name ubuntu -- bash -l` .
O restante fica no padrão. Mude as cores do perfil para especificar a diferença
de uso do terminal (padrão ou Distrobox).

Nas configurações do sistema acesse Teclado - Atalhos de teclado.

Crie um atalho personalizado.

Nome : terminal ubuntu

Comando : `gnome-terminal --profile=ubuntu`

Caso queira inicializar usando o Wezterm o comando é o seguinte:
`wezterm -e --always-new-process distrobox-enter -n ubuntu -- bash -l`

Atalho : Shift + Ctrl + D
<br><br>

### 12 - Rclone

Configurar o remote no rclone e fazer o scprit de sincronização.
<br><br>

### 13 - Conservation mode - Ideapad S145

Modo de conservação da bateria. Se for habilitado manterá a carga máxima da
bateria em 60%. Verifique se o módulo do kernel ideapad_laptop está carregado
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

### 14 - Steam

Opções de inicialização para os jogos na Steam usando a placa dedicada Nvidia.

**OpenGL + Nvidia**

`__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/10_nvidia.json __GL_MaxFramesAllowed=1 SDL_DYNAMIC_API=/usr/lib64/libSDL2-2.0.so mangohud --dlsym prime-run %command%`

É possível utilizar o parâmetro `__GL_THREADED_OPTIMIZATIONS=1`, mas é preciso
efetuar testes. Tem jogos que não funcionam com ele.

O parâmetro `__GL_SYNC_TO_VBLANK=0` pode ajudar em jogos que estejam muito
lentos, mas o uso da GPU sobe consideravelmente.

Caso o `SDL_DYNAMIC_API=/usr/lib64/libSDL2-2.0.so` não funcione, substitua por
`SDL_VIDEODRIVER=X11`

O prime-run no Arch Linux faz o mesmo que
`__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia`

**DXVK - Vulkan - Nvidia**

`VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json STAGING_WRITECOPY=1 STAGING_SHARED_MEMORY=1 __GL_MaxFramesAllowed=1 PROTON_NO_ESYNC=1 PROTON_NO_FSYNC=1 mangohud prime-run %command%`

**Gamemode**

Para executar o Gamemode acrescente `gamemoderun` nas opções de inicialização
dos jogos na Steam.

**FPS**

Uso o Mangohud para controlar o fps. Faço a configuração desse recurso pelo
Goverlay. Se possível, desabilito o VSync nas configurações dos jogos.

**Shaders**

Aumente a quantidade de cores para pré-compilar os shaders.

`echo "unShaderBackgroundProcessingThreads 6" >> ~/.steam/steam/steam_dev.cfg`
<br><br>

### 15 - Heroic Games Launcher

Nas configurações do jogo, na opção "outros", habilite o MangoHud e o uso da
placa dedicada.

**Vulkan**

Na opção "avançado", configure a variável de ambiente para o Vulkan. Nome da
variável `VK_DRIVER_FILES` - Valor `/usr/share/vulkan/icd.d/nvidia_icd.json`

**OpenGL**

Para jogos OpenGL use as seguintes variáveis: 1ª nome da variável
`SDL_DYNAMIC_API` valor `/usr/lib64/libSDL2-2.0.so` 2ª nome da variável
`__EGL_VENDOR_LIBRARY_FILENAMES` valor
`/usr/share/glvnd/egl_vendor.d/10_nvidia.json`
<br><br>

### 16 - Intel SSD 660p - [Solidigm™ Storage Tool (SST)](https://www.solidigm.com/content/solidigm/us/en/support-page/drivers-downloads/ka-00085.html)

Para liberar o cache do disco NVMe instale o programa
[solidigm-sst-storage-tool-cli](https://aur.archlinux.org/packages/solidigm-sst-storage-tool-cli)
(AUR).

O ID do disco é apresentado com o comando `sudo sst show -ssd`

Ex.:

```
- PHNH************ -

Capacity : 512.11 GB (512,110,190,592 bytes)
DevicePath : /dev/nvme0n1
DeviceStatus : Healthy
Firmware : L02C
FirmwareUpdateAvailable : No known update for SSD. 
If an update is expected, please contact your SSD Vendor 
representative about firmware update for this drive.
Index : 0
MaximumLBA : 1000215215
ModelNumber : INTEL SSDPEKNW512G8L
ProductFamily : Intel SSD 660p Series
SMARTEnabled : True
SectorDataSize : 512
SerialNumber : PHNH************
```

As informações sobre o uso do cache são mostradas com o comando
`sudo sst show -ssd PHNH************ -performancebooster`

Ex.:

```
- Force Flush Info PHNH************ -

Percent SLC Buffer Available : 32
Percent Completion of SLC Buffer Eviction : 0
Time elapsed to complete SLC Buffer Flush (milliseconds) : 0
Total Number of Host Initialize : 37
Total Number of Host Cancel : 0
Total Number of Drive Initialize/Cancel : 0
```

No exemplo acima o NVMe está com 32% do cache disponível. Para liberar o cache
execute o comando `sudo sst start -ssd PHNH************ -performancebooster` Não
é mostrado o comando em execução. Depois de alguns minutos verifique o fim do
processo com o comando
`sudo sst show -ssd PHNH************ -performancebooster`. A linha
`Percent Completion of SLC Buffer Eviction` apresentará o valor de 100% quando a
execução do processo acabar. Infelizmente, por problemas com esse NVMe, tenho
que fazer esse procedimento semanalmente e não posso usar o disco até a sua
capacidade máxima. Se o disco ficar com a capacidade máxima preenchida ou
próximo a isso, ele irá travar em algum momento e corromper os dados. Se não
liberar o cache o desempenho degrada com o passar do tempo. Uso o disco NVMe
para jogos, VMs e outros dados não cruciais. Caso queira ver todas as
propriedades do disco o comando é `sudo sst show -all -ssd PHNH************`.
<br><br>

#### 17 - Fallback

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

#### 18 - Upscayl

Faça o download do appimage na página do
[github](https://github.com/upscayl/upscayl). Use o app flatpak Gear Lever para
configurar o appimage. Após selecionar para colocar o app no grid, coloque como
variáveis de ambiente (última opção da tela) o seguinte: Key = `VK_DRIVER_FILES`
Value = `/usr/share/vulkan/icd.d/nvidia_icd.json` e Key =
`__EGL_VENDOR_LIBRARY_FILENAMES` Value =
`/usr/share/glvnd/egl_vendor.d/10_nvidia.json` Isso fará com que o aplicativo
funcione com a placa dedicada.
