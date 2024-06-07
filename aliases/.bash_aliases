alias mpvnovideo="mpv --vid=no --save-position-on-quit"
alias yaycache="yay -Sc --aur"
alias rede="sudo nethogs -p"
alias rede2="sudo bandwhich"
alias neo="fastfetch"
alias atualizar="pipx upgrade-all && flatpak update && flatpak remove --unused && archnews && sudo pacman -Syu && yay -Sua --devel"
alias omzsh="echo -e '\e[0;34mzsh-syntax-highlighting\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull && echo -e '\e[0;34mzsh-autosuggestions\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull && echo -e '\e[0;34mzsh-completions\e[0m' && git -C $HOME/.oh-my-zsh/custom/plugins/zsh-completions pull && omz update"
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
alias cpu-performance="sudo cpupower frequency-set --governor performance && sudo x86_energy_perf_policy -a performance --hwp-min 20 --hwp-max 46"
alias cpu-powersave="sudo cpupower frequency-set --governor powersave && sudo x86_energy_perf_policy -a balance-performance --hwp-min 20 --hwp-max 46"
alias cpu-info="grep 'cpu MHz' /proc/cpuinfo && cpupower frequency-info && sudo x86_energy_perf_policy && cat /sys/devices/system/cpu/intel_pstate/*"
alias intel-freq="sudo i7z"
alias intel-video="sudo intel_gpu_top"
alias boot="systemd-analyze && systemctl list-timers"
alias fail2ban="sudo fail2ban-client status && sudo fail2ban-client status sshd"
alias report-audit="sudo aureport -n"
alias dic-pt="aspell -x --lang=pt_BR -c"
alias dic-en="aspell -x --lang=en -c"
alias ram="watch -n 1 free -h"
alias atalhos="glow -p $HOME/.atalhos.md"
alias pacman.log="tspin /var/log/pacman.log"
alias dirty="cat /proc/vmstat | egrep 'dirty|writeback'"
alias progress="progress -m"
alias instalar="archnews && sudo pacman -Syu"
alias remover="sudo pacman -R"
alias mirror="rankmirrors -t /etc/pacman.d/mirrorlist"
alias turbo="sudo turbostat --quiet --interval 1 --cpu 0-7 --show 'PkgWatt','Busy%','Core','CoreTmp'"
alias firefoxbox="podman run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=passwd docker.io/kasmweb/firefox:1.15.0"
alias torbrowserbox="podman run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=passwd docker.io/kasmweb/tor-browser:1.15.0"
alias hist="history | fzf"
alias nvidia="watch -n 0.5 nvidia-smi"
function flatrun() {
    flatpak run "$(flatpak list --columns=application | grep -F -i "$1")" "${@:2}"
}
