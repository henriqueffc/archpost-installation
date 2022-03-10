#!/bin/bash

#Cores dos avisos

AZUL='\e[1;34m'
VERDE='\e[1;32m'
RED='\e[1;31m'
LVERDE='\e[0;92m'
FIM='\e[0m'

if ls -lha ~ | grep -oq .zshrc;

then

		echo -e "${AZUL}Arquivo .zshrc encontrado. Continuando a instalação (Oh my Zsh)${FIM}" && sleep 2;
	
else

		while :;  do
			echo -ne "${VERDE}Você quer habilitar o ZSH?${FIM} ${RED}Reiniciaremos a sessão após habilitar o ZSH.${FIM} ${VERDE}Depois que logar novamente abra o terminal e escolha a opção 0 para criar o arquivo .zshrc. Após isso execute o script novamente.${FIM} ${LVERDE}(S) sim / (N) não ${FIM}";
		read resposta
		case "$resposta" in
    		s|S|"")
        		chsh -s /bin/zsh 
        		echo -e "${AZUL}Reiniciando a sessão em 3...${FIM}" && sleep 1;
	      		echo -e "${AZUL}Reiniciando a sessão em 2...${FIM}" && sleep 1;
			echo -e "${AZUL}Reiniciando a sessão em 1...${FIM}" && sleep 1;
        		pkill -KILL -u $USER; break;;
    		n|N)
	      		echo -e "${AZUL}Fim da instalação.${FIM}";
	       		exit; break;;
		*)
	      		echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;
	esac
done

fi

if ls -lha ~ | grep -oq .zshrc.pre-oh-my-zsh;

then

		echo -e "${AZUL}Arquivo .zshrc.pre-oh-my-zsh encontrado. Continuando a instalação (plugins e Powerlevel10K)${FIM}" && sleep 2;

else
		while :;  do
			echo -ne "${VERDE}Você quer instalar o Oh my Zsh? ${RED}Após a instalação do Oh my Zsh, digite exit e execute o script novamente.${FIM} ${LVERDE}(S) sim / (N) não ${FIM}";
		read resposta
		case "$resposta" in
		s|S|"")
			echo -e "${AZUL}Instalando o Oh my Zsh${FIM}";
			echo -e "${AZUL}Começando em 3...${FIM}" && sleep 1;
			echo -e "${AZUL}Começando em 2...${FIM}" && sleep 1;
			echo -e "${AZUL}Começando em 1...${FIM}" && sleep 1;
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; 
			exit; break;;
		n|N)
	      		echo -e "${AZUL}Fim da instalação.${FIM}";
	       		exit; break;;
    		*)
	       		echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;
	esac
done

fi

if ls -lha ~ | grep -oq .p10k.zsh;

then

		echo -e "${AZUL}Arquivo .p10k.zsh encontrado. Plugins e Powerlevel10K já estão instalados. Fim da instalação.${FIM}" && sleep 2;
else

		while :;  do
			echo -ne "${VERDE}Você quer instalar os plugins e o Powerlevel10k? Será habilitado também no .zshrc os aliases criados no arquivo ~/.bash_aliases. Plugins que serão instalados: zsh-autosuggestions, zsh-syntax-highlighting, colored-man-pages, history-substring-search e zsh-completions. Será instalado também o tema de cores para Zsh Drácula.${FIM} ${LVERDE}(S) sim / (N) não ${FIM}";
		read resposta
		case "$resposta" in
			s|S|"")
    			echo -e "${AZUL}Começando em 3...${FIM}" && sleep 1;
			echo -e "${AZUL}Começando em 2...${FIM}" && sleep 1;
			echo -e "${AZUL}Começando em 1...${FIM}" && sleep 1;
			git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
			git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
			git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions;
			sed -i 's/plugins=(git)/\plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages history-substring-search)/' ~/.zshrc;
			sed -i 's|robbyrussell|powerlevel10k/powerlevel10k|' ~/.zshrc;
			sed -i "1 r./dracula.txt" ~/.zshrc;
			linenumber=$(grep -nr "source" ~/.zshrc | gawk '{print $1}' FS=":");
			linenumber=$((linenumber-1));
			sed -i "${linenumber}i fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" ~/.zshrc;
			echo 'source ~/.bash_aliases' >> ~/.zshrc;
			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
			echo -e "${AZUL}Instalação concluida. Reinicie o terminal para configurar o Powerlevel10K.${FIM}"; break;;
			n|N)
       			echo -e "${AZUL}Fim da instalção.${FIM}"; break;;
    			*)
     		 	echo -e "${RED}Opção inválida. Responda a pergunta.${FIM}";;

	esac
done

fi

exit
