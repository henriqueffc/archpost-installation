# archpost-installation

<p align="left">
    <a href="https://opensource.org/licenses/MIT">
      <img src="https://img.shields.io/github/license/henriqueffc/archpost-installation?style=flat-square" alt="License MIT">
    </a>
  </p>

Eu uso os scripts desse repositório **após** instalar o Arch Linux usando o script de instalação [*archinstall*](https://github.com/archlinux/archinstall) fornecido pela [ISO](https://archlinux.org/download/) oficial.

**Último teste dos scripts: 07 de abril 22**

Os scripts foram concebidos **especificamente** para a configuração da minha máquina. Notebook Lenovo S145, Intel Core i7-8565U, 12GB de RAM, SSD 240GB, SSD 512GB M.2 NVMe, NVIDIA GeForce MX110.

**Eu instalo o sistema em UEFI, com systemd-boot, ZRAM, pipewire, wireplumber e GNOME 42. As configurações dos scripts são concebidas nessa base.**

Ordem de uso dos scripts:

- initialconfig.sh
- 1-videoeaudio.sh
- 2-pacotes.sh
- 3-flatpakefonte.sh
- 4-yay.sh
- 5-grid.sh
- 6-zsh-ohmyzsh.sh

O script *initialconfig.sh* deve ser executado ainda como chroot após o termino da execução do archinstall. No final da instalação é sugerido pelo script *archinstall* que se continue como chroot para que o usuário execute outras configurações desejadas para o sistema.

Os scripts restantes deverão ser executados após o reboot da máquina e com o sistema iniciado no ambiente gráfico.

É preciso clonar novamente o repositório, pois a pasta criada durante o chroot foi clonada na pasta raiz do sistema. Sugiro que a nova clonagem do repositório seja feita na pasta home do usuário. A pasta criada anteriormente na raiz do sistema será removida automaticamente pelo script 1-videoeaudio.sh.
