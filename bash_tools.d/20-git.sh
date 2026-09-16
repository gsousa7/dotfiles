# Git Aliases and functions
alias nb='git checkout -b'
alias gall='git add -A'
alias gst='git status'
alias ga='git add'
alias gf='git fetch'
alias gb='git branch'
alias gc='git commit -m'
alias gcl='git clone'
alias gi='git init'
alias gsts='git status --short'
alias glpd='git log --graph --oneline --decorate --all -p --pretty=format:"%C(brightred)%h%Creset %C(white)<%C(green)%an - %ae%Creset%C(white)>%Creset %C(yellow)(%ad)%Creset %s %C(brightcyan)%d%Creset"'
alias gl='git log --all --graph --date=format:"%d/%m/%Y %H:%M" --pretty=format:"%C(brightred)%h%Creset -%C(brightcyan)%d%Creset %s %C(yellow)(%ad) %C(white)<%C(green)%an - %ae%Creset%C(white)>%Creset"'
alias gls='git log --graph --oneline --decorate --all'
alias glps='git log --graph --oneline --decorate --all --stat --pretty=format:"%C(brightred)%h%Creset %C(white)<%C(green)%an - %ae%Creset%C(white)>%Creset %C(yellow)(%ad)%Creset %s %C(brightcyan)%d%Creset"'
alias gstr='git log --oneline --simplify-by-decoration --graph --all'
alias gp='git push origin'
alias gu='git pull' # gu = git update
alias gs='git switch'
alias gdif="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gdiff="git diff --output-indicator-new=' ' --output-indicator-old=' ' --color-words"
alias gloa='git log --author'
alias glof='git log --follow'


# Git oneliner to add commit and push
lgit() {
    if [ -z "$1" ]; then
        echo "Error: Commit message is required."
        echo "Usage: lgit '<commit_message>' <branch_name>"
        return 1
    fi

    if [ -z "$2" ]; then
        echo "Error: Branch name is required"
        echo "Usage: lgit '<commit_message>' <branch_name>"
        return 1
    fi

    git add -A
    git commit -m "$1"
    git push -u origin "$2"
}

# Git status for multiple repositories
gdst() {
    found_repo=false
    for dir in */; do
        echo -e "\n${BLUE}=== Checking ${ORANGE}$dir${RESET}${BLUE} ===${RESET}"

        if [ -d "$dir/.git" ]; then
            found_repo=true
            output=$(cd "$dir" && git status -s)

            if [[ -z "$output" ]]; then
                echo -e "${GREEN}No changes${RESET}"
            else
                echo -e "${YELLOW}$output${RESET}"
            fi
        else
            echo -e "${MAGENTA}Not initialized${RESET}"
        fi
    done

    if ! $found_repo; then
        echo -e "${MAGENTA}No Git repositories found.${RESET}"
    fi
}

gppr() {
    local found_repo=false
    for dir in */; do
        echo -e "\n${BLUE}=== Checking ${ORANGE}$dir${RESET}${BLUE} ===${RESET}"

        if [ -d "$dir/.git" ]; then
            found_repo=true
            ( # Use a subshell to execute commands within the directory without affecting the parent script's current directory
                cd "$dir" || { echo -e "${RED}Error: Could not enter directory '$dir'. Skipping.${RESET}"; return 1; }

                # Check if 'main' branch exists locally
                if ! git show-ref --verify --quiet refs/heads/main; then
                    echo -e "${MAGENTA}No 'main' branch found locally.${RESET}"
                    return 0 # Continue to next directory
                fi

                # Check if 'origin' remote exists and if 'main' branch is tracked
                if ! git remote show origin &>/dev/null; then
                    echo -e "${MAGENTA}No 'origin' remote found.${RESET}"
                    return 0
                fi

                # Fetch the latest state of the 'main' branch from origin to ensure an accurate comparison
                # Redirect stderr to /dev/null to suppress common "branch not found" warnings if origin/main doesn't exist yet
                git fetch origin main &>/dev/null

                # Check if 'origin/main' exists after fetch
                if ! git show-ref --verify --quiet refs/remotes/origin/main; then
                    echo -e "${MAGENTA}'main' branch not found on 'origin'. Possibly needs first push.${RESET}"
                    return 0
                fi

                # Count commits local 'main' is ahead of 'origin/main'
                local ahead_count=$(git rev-list --count origin/main..main)

                # Count commits local 'main' is behind 'origin/main'
                local behind_count=$(git rev-list --count main..origin/main)

                if [ "$ahead_count" -gt 0 ]; then
                    echo -e "${YELLOW}Main branch is ${ahead_count} commit(s) ahead of remote. NOT PUSHED.${RESET}"
                elif [ "$behind_count" -gt 0 ]; then
                    echo -e "${YELLOW}Main branch is ${behind_count} commit(s) behind remote. Consider pulling.${RESET}"
                else
                    echo -e "${GREEN}Main branch is up-to-date with remote.${RESET}"
                fi
            ) # End of subshell
        else
            echo -e "${MAGENTA}Not a Git repository.${RESET}"
        fi
    done

    if ! $found_repo; then
        echo -e "${MAGENTA}No Git repositories found in subdirectories.${RESET}"
    fi
}

