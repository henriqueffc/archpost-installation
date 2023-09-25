alias tmux.lvim="tmux new -s lvim -d"
alias mpvnovideo="mpv --vid=no --save-position-on-quit"
alias yaycache="yay -Sc --aur"
alias rede="sudo nethogs -p"
alias rede2="sudo bandwhich"
alias neo="neofetch"
alias atualizar="flatpak update && flatpak remove --unused && archnews && sudo pacman -Syu && yay -Sua --devel"
alias omz="echo -e '\e[0;34mzsh-syntax-highlighting\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull && echo -e '\e[0;34mzsh-autosuggestions\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull && echo -e '\e[0;34mzsh-completions\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-completions pull && echo -e '\e[0;34mpowerlevel10k\e[0m' && git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull && omz update"
alias limpar="find ~/.cache/ -type f -atime +365 -delete && sudo paccache -rk1 && yay -Yc"
alias scanports="rustscan -a 127.0.0.1 --ulimit 5000"
alias dados="yay -Ps"
alias reflector="sudo reflector --score 5 --country 'United States,Germany,Brazil' -a 1 -p https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist"
alias size="du -ch --max-depth=1 . | sort -h"
alias xls="eza -a --icons --color=always --group-directories-first"
alias xll="eza -lag --icons --color=always --header --group-directories-first --octal-permissions"
alias xla="eza -las age --icons --color=always --group-directories-first"
alias xltree="eza -la --icons --color=always --group-directories-first --octal-permissions --header --tree"
alias bat="bat --theme=Dracula"
alias cpu-performance="sudo cpupower frequency-set --governor performance && sudo x86_energy_perf_policy -a performance"
alias cpu-powersave="sudo cpupower frequency-set --governor powersave && sudo x86_energy_perf_policy -a balance-performance && sudo cpupower frequency-set --min 1800MHz"
alias cpu-info="grep 'cpu MHz' /proc/cpuinfo && cpupower frequency-info && sudo x86_energy_perf_policy && cat /sys/devices/system/cpu/intel_pstate/*"
alias intel-freq="sudo i7z"
alias intel-video="sudo intel_gpu_top"
alias boot="systemd-analyze && systemctl list-timers"
alias fail2ban="sudo fail2ban-client status && sudo fail2ban-client status sshd"
alias report-audit="sudo aureport -n"
alias dic-pt="aspell -x --lang=pt_BR -c"
alias dic-en="aspell -x --lang=en -c"
alias ram="watch -n 1 free -h"
alias nvme="cd /mnt/nvme0n1p1/"
alias nvme2="cd /mnt/nvme0n1p5/"
alias atalhos="bat $HOME/.atalhos.txt"
alias pacman.log="tail -n 120 /var/log/pacman.log"
alias search="pacman -Ss"
alias dirty="cat /proc/vmstat | egrep 'dirty|writeback'"
alias progress="progress -m"
alias instalar="archnews && sudo pacman -Syu"
alias remover="sudo pacman -R"
alias mirror="rankmirrors -t /etc/pacman.d/mirrorlist"
