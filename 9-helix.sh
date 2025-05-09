#!/usr/bin/env zsh

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Instalação
sudo pacman -Syu helix clang shellcheck stylua libxml2 yamlfmt yamllint pyright shfmt bash-language-server vscode-css-languageserver lua-language-server typescript-language-server marksman deno python-black vscode-html-languageserver go gopls go-tools taplo-cli rust python pyenv python-pipenv uv python-pip python-pipx npm nodejs aria2 bash-completion gdu lazygit fzf ripgrep ripgrep-all git base-devel unzip curl wget fd gawk eza procs sd openssh trash-cli bat bat-extras strace man-pages man-pages-pt_br wl-clipboard silicon xsel ttf-jetbrains-mono-nerd vscode-json-languageserver rust-analyzer ansible-language-server ansible-lint --needed

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
