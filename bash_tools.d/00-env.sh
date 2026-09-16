# General settings
export EDITOR='vim'
export HISTSIZE=500000
export HISTFILESIZE=500000
export HISTTIMEFORMAT="%F %T "
export GREP_COLORS='mt=1;36'
export PAGER='less'
export TZ='Europe/Lisbon'
export DESKTOPWINSL='/mnt/c/Users/Gonçalo Sousa/'
export HISTCONTROL='ignoredups'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PASTEL_COLOR_MODE=24bit

fastfetch

# Ansible
export ANSIBLE_CONFIG="$HOME/.config/ansible/config.ini"
export ANSIBLE_INVENTORY="$HOME/.config/ansible/inventory"

# Starship window title
set_win_title() {
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
}

starship_precmd_user_func="set_win_title"

# Load Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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

