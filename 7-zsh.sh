#!/usr/bin/env bash

# Henrique Custódio
# https://github.com/henriqueffc
# AVISO: Execute o script por sua conta e risco.
# License: MIT License

# Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

# if ls -a "$HOME" | grep -oq .zshrc; then
if test -f "/home/$USER/.zshrc"; then
    echo -e "$AZUL Zsh está habilitado. Continuando a instalação. $FIM" && sleep 2
else
    while :; do
        echo -ne "$VERDE Você quer habilitar o ZSH? $FIM $RED Reiniciaremos a sessão após habilitar o ZSH. $FIM $VERDE Depois que logar novamente abra o terminal e escolha a opção 0 para criar o arquivo .zshrc. Após isso execute o script novamente. $FIM $LVERDE (S) sim / (N) não $FIM"
        read -r resposta
        case "$resposta" in
        s | S | "")
            sudo pacman -Syu zsh util-linux procps-ng --needed --noconfirm
            chsh -s /bin/zsh
            echo -e "$AZUL Reiniciando a sessão em 3... $FIM" && sleep 1
            echo -e "$AZUL Reiniciando a sessão em 2... $FIM" && sleep 1
            echo -e "$AZUL Reiniciando a sessão em 1... $FIM" && sleep 1
            pkill -KILL -u "$USER"
            break
            ;;
        n | N)
            echo -e "$AZUL Fim da instalação. $FIM"
            exit
            break
            ;;
        *)
            echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
            ;;
        esac
    done

fi

sudo pacman --needed -S - <./zsh/pacotes.txt

cp ./zsh/zshrc.local ~/.zshrc.local

if test -f "/home/$USER/.functions"; then
    echo -e "$AZUL Arquivo .functions já está no diretório home. Continuando a instalação. $FIM"
else
    cp ./aliases/functions ~/.functions
fi

mkdir -p ~/.zsh_plugins
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh_plugins/zsh-completions
if test -f "/home/$USER/.zsh_plugins/zsh-completions/zsh-completions.plugin.zsh"; then
    echo 'alias zsh_plugins="git -C $HOME/.zsh_plugins/zsh-completions pull && rm -f ~/.zcompdump; compinit"' >>~/.bash_aliases
    echo 'fpath=(~/.zsh_plugins/zsh-completions/src $fpath)' >>~/.zshrc.local
fi

# oh-my-posh é instalado pelo script nº 5
if command -v oh-my-posh >/dev/null; then
    echo 'eval "$(oh-my-posh init zsh --config /usr/share/oh-my-posh/themes/gruvbox.omp.json)"' >>~/.zshrc.local
fi

echo -e "$AZUL Instalação concluída. Reinicie o terminal e depois execute zsh_plugins para terminar a configuração do zsh-completions. $FIM"
