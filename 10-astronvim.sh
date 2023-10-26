#!/usr/bin/env zsh 

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Paths
cp $HOME/.zshrc $HOME/.zshrc.bak1
#echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.zshrc ## configurado no script nº 8
echo 'export npm_config_prefix="$HOME/.local"' >>$HOME/.zshrc
source $HOME/.zshrc

sudo pacman -S neovim tree-sitter-cli bottom gdu lazygit ripgrep ripgrep-all git base-devel unzip curl wget fd python python-pipenv python-pip npm nodejs wl-clipboard silicon xsel ttf-jetbrains-mono-nerd --needed

mv ~/.config/nvim ~/.config/nvim.bak 2> /dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2> /dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2> /dev/null

git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

git clone https://github.com/henriqueffc/astronvim_config.git ~/.config/nvim/lua/user
