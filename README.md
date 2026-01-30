# <img align="left" alt="Arch Linux" width="42px" src="https://cdn.jsdelivr.net/npm/simple-icons@6.23.0/icons/archlinux.svg" /> archpost-installation

[<img align="left" alt="License MIT" src="https://img.shields.io/github/license/henriqueffc/archpost-installation?style=flat-square" />](https://github.com/henriqueffc/archpost-installation/blob/main/LICENSE)
<img align="left" alt="Last commit" src="https://img.shields.io/github/last-commit/henriqueffc/archpost-installation?style=flat-square" />
<br>

Eu uso os scripts desse repositório **somente após** instalar o Arch Linux
usando o script de instalação
[archinstall](https://github.com/archlinux/archinstall) fornecido pela
[ISO](https://archlinux.org/download/) oficial.

**Último teste dos scripts: 29 de janeiro de 2026** / Os scripts foram alterados
após essa data.

Os scripts foram concebidos **especificamente** para a configuração da minha
máquina. Notebook Lenovo LOQ 15IRH8, Intel Core i5-12450H, 16GB de RAM, 2 X
512GB SSD M.2, NVIDIA GeForce RTX 3050 6GB GDDR6, teclado Logitech K120, mouse
Logitech M90, joystick Multilaser Js091 e headset HyperX Cloud Stinger.

Alguns componentes do sistema descritos a seguir são selecionáveis durante a
instalação pelo archinstall. Verifique a lista e faça essa seleção. Instalo o
sistema em UEFI, com o secure boot desabilitado, com systemd-boot, sistema de
arquivos EXT4, ZRAM (algoritmo lz4), kernel stable e kernel lts, idioma pt-BR,
pipewire, wireplumber, bluetooth habilitado, repositório multilib habilitado,
Nvidia GPU com o driver Nvidia open kernel module (versão dkms), shell Zsh com
grml-zsh-config e oh-my-posh, Ptyxis terminal, AUR helper Yay, Flatpak, Podman,
Distrobox, Apparmor, firewalld, systemd-resolved, NetworkManager (default
backend), wireless-regdb (WIRELESS_REGDOM="BR"), qemu, Incus, mise, intel_pstate
scaling driver, thermald, tuned e tuned-ppd para gerenciamento de frequências da
CPU e do perfil de energia, ananicy-cpp, firmware para o áudio da Sound Open
Firmware, Helix Editor, Ollama (CUDA), GNOME (Wayland). As configurações
executadas pelos scripts deste repositório são concebidas nessa base.

Os scripts deverão ser executados após a inicialização do sistema no ambiente
gráfico.

Caso o git não esteja instalado no sistema, execute:

`sudo pacman -S git --needed`

Para usar os scripts clone o repositório e acesse a pasta:

`git clone http://github.com/henriqueffc/archpost-installation`

`cd archpost-installation`

É necessário dar permissão de execução para os arquivos .sh

`chmod +x *.sh`

Ordem de uso dos scripts:

- 1-initialconfig.sh (esse script deve ser executado com o comando sudo -
  `sudo ./1-initialconfig.sh`)
- 2-video-e-audio.sh
- 3-pacotes.sh
- 4-flatpak.sh
- 5-yay.sh
- 6-grid.sh
- 7-zsh.sh
- 8-podman-distrobox-incus.sh
- 9-helix.sh

Recomendo reinicializar o sistema após a execução de cada script.

Concluída a etapa de execução dos scripts verifique o arquivo
[config-finais.md](https://github.com/henriqueffc/archpost-installation/blob/main/config-finais.md)
para encerrar a configuração do sistema.

Histórico dos resultados de desempenho do processador usando o Arch Linux -
[Geekbench](https://browser.geekbench.com/user/430599)

#### Screenshots

![Tela 1](.github/screenshots/1.png)

![Tela 2](.github/screenshots/2.png)

![Tela 3](.github/screenshots/3.png)
