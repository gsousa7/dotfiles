#lazygit usage:
## lazygit "Commit msg"
#function lazygit() {
#  git add -A
#  git commit -m "$1"
#  git push -u origin master
#}



# explain.sh begins
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

alias ll='ls -la'
alias aqui='explorer.exe .'
alias fmedia='find . -type f \( -name "*.mp4" -o -name "*.mkv" \) -exec mv {} . \;'
alias cdd='cd "/mnt/c/Users/Gonçalo Sousa/Desktop"'
alias data='echo $(date "+%d/%m/%Y %H:%M:%S")'
alias tempolx='curl wttr.in/Lisboa\?format=4'
alias temposx='curl wttr.in/Seixal\?format=4'
alias tempolxf='curl wttr.in/Lisboa'
alias temposxf='curl wttr.in/Seixal'
alias code='/mnt/c/Users/Gonçalo\ Sousa\ AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe'


field() {
    awk -F "${2:- }" "{ print \$${1:-1} }"
}

export EDITOR='vim'
export GREP_COLOR='1;36'~
export PAGER='less'
export TZ='Europe/Lisbon'

#Color Man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Git Aliases
alias nb='git checkout -b'
alias gall='git add -A'
alias ga='git add'
alias gf='git fetch'
alias gb='git branch'
alias gc='git commit -m'
alias gcl='git clone'
alias gi='git init'
alias gl='git log'
alias gls='git log --graph --oneline --decorate --all'
alias glpd='git log --graph --oneline --decorate --all -p --pretty=format:"%C(auto)%h %C(cyan)%an <%ae> %C(yellow)%ad %C(reset)%s %C(auto)%d %C(reset)"'
alias glps='git log --graph --oneline --decorate --all --stat --pretty=format:"%C(auto)%h %C(cyan)%an <%ae> %C(yellow)%ad %C(reset)%s %C(auto)%d %C(reset)"'
alias glp='git log --graph --oneline --decorate --all --pretty=format:"%C(auto)%h %C(cyan)%an <%ae> %C(yellow)%ad %C(reset)%s %C(auto)%d %C(reset)" --date=format:"%d/%m/%Y %H:%M:%S"'
alias gp='git push origin'
alias gs='git status'
alias gu='git pull' # gu = git update
alias gs='git switch'

# Prompt
# Store `tput` colors for future use to reduce fork+exec
# the array will be 0-255 for colors, 256 will be sgr0
# and 257 will be bold

# Store `tput` colors for future use to reduce fork+exec
COLOR256=()
COLOR256[0]=$(tput setaf 1)       # Red for errors
COLOR256[256]=$(tput sgr0)        # Reset
COLOR256[257]=$(tput bold)        # Bold text
COLOR256[500]=$(tput setaf 83)    # Custom color for #50FA7B (approximate)

# Colors for use in PS1 that may or may not change when set_prompt_colors is run
PROMPT_COLORS=()

# Change the prompt colors to a theme, themes are 0-29
set_prompt_colors() {
    local h=${1:-0}
    local color=
    local i=0
    local j=0
    for i in {22..231}; do
        ((i % 30 == h)) || continue

        color=${COLOR256[$i]}
        # cache the tput colors
        if [[ -z $color ]]; then
            COLOR256[$i]=$(tput setaf "$i")
            color=${COLOR256[$i]}
        fi
        PROMPT_COLORS[$j]=$color
        ((j++))
    done
}

# Construct the prompt
PS1='$(ret=$?;(($ret!=0)) && echo "\[${COLOR256[0]}\]($ret) \[${COLOR256[256]}\]")'

# username
PS1+='\[${COLOR256[500]}\]\u\[${COLOR256[256]}\] - '

# hostname
PS1+='\[${COLOR256[500]}\]\h '

# cwd
PS1+='\[${PROMPT_COLORS[5]}\]\w '

# optional git branch
PS1+='$(branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); [[ -n $branch ]] && echo "\[${PROMPT_COLORS[2]}\](\[${PROMPT_COLORS[3]}\]git:$branch\[${PROMPT_COLORS[2]}\]) ")'

# prompt character
PS1+='\[${PROMPT_COLORS[0]}\]\$\[${COLOR256[256]}\] '

# set the theme
set_prompt_colors 24

# Prompt command
_prompt_command() {
    local user=$USER
    local host=${HOSTNAME%%.*}
    local pwd=${PWD/#$HOME/\~}
    local ssh=
    [[ -n $SSH_CLIENT ]] && ssh='[ssh] '
    printf "\033]0;%s%s@%s:%s\007" "$ssh" "$user" "$host" "$pwd"
}
PROMPT_COMMAND=_prompt_command

PROMPT_DIRTRIM=6

# Print all 256 colors
colors() {
    local i
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolor %d\n" "$i"
    done
    tput sgr0
}



# Copy stdin to the clipboard
#copy() {
#	pbcopy 2>/dev/null ||
#	    xsel 2>/dev/null ||
#	    clip.exe
#}

# Convert epoch to human readable (print current date if no args)
epoch() {
	local num=${1:--1}
	printf '%(%B %d, %Y %-I:%M:%S %p %Z)T\n' "$num"
}


# load completion
. /etc/bash/bash_completion 2>/dev/null ||
	. ~/.bash_completion 2>/dev/null


true
