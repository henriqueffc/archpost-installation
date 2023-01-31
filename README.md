# <img align="left" alt="Arch Linux" width="42px" src="https://cdn.jsdelivr.net/npm/simple-icons@6.23.0/icons/archlinux.svg" /> archpost-installation

[<img align="left" alt="License MIT" src="https://img.shields.io/github/license/henriqueffc/archpost-installation?style=flat-square" />](https://github.com/henriqueffc/archpost-installation/blob/main/LICENSE)
<img align="left" alt="Last commit" src="https://img.shields.io/github/last-commit/henriqueffc/archpost-installation?style=flat-square" /> <br>

Eu uso os scripts desse repositório **somente após** instalar o Arch Linux usando o script de instalação [archinstall](https://github.com/archlinux/archinstall) fornecido pela [ISO](https://archlinux.org/download/) oficial.

**Último teste dos scripts: 07 de abril 22** / Os scripts foram alterados após essa data.

Os scripts foram concebidos **especificamente** para a configuração da minha máquina. Notebook Lenovo S145, Intel Core i7-8565U, 12GB de RAM, SSD 240GB, SSD 512GB M.2 NVMe, NVIDIA GeForce MX110.

**Eu instalo o sistema em UEFI, com systemd-boot, sistema de arquivos EXT4, ZRAM, pipewire, wireplumber, repositório multilib habilitado (Steam), Nvidia com driver proprietário (versão dkms) e GNOME 43. Uso o GNOME com Wayland. As configurações dos scripts são concebidas nessa base.**

Os scripts deverão ser executados após a inicialização do sistema no ambiente gráfico. 

Caso o git não esteja instalado no sistema, execute:

`sudo pacman -S git --needed`

Para usar os scripts clone o repositório e acesse a pasta:

`git clone http://github.com/henriqueffc/archpost-installation`<br>
`cd archpost-installation`

É necessário dar permissão de execução para os arquivos .sh 

`chmod +x *.sh`

Ordem de uso dos scripts:

- 1-initialconfig.sh (esse script deve ser executado com o comando sudo - `sudo ./initialconfig.sh`) 
- 2-video-e-audio.sh
- 3-pacotes.sh
- 4-flatpak-e-mc.sh
- 5-yay.sh
- 6-grid.sh
- 7-extensions.sh
- 8-zsh-ohmyzsh.sh
- 9-podman-distrobox.sh
- 10-theme.sh (opcional)
- 11-firefox-nightly.sh (opcional)

Recomendo reinicializar o sistema após a execução de cada script.
