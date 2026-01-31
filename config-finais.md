# Configurações

Execute as configurações somente após a conclusão de todos os scripts do
repositório.

[Tema e extensões](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#tema-e-extens%C3%B5es)
|
[SSH](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#ssh)
|
[Nautilus](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#nautilus)
|
[Ext4](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#ext4)
|
[Xpad](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#xpad)
|
[Rclone](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#rclone)
|
[Conservation mode - Lenovo Loq 15IRH8](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#conservation-mode---lenovo-loq-15irh8)
|
[Steam](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#steam)
|
[Fallback](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#fallback)
|
[Bluetooth](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#bluetooth)
|
[Geoclue](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#geoclue)
|
[Aplicativos](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#aplicativos)
|
[Piper](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#piper)
|
[Ordem do boot](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#ordem-do-boot)
|
[Zotero](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#zotero)
|
[Incus](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#incus)
|
[tmpfiles](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#tmpfiles)
|
[sgpt](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#sgpt)
|
[dns](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#dns)
|
[easyeffects](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#easyeffects)
|
[firefox](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#firefox)
|
[igpu](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#igpu)
|
[Homebrew](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#Homebrew)
|
[boot](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md#boot)

## Tema e extensões

**Tema**

Nos programas que usam QT e permitem configurar a aparência escolha o tema
breeze dark ou escuro.

**Extensões**

Uso as extensões [Vitals](https://extensions.gnome.org/extension/1460/vitals/),
[Alphabetical App Grid](https://extensions.gnome.org/extension/4269/alphabetical-app-grid/),
[AppIndicator/KStatusNotifierItem habilitadas](https://extensions.gnome.org/extension/615/appindicator-support/),
[Wallpaper Slideshow](https://extensions.gnome.org/extension/6281/wallpaper-slideshow/),
[Auto Accent Colour](https://extensions.gnome.org/extension/7502/auto-accent-colour/),
[Foresight](https://extensions.gnome.org/extension/7901/foresight/) e
[Overview Background](https://extensions.gnome.org/extension/5856/overview-background/).

Para acessar as configurações das extensões use o programa Extensões que é
instalado com o GNOME.

A extensão AppIndicator/KStatusNotifierItem foi intalada usando o repositório
oficial (instalada pelo script n.° 2 e habilitada pelo script n.° 3).

A extensão Vitals foi instalada usando o repositório oficial (script nº 3). Ela
foi configurada e habilitada pelo script nº 6.

A extensão Alphabetical App Grid foi instalada usando o AUR (script nº 5). A
configuração para essa extensão foi feita pelo script nº 6.

A extensão Auto Accent Colour foi instalada usando o AUR (pelo script nº 5) e
habilitada pelo script nº 6.

A extensão Wallpaper Slideshow foi instalada usando o AUR (pelo script nº 5) e
habilitada pelo script nº 6.

As extensões Foresight e Overview Background foram instaladas pela página
[https://extensions.gnome.org/](https://extensions.gnome.org/). O pacote
necessário para essa funcionalidade
([gnome-browser-connector](https://archlinux.org/packages/extra/any/gnome-browser-connector/))
foi instalado pelo script nº 3. Para instalar a extensão pelo navegador é
preciso habilitar a extensão "Integração com o Gnome Shell"
([Firefox](https://addons.mozilla.org/firefox/addon/gnome-shell-integration/) /
[Chrome](https://chromewebstore.google.com/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep)).

## SSH

Configurar o Fail2ban - porta SSH e o SSH.

## Nautilus

Atalhos no Nautilus (File). A fonte que contém os símbolos foi instalada pelo
script número 3.

`echo "file:///mnt/ponto_de_montagem 🖴  NVME" >> ~/.config/gtk-3.0/bookmarks`

`echo "file:///home/$USER/Dropbox 📤 Dropbox" >> ~/.config/gtk-3.0/bookmarks`

`mkdir ~/Documentos/Projetos && echo "file:///home/$USER/Documentos/Projetos 🎒 Projetos" >>~/.config/gtk-3.0/bookmarks`

## Ext4

Habilite o
[fast commit](https://wiki.archlinux.org/title/Ext4#Enabling_fast_commit_in_existing_filesystems)
para todas as partições Ext4 do sistema.

`sudo tune2fs -O fast_commit /dev/caminho_da_partição`

Para verificar se o fast_commit está em uso, execute (após reboot)
`sudo cat /proc/fs/ext4/ID_partição/fc_info`

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

## Xpad

O controle Multilaser JS091 (Shanwan Controler) está funcionando corretamente
como Microsoft Corp. Xbox360 Controller (verifique com `lsusb`). Caso não
funcione instale a atualização para o Xpad disponível no site
<https://github.com/paroj/xpad> ou utilize o pacote disponível no AUR
`game-devices-udev` <https://codeberg.org/fabiscafe/game-devices-udev>

## Rclone

Configurar o remote no rclone e fazer o scprit de sincronização.

## Conservation mode - Lenovo Loq 15IRH8

Modo de conservação da bateria. Se for habilitado manterá a carga máxima da
bateria em 80%. No painel de configuração do GNOME, na opção "Energia", em
"Carregamento da bateria", é possível habilitar o modo de conservação da
bateria. Para fazer isso manualmente, verifique se o módulo do kernel
`ideapad_laptop` está carregado com o comando `lsmod | grep ideapad`. Se o
módulo não estiver carregado, os comandos indicados a seguir não funcionarão.
Apure o valor presente no sistema com o seguinte comando:

`cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Pode acontecer da pasta VPC2004:00 ter outra nomenclatura. Averigue no sistema.

Se o módulo estiver carregado no sistema e a pasta VPC2004:00 for a correta
execute como root os comandos abaixo:

Para Habilitar

`echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

Para desabilitar

`echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode`

## Steam

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
kernel (>=6.15.7-arch1-1). No Arch Linux não é preciso habilitar o módulo ntsync
se você instala as versões presentes no repositório da distro do wine ou
wine-staging. Esses pacotes habilitam o módulo ntsync por padrão no sistema a
partir da versão 10.16-1.

Verifique o funcionamento do módulo com os comandos `modinfo ntsync` e
`ls /dev/ntsync`.

O ntsync é ativado por padrão, caso o módulo esteja carregado com o kernel. Não
é mais necessário o parâmetro `PROTON_USE_NTSYNC=1` para habilitar o ntsync no
jogo, caso use o Proton-GE. Para verificar o funcionamento utilize o Goverlay
para configurar a opção _Wine Sync_ no mangohud ou utilize o comando no terminal
`lsof /dev/ntsync` ao executar um jogo. Não é mais preciso utilizar o parâmetro
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

Caso o jogo não inicie use a variável `SDL_VIDEODRIVER=X11`. Isso pode ocorrer
devido a variável de ambiente `SDL_VIDEODRIVER="wayland,x11,windows"` presente
em `/etc/environment.d/90-environment.conf`. O mesmo vale para jogos executados
usando o Heroic Games Launcher (ex. Huntdown). Na Heroic configure a variável de
ambiente nas opções de configuração do jogo, "Advanced", "Environment
Variables". Se ela não funcionar, substitua por
`SDL_DYNAMIC_API=/usr/lib64/libSDL2-2.0.so`

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

## Fallback

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

## Bluetooth

Caso o bluetooth não esteja funcionando, execute
`sudo rfkill unblock bluetooth && sudo systemctl restart bluetooth`. Os pacotes
necessários para o funcionamento do bluetooth já foram instalados no sistema e
as configurações para os recursos experimentais do bluetooth foram executadas no
script número n.° 3.

## Geoclue

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

## Aplicativos

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

Habilite a inicialização do Dropbox junto com o sistema. Habilite no aplicativo
do Dropbox ou use o app Ignição (o app Ajustes funciona também).

**Segundo plano**

Desabilite o funcionamento dos aplicativos que não deseja em segundo plano. Pode
ser feito pelo Flatseal ou pelas configurações do Gnome (Aplicativos).

## Piper

[https://github.com/Elleo/pied/](https://github.com/Elleo/pied/)

`sudo pacman -S curl speech-dispatcher espeak-ng --needed`

Caso os pacotes `speech-dispatcher` e `espeak-ng` forem instalados reinicie o
sistema.

Baixe o arquivo para a instalação do app Pied em formato flatpak usando o
comando abaixo. O aplicativo Pied não está disponível no flathub.

```
wcurl https://github.com/Elleo/pied/releases/download/v0.3.1/com.mikeasoft.pied.flatpak
```

Instale o app `flatpak install com.mikeasoft.pied.flatpak`

No Firefox, em `about:config`, defina `narrate.filter-voices` como `false` para
usar as vozes do Piped no modo de leitura. Reinicie o navegador para aplicar a
mudança.

O ícone do app estará na pasta Utilitários no grid.

## Ordem do boot

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

## Zotero

Faça o download do arquivo xpi das seguintes extensões:

- [better notes](https://github.com/windingwind/zotero-better-notes)
- [OCR](https://github.com/UB-Mannheim/zotero-ocr)

Para a extensão OCR funcionar é necessária a instalação dos pacotes poppler,
poppler-data, tesseract, tesseract-data-eng e tesseract-data-por. Esses pacotes
foram instalados pelo script n.º 3. Nas configurações da extensão no Zotero
configure a localização para o tesseract `/usr/bin/tesseract` e para o pdftoppm
`/usr/bin/pdftoppm`.

## Incus

Execute os seguintes comandos para configurar o Incus.

Configuração do profile

`incus admin init`

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

## tmpfiles

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

## sgpt

**Instalação**

Use vinculado com o Ollama (instalado pelo script nº 3).

`uv tool install "shell-gpt[litellm]"`

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

## dns

A instalação do
[systemd-resolved](https://wiki.archlinux.org/title/Systemd-resolved) e a
configuração para o NetworkManager foi feita no script nº 2.

Utilizo pelo systemd-resolved o dns da Cloudflare com o DNS over TLS habilitado
e o DNSSEC desabilitado. Desabilite o DNS over HTTPS nos navegadores web.

Verifique o funcionamento do systemd-resolved e se a configuração do dns foi
aplicada.

`resolvectl status`

Verificar se DoT está funcionando
`resolvectl query --type=TXT whoami.ds.akahelp.net`

## easyeffects

Configuração do EasyEffects para aplicar os presets para o headset
([Easyeffect-Presets](https://github.com/Digitalone1/EasyEffects-Presets)) e
para o earbuds bluetooth
([AAAAAAAaaaaa](https://github.com/servimo/AAAAAAAaaaaa)).

Inicialize o EasyEffects e nas preferências do aplicativo habilite as opções
"Enable Service Mode" e "Autostart on login".

Execute os comandos abaixo.

```
wget -P ~/.var/app/com.github.wwmm.easyeffects/data/easyeffects/output https://raw.githubusercontent.com/servimo/AAAAAAAaaaaa/refs/heads/main/AAAAAAAaaaaa.json https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/refs/heads/master/LoudnessCrystalEqualizer.json
wget -P ~/.var/app/com.github.wwmm.easyeffects/data/easyeffects/irs 'https://github.com/servimo/AAAAAAAaaaaa/raw/refs/heads/main/Accudio%20((48kHz%20Z.E.))%20Earpods%20HIFI.irs'
```

Outra opção para inserção dos arquivos no Easyeffects seria fazer o download dos
arquivos no repositório do Github dos projetos e, na aba "Saídas", clicar em
"Predefinições", "Local" e acessar a opção "Import preset file" em "New preset
name".

Selecione como dispositivo de saída de som nas configurações do GNOME o
headphone ou o earbuds. Não selecione o
[Easy Effects Skin](https://github.com/wwmm/easyeffects?tab=readme-ov-file#warning).

Para alterar o preset automaticamente ao escolher determinado dispositivo no
sistema, selecione em "Predefinições" a opção "Carregamento Automático". Vincule
a predefinição desejada a determinado dispositivo.

É possível usar o tray icon do aplicativo para alternar rapidamente entre as
predefinições do EasyEffects. Habilite a opção "Show the tray icon" em
"Preferências".

O preset
[Microphone Preset: Noise Reduction + NPR Masculine Voice](https://gist.github.com/jtrv/47542c8be6345951802eebcf9dc7da31)
pode ser usado para cancelamento de ruído e para outras melhorias no áudio ao se
usar o microfone. Essa predefinição deve ser alocada na aba "Entrada" ou no
diretório `~/.var/app/com.github.wwmm.easyeffects/data/easyeffects/input`

## firefox

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
| browser.profiles.enabled                                                                                           | true    |
| browser.theme.native-theme (para o gnome, teste o valor false, mas não precisa com o tema Gnome Adwaita GTK4 Dark) | false   |
| browser.sessionstore.interval                                                                                      | 60000   |
| browser.toolbars.bookmarks.visibility                                                                              | always  |
| dom.security.https_only_mode                                                                                       | true    |
| general.smoothScroll                                                                                               | true    |
| general.smoothScroll.msdPhysics.enabled                                                                            | true    |
| gfx.canvas.accelerated.cache-size                                                                                  | 512     |
| image.jxl.enabled                                                                                                  | true    |
| dom.webgpu.enabled                                                                                                 | true    |
| gfx.content.skia-font-cache-size                                                                                   | 20      |
| gfx.webrender.all                                                                                                  | true    |
| gfx.webrender.compositor                                                                                           | true    |
| gfx.webrender.precache-shaders                                                                                     | true    |
| gfx.x11-egl.force-disabled                                                                                         | true    |
| layout.css.prefers-color-scheme.content-override                                                                   | 0       |
| layout.css.grid-template-masonry-value.enabled                                                                     | true    |
| layout.frame_rate                                                                                                  | 60      |
| javascript.options.wasm_branch_hinting                                                                             | true    |
| media.eme.enabled                                                                                                  | true    |
| media.gmp.decoder.multithreaded                                                                                    | true    |
| media.gpu-process-decoder                                                                                          | true    |
| media.webrtc.camera.allow-pipewire                                                                                 | true    |
| mousewheel.default.delta_multiplier_x                                                                              | 70      |
| mousewheel.default.delta_multiplier_y                                                                              | 70      |
| mousewheel.default.delta_multiplier_z                                                                              | 70      |
| mousewheel.min_line_scroll_amount                                                                                  | 3       |
| network.dns.disablePrefetch                                                                                        | true    |
| network.http.max-connections                                                                                       | 1200    |
| network.http.max-persistent-connections-per-server                                                                 | 10      |
| network.prefetch-next                                                                                              | false   |
| network.trr.mode //habilito o DNS over TLS. Uso a Cloudflare como resolvedor de DNS no systemd-resolved            | 5       |
| reader.color_scheme                                                                                                | dark    |
| reader.text_alignment                                                                                              | justify |
| sidebar.revamp                                                                                                     | true    |
| sidebar.verticalTabs                                                                                               | true    |
| widget.gtk.rounded-bottom-corners.enabled                                                                          | true    |
| widget.use-xdg-desktop-portal.file-picker                                                                          | 1       |

**Firefox Nightly**

Caso opte por usar a versão de desenvolvimento do Firefox.

Acrescente no **final** do arquivo `/etc/pacman.conf`

```
[heftig]
SigLevel = Optional
Server = https://pkgbuild.com/~heftig/repo/$arch
```

Depois execute os comandos `sudo pacman -Syu` e `sudo pacman -S firefox-nightly`

Esse repositório é mantido pelo mantenedor do Arch Linux "Heftig" (Jan Alexander
Steffens).

Fontes:
[Arch Wiki](https://wiki.archlinux.org/title/Unofficial_user_repositories#heftig),
[Arch Forum](https://bbs.archlinux.org/viewtopic.php?id=117157),
[Repositório](https://pkgbuild.com/~heftig/packages/)

## igpu

**Intel Xe**

Para habilitar o driver Intel Xe no lugar do i915, faça as configurações
recomendadas na página da Wiki
[Intel graphics](https://wiki.archlinux.org/title/Intel_graphics#Testing_the_new_experimental_Xe_driver).
Lembrando que é possível essa alteração para kernels acima do 6.17 (maior
estabilidade do módulo Xe) e para iGPUs Intel Tiger Lake e gerações posteriores.

No arquivo de configuração do boot do kernel do sistema que está no diretório
`/boot/loader/entries/`, adicione as seguintes linhas abaixo. Perceba que o PCI
ID do exemplo abaixo é 46a3.

```
i915.force_probe=!46a3 xe.force_probe=46a3 xe.enable_fbc=0 xe.enable_psr=0 xe.enable_dc=0
```

Os parâmetros `xe.enable*` substituem os parâmetros `i915.enable*` configurados
pelo script nº 2.

Substitua o módulo `i915` (configurado pelo script nº 1) em
`/etc/mkinitcpio.conf` pelo módulo `xe`. Execute `sudo mkinitcpio -P` para
regenerar todos os initramfs. Reinicie o sistema.

Caso deseje verificar as opções disponíveis para o módulo Intel Xe execute
`sudo modinfo -p xe`.

Verifique se os parâmetros repassados para o kernel foram habilitados no módulo
com o comando `sudo systool -m xe -av`.

Para habilitar o `dev.xe.observation_paranoid` (equivalente ao
`dev.i915.perf_stream_paranoid` configurado pelo script nº 3), substitua o
conteúdo do arquivo `/etc/sysctl.d/99-intelparanoid.conf` por
`dev.xe.observation_paranoid = 0`. Esse parâmetro é acionado quando a CPU está
em modo **performance**. Para verificar o funcionamento, utilize os seguintes
comandos. `sysctl -n dev.xe.observation_paranoid` (tem que retornar o valor 0) e
`vulkaninfo | grep performance` (apresenta algumas extensões caso o parâmetro
esteja habilitado).

## Homebrew

Utilizo o [Homebrew](https://brew.sh/) para instalar os pacotes
([podlet](https://formulae.brew.sh/formula/podlet),
[gollama](https://formulae.brew.sh/formula/gollama) e
[fabric](https://formulae.brew.sh/formula/fabric-ai))

Para habilitar o Homebrew instale os seguintes pacotes
`sudo pacman -S base-devel procps-ng curl file git --needed`

Execute o comando abaixo.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Inclua no `~/.zshrc.local`

```
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
```

Caso tenha problemas com o ruby portable no brew, instale o pacote ruby-irb
`sudo pacman -S ruby-irb --needed`

## boot

A seguinte [mensagem](https://bbs.archlinux.org/viewtopic.php?id=287695) pode
aparecer no journalctl `journalctl -b -p err`

```
Mount point '/efi' which backs the random seed file is world accessible, which is a security hole!
Random seed file '/efi/loader/random-seed' is world accessible, which is a security hole!
```

A mensagem refere-se aos parâmetros `fmask=0022` e `dmask=0022`. Eles definem as
permissões de acesso a partição `/boot`, onde o 0022 garante que o usuário tenha
as permissões necessárias. Exemplo em `/etc/fstab`:

```
UUID=0000-0000  /boot  vfat  rw,noatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2
```

Para remover a mensagem é preciso restringir o acesso ao root.

Para fazer isso substitua o 0022 por 0077.

Exemplo:

```
UUID=0000-0000  /boot  vfat  rw,noatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro  0 2
```
