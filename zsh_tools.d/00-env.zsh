# General settings
export EDITOR='vim'
export GREP_COLORS='mt=1;36'
export PAGER='less'
export TZ='Europe/Lisbon'
export DESKTOPWINSL='/mnt/c/Users/Gonçalo Sousa/'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PASTEL_COLOR_MODE=24bit

# History (zsh has no HISTCONTROL/HISTTIMEFORMAT/HISTFILESIZE - use setopt instead)
HISTFILE="$HOME/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000
setopt EXTENDED_HISTORY      # save timestamp
setopt INC_APPEND_HISTORY    # write as you go, not only on exit
setopt SHARE_HISTORY         # share across sessions
setopt HIST_IGNORE_ALL_DUPS  # drop old duplicates
setopt HIST_IGNORE_SPACE     # ignore commands starting with a space
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY           # expand !! before running

# Directory navigation
setopt AUTO_CD                 # 'foo' == 'cd foo'
setopt AUTO_PUSHD              # cd pushes onto the stack (see 'dirs -v' / 'cd -N')
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

[[ -o interactive && -z "$TMUX" ]] && command -v fastfetch >/dev/null 2>&1 && fastfetch

# Ansible
export ANSIBLE_CONFIG="$HOME/.config/ansible/config.ini"
export ANSIBLE_INVENTORY="$HOME/.config/ansible/inventory"

# Starship window title (zsh runs precmd hooks via the precmd_functions array)
set_win_title() {
    echo -ne "\033]0;${USER}@${HOST}: ${PWD}\007"
}
precmd_functions+=(set_win_title)

# Load Homebrew
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Color Man pages
export LESS="R --use-color"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Dotfiles
DOTFILES_REPO="git@github.com:gsousa7/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Colors
MAGENTA="\e[35m"
YELLOW="\e[33m"
BLUE="\e[34m"
GREEN="\e[32m"
RESET="\e[0m"
ORANGE="\e[38;5;214m"
RED="\e[31m"
