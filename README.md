# <img align="left" alt="Arch Linux" width="42px" src="https://cdn.jsdelivr.net/npm/simple-icons@6.23.0/icons/archlinux.svg" /> archpost-installation

[<img align="left" alt="License MIT" src="https://img.shields.io/github/license/henriqueffc/archpost-installation?style=flat-square" />](https://github.com/henriqueffc/archpost-installation/blob/main/LICENSE)
<img align="left" alt="Last commit" src="https://img.shields.io/github/last-commit/henriqueffc/archpost-installation?style=flat-square" /> <br>

Eu uso os scripts desse repositório **somente após** instalar o Arch Linux usando o script de instalação [*archinstall*](https://github.com/archlinux/archinstall) fornecido pela [ISO](https://archlinux.org/download/) oficial.

**Último teste dos scripts: 07 de abril 22**

Os scripts foram concebidos **especificamente** para a configuração da minha máquina. Notebook Lenovo S145, Intel Core i7-8565U, 12GB de RAM, SSD 240GB, SSD 512GB M.2 NVMe, NVIDIA GeForce MX110.

**Eu instalo o sistema em UEFI, com systemd-boot, ZRAM, pipewire, wireplumber e GNOME 42. As configurações dos scripts são concebidas nessa base.**

Os scripts deverão ser executados após a inicialização do sistema no ambiente gráfico. 

Caso o git não esteja instalado no sistema, execute:

`sudo pacman -S git --needed`

Para usar os scripts clone o repositório e acesse a pasta:

`git clone https://github.com/henriqueffc/archpost-installation.git`
`cd archpost-installation`

É necessário dar permissão de execução para os arquivos .sh 

`chmod +x *.sh`

Ordem de uso dos scripts:

- initialconfig.sh (esse script deve ser executado com o comando sudo - `sudo ./initialconfig.sh`) 
- 1-videoeaudio.sh
- 2-pacotes.sh
- 3-flatpakefonte.sh
- 4-yay.sh
- 5-grid.sh
- 6-zsh-ohmyzsh.sh

Recomendo reinicializar o sistema após a execução de cada script.

