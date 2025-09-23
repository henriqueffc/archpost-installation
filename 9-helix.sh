#!/usr/bin/env zsh

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos
AZUL='\e[1;34m'
FIM='\e[0m'

# Instalação
sudo pacman --needed -Syu - <./pacotes/helix.txt

# Paths
# configurados pelo script nº 7
#cp $HOME/.zshrc.local $HOME/.zshrc.local.bak1
#echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.zshrc.local
#echo 'export npm_config_prefix="$HOME/.local"' >>$HOME/.zshrc.local
#echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>$HOME/.zshrc.local
#echo 'export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"' >>$HOME/.zshrc.local
#source $HOME/.zshrc.local

# Systemd-lsp
# https://github.com/JFryy/systemd-lsp
wget -O ~/.cargo/bin/systemd-lsp -c "https://github.com/JFryy/systemd-lsp/releases/download/v2025.07.14/systemd-lsp-x86_64-unknown-linux-gnu"
chmod +x ~/.cargo/bin/systemd-lsp

# Arquivos de configuração
mkdir -p $HOME/.config/helix
cp ./helix/config.toml ~/.config/helix/
cp ./helix/languages.toml ~/.config/helix/

# mise
mkdir -p $HOME/.config/mise/
cp ./mise/config.toml $HOME/.config/mise/
if test -f "/home/$USER/.zshrc.local"; then
    echo 'eval "$(mise activate zsh)"' >>~/.zshrc.local
else
    echo -e "$AZUL zsh e grml-zsh-config não estão instalados. Verifique a instalação do mise.$FIM"
fi
