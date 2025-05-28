#!/usr/bin/env zsh

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Instalação
sudo pacman --needed -Syu - <./pacotes/helix.txt

# Paths
cp $HOME/.zshrc $HOME/.zshrc.bak1
#echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.zshrc ## configurado no script n.º 8
echo 'export npm_config_prefix="$HOME/.local"' >>$HOME/.zshrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>$HOME/.zshrc
echo 'export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"' >>$HOME/.zshrc
source $HOME/.zshrc

# Arquivos de configuração
mkdir -p $HOME/.config/helix
cp ./helix/config.toml ~/.config/helix/
cp ./helix/languages.toml ~/.config/helix/
