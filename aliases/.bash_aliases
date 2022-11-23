alias rede="sudo nethogs -p"
alias ubuntu="distrobox enter ubuntu"
alias stop-ubuntu="distrobox stop ubuntu"
alias neo="neofetch --colors 4 3 5 7 1 2"
alias atualizar="flatpak update && flatpak remove --unused && sudo pacman -Syu && yay -Sua"
alias omz="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull && omz update"
alias limpar="sudo paccache -rk1 && yay -Yc"
alias dados="yay -Ps"
alias reflector="sudo reflector -l 10 -c Brazil -a 12 -p https -p http --sort rate --save /etc/pacman.d/mirrorlist && sudo pacman -Syy"
alias xls="exa -a --icons --color=always --group-directories-first"
alias xll="exa -lag --icons --color=always --group-directories-first --octal-permissions"
alias xltree="exa -la --icons --color=always --group-directories-first --octal-permissions --header --tree"
alias bat="bat --theme=Dracula"
alias cpu-performance="sudo cpupower frequency-set --governor performance"
alias cpu-powersave="sudo cpupower frequency-set --governor powersave"
alias cpu-info="grep 'cpu MHz' /proc/cpuinfo && cpupower frequency-info && sudo x86_energy_perf_policy && cat /sys/devices/system/cpu/intel_pstate/*"
alias intel-freq="sudo i7z"
alias intel-video="sudo intel_gpu_top"
alias erro="sudo sudo dmesg -l err && systemctl --failed && journalctl -p3 -xb -5"
alias boot="systemd-analyze && systemctl list-timers"
alias fail2ban="sudo fail2ban-client status && sudo fail2ban-client status sshd"
alias report-audit="sudo aureport -n"
alias dic-pt="aspell -x --lang=pt_BR -c "
alias dic-en="aspell -x --lang=en -c "
alias ram="watch -n 1 free -h"
alias nvme="cd /mnt/nvme0n1p1/"
alias nvme2="cd /mnt/nvme0n1p5/"
alias atalhos="bat $HOME/.atalhos.txt"
alias pacman.log="bat /var/log/pacman.log"
alias search="pacman -Ss "
alias dirty="cat /proc/vmstat | egrep 'dirty|writeback'"
alias progress="progress -m"
alias install="sudo pacman -Syu "
alias remove="sudo pacman -R "
