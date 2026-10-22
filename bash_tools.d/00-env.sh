# General settings
export EDITOR='vim'
export HISTSIZE=500000
export HISTFILESIZE=500000
export HISTTIMEFORMAT="%F %T "
export GREP_COLORS='mt=1;36'
export PAGER='less'
export TZ='Europe/Lisbon'
export DESKTOPWINSL='/mnt/c/Users/Gonçalo Sousa/'
export OBSIDIAN_VAULT="${DESKTOPWINSL}Obsidian/vault"   # vault Obsidian (git corre do WSL; ficheiros no Windows p/ o watcher funcionar)
export HISTCONTROL='ignoredups'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PASTEL_COLOR_MODE=24bit

# Globbing closer to zsh's
shopt -s globstar   # ** matches recursively
shopt -s extglob    # !(pattern), @(pattern), etc.
shopt -s nocaseglob  # case-insensitive globs

fastfetch

# Keep $HOME tidy: relocate dotdirs to XDG locations
# (git reads ~/.config/git/{config,ignore} natively, nothing to set)
export W3M_DIR="$HOME/.config/w3m"
export BUNDLE_USER_HOME="$HOME/.config/bundle"
export BUNDLE_USER_CACHE="$HOME/.cache/bundle"
alias wget='wget --hsts-file="$HOME/.cache/wget-hsts"'
export AWS_CONFIG_FILE="$HOME/.config/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$HOME/.config/aws/credentials"
export ANSIBLE_HOME="$HOME/.local/share/ansible"
export npm_config_cache="$HOME/.cache/npm"
export DOTNET_CLI_HOME="$HOME/.local/share/dotnet"
export GNUPGHOME="$HOME/.local/share/gnupg"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export NVM_DIR="$HOME/.local/share/nvm"
export CHECKPOINT_DISABLE=1   # terraform: stops it recreating ~/.terraform.d for update checks

# Ansible
export ANSIBLE_CONFIG="$HOME/.config/ansible/ansible.cfg"
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


# Colors
MAGENTA="\e[35m"
YELLOW="\e[33m"
BLUE="\e[34m"
GREEN="\e[32m"
RESET="\e[0m"
ORANGE="\e[38;5;214m"
RED="\e[31m"

