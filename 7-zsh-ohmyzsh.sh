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

    echo -e "$AZUL Zsh está habilitado. Continuando a instalação (Oh my Zsh). $FIM" && sleep 2

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

if test -f "/home/$USER/.zshrc.pre-oh-my-zsh"; then

    echo -e "$AZUL Oh my zsh já está instalado. Continuando a instalação. $FIM" && sleep 2

else
    while :; do
        echo -ne "$VERDE Você quer instalar o Oh my Zsh? $FIM $RED Após a instalação do Oh my Zsh digite exit e execute o script novamente. $FIM $LVERDE (S) sim / (N) não $FIM"
        read -r resposta
        case "$resposta" in
        s | S | "")
            echo -e "$AZUL Instalando o Oh my Zsh. $FIM"
            echo -e "$AZUL Começando em 3... $FIM" && sleep 1
            echo -e "$AZUL Começando em 2... $FIM" && sleep 1
            echo -e "$AZUL Começando em 1... $FIM" && sleep 1
            sudo pacman -Syu curl ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono ttf-jetbrains-mono-nerd --needed --noconfirm
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            exit
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

if test -f "/home/$USER/.zshrc.bak"; then

    echo -e "$AZUL Os plugins estão instalados. Fim da instalação. $FIM" && sleep 2
else

    while :; do
        echo -ne "$VERDE Você quer instalar os plugins? Será habilitado também no .zshrc os aliases criados no arquivo ~/.bash_aliases. Plugins que serão instalados: zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, colored-man-pages, command-not-found, universalarchive, thefuck, copyfile, copybuffer, dirhistory, web-search e copypath. Será instalado também o tema de cores para Zsh Drácula. $FIM $LVERDE (S) sim / (N) não $FIM"
        read -r resposta
        case "$resposta" in
        s | S | "")
            echo -e "$AZUL Começando em 3... $FIM" && sleep 1
            echo -e "$AZUL Começando em 2... $FIM" && sleep 1
            echo -e "$AZUL Começando em 1... $FIM" && sleep 1
            sudo pacman -Syu gawk thefuck git nano xsel zoxide cabextract cpio 7zip unace unzip unrar fzf ripgrep ripgrep-all wl-clipboard man-db man-pages man-pages-pt_br --needed --noconfirm
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
            cp ~/.zshrc ~/.zshrc.bak
            sed -i 's/plugins=(git)/\plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages universalarchive thefuck copyfile copybuffer dirhistory web-search copypath)/' ~/.zshrc
            sed -i '2 r./zsh/dracula.txt' ~/.zshrc
            linenumber=$(grep -nr 'source' ~/.zshrc | gawk '{print $1}' FS=":")
            linenumber=$((linenumber - 1))
            sed -i "${linenumber}i fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" ~/.zshrc
            echo 'source ~/.bash_aliases' >>~/.zshrc
            echo 'eval "$(mise activate zsh)"' >>~/.zshrc
            echo "export EDITOR='nano'" >>~/.zshrc
            cat ./zsh/extract.txt >>~/.zshrc
            cat ./zsh/command-not-found.txt >>~/.zshrc
            cat ./zsh/rga-fzf.txt >>~/.zshrc
            echo 'export GPG_TTY=$TTY' >>~/.zshrc
            echo 'eval "$(zoxide init --cmd cd zsh)"' >>~/.zshrc
            sed -i 's|# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH|export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH|g' ~/.zshrc
            echo -e "$AZUL Instalação concluída. Reinicie o terminal. $FIM"
            break
            ;;
        n | N)
            echo -e "$AZUL Fim da instalação. $FIM"
            break
            ;;
        *)
            echo -e "$RED Opção inválida. Responda a pergunta. $FIM"
            ;;

        esac
    done

fi

exit
