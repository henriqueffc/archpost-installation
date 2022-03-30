# archpost-installation

Eu uso os scripts desse repositório após instalar o Arch Linux usando o script de instalação *archinstall* fornecido pela [ISO](https://archlinux.org/download/) oficial do Arch.

Os scripts foram concebidos **especificamente** para a configuração da minha máquina. Notebook Lenovo S145, Intel Core i7-8565U, 12GB de RAM, SSD 240GB, SSD 512GB M.2 NVMe, NVIDIA GeForce MX110. 

Ordem de uso dos scripts:

- initialconfig.sh
- 1-videoeaudio.sh
- 2-pacotes.sh
- 3-flatpakefonte.sh
- 4-yay.sh
- 5-grid.sh
- 6-zsh-ohmyzsh.sh

O script *initialconfig.sh* deve ser executado como chroot após o termino da execução do archinstall. No final da instalação é sugerido pelo script *archinstall* que se continue como chroot para que o usuário execute outras configurações desejadas para o sistema. 

Os scripts restantes deverão ser executados após o reboot da máquina e com o sistema iniciado no ambiente gráfico. É preciso clonar novamente o reposítório. Sugiro que seja clonado na pasta home do usuário.
