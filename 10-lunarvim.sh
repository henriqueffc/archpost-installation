#!/usr/bin/env zsh 

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

# Paths
cp $HOME/.zshrc $HOME/.zshrc.bak1
#echo 'export PATH="$HOME/.local/bin:$PATH"' >>$HOME/.zshrc ## configurado no script nº 8
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>$HOME/.zshrc
echo 'export npm_config_prefix="$HOME/.local"' >>$HOME/.zshrc
source $HOME/.zshrc

while :; do
       echo -ne "$VERDE Qual versão do Lunarvim será instalada? $FIM $LVERDE (S) Stable ou (N) Nightly $FIM"
       read -r resposta
       case "$resposta" in
       s | S | "")
              sudo pacman -S git neovim base-devel unzip curl wget fd ripgrep ripgrep-all make python python-pipenv python-pipx npm nodejs rust lazygit silicon wl-clipboard xsel ttf-jetbrains-mono-nerd --needed
              LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
              echo -e "$VERDE Fim da instalação. $FIM"
              break
              ;;
       n | N)
              sudo pacman -S git base-devel unzip curl wget fd ripgrep ripgrep-all make python python-pipenv python-pipx npm nodejs rust lazygit silicon wl-clipboard xsel ttf-jetbrains-mono-nerd --needed
              yay neovim-nightly-bin
              bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
              echo -e "$VERDE Fim da instalação. $FIM"
              break
              ;;
       *)
              echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
              ;;
       esac
done

# config.lua
mv ./lunarvim/config.lua $HOME/.config/lvim 
