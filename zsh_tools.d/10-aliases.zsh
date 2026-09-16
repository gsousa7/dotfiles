# eza alias
alias l='eza --icons --sort=name --group-directories-first --color=auto'
alias ls='eza -a --icons --git --sort=name --group-directories-first --color=auto'
alias ll='eza -lah --icons --git --sort=name --group-directories-first --color=auto'
alias lls='eza -lah --icons --git --sort=size --group-directories-first --color=auto'
alias ld='eza --only-dirs --git --icons --sort=name --color=auto'
alias lf='eza --only-files --git --icons --sort=name --color=auto'
alias lda='eza -lah --only-dirs --git --icons --color=auto'
alias lfa='eza -lah --only-files --git --icons --color=auto'
alias tree='eza -aT --icons --color=auto --sort=name --group-directories-first'
alias ltree='eza -lahT --icons --color=auto --sort=name --group-directories-first --git'
alias l.='eza -lh --icons ../'
alias l..='eza -lh --icons ../../'
alias l...='eza -lh --icons ../../../'
alias lt="eza -lTg --color=auto --icons --sort=Name --group-directories-first --git"
alias lt2="eza -lTg --level=2 --color=auto --icons --sort=Name --group-directories-first --git"
alias lt3="eza -lTg --level=3 --color=auto --icons --sort=Name --group-directories-first --git"
alias lt4="eza -lTg --level=4 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta="eza -lTag --color=auto --icons --sort=Name --group-directories-first --git"
alias lta2="eza -lTag --level=2 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta3="eza -lTag --level=3 --color=auto --icons --sort=Name --group-directories-first --git"
alias lta4="eza -lTag --level=4 --color=auto --icons --sort=Name --group-directories-first --git"
compdef eza=ls   # reuse ls's completion for eza


# Navigation & utility aliases
alias aqui='explorer.exe .'
alias fmedia='find . -type f \( -name "*.mp4" -o -name "*.mkv" \)'
alias cdd='cd "${DESKTOPWINSL}Desktop"'
alias data='echo $(date "+%d/%m/%Y %H:%M:%S")'
alias tempolx='curl wttr.in/Lisboa\?format=4'
alias temposx='curl wttr.in/Seixal\?format=4'
alias tempolxf='curl wttr.in/Lisboa'
alias temposxf='curl wttr.in/Seixal'
alias dus='du -sh * 2>/dev/null'
alias net='ip -br -c a'
alias ippub='curl -s https://ipinfo.io/ip && echo'
alias ippubf='curl -s https://ipinfo.io && echo'
alias rz='exec zsh'                             # reload the shell (clean restart)
alias ez="vim $HOME/dotfiles/zshrc"
alias ezt="vim $HOME/dotfiles/zsh_tools.d"
alias eb="vim $HOME/.bashrc"
alias ebt="vim $HOME/dotfiles/bash_tools.d"
alias evrc="vim $HOME/.vimrc"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias wdir='cd $HOME/work'
alias gdir='cd $HOME/git'
alias ldir='cd $HOME/lab'
alias ddir='cd $HOME/dotfiles'
alias cvdir="cd $HOME/git/gsousa7.github.io"
alias cvinit="bundle exec jekyll serve"
alias svim='sudoedit'
alias v='vim'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias rg="rg --hidden --smart-case --glob='!.git/' --no-search-zip --trim --colors=line:style:bold --colors=path:fg:magenta --colors=match:style:nobold"
alias rga="rg --hidden --no-ignore --binary --force-text --smart-case --trim"
alias etx="vim $HOME/.config/tmux/tmux.conf"
alias es="vim $HOME/.config/starship.toml"
alias eai="vim $HOME/.config/ansible/inventory"
alias bats="batcat -pn --no-paging"
alias cat="batcat -p --no-paging --color=always"
alias s5m="sleep 300"
alias s10m="sleep 600"
