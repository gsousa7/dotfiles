# Git Aliases and functions (same as bash_tools.d/20-git.sh, kept identical
# so muscle memory transfers between shells)
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
            (
                cd "$dir" || { echo -e "${RED}Error: Could not enter directory '$dir'. Skipping.${RESET}"; return 1; }

                if ! git show-ref --verify --quiet refs/heads/main; then
                    echo -e "${MAGENTA}No 'main' branch found locally.${RESET}"
                    return 0
                fi

                if ! git remote show origin &>/dev/null; then
                    echo -e "${MAGENTA}No 'origin' remote found.${RESET}"
                    return 0
                fi

                git fetch origin main &>/dev/null

                if ! git show-ref --verify --quiet refs/remotes/origin/main; then
                    echo -e "${MAGENTA}'main' branch not found on 'origin'. Possibly needs first push.${RESET}"
                    return 0
                fi

                local ahead_count=$(git rev-list --count origin/main..main)
                local behind_count=$(git rev-list --count main..origin/main)

                if [ "$ahead_count" -gt 0 ]; then
                    echo -e "${YELLOW}Main branch is ${ahead_count} commit(s) ahead of remote. NOT PUSHED.${RESET}"
                elif [ "$behind_count" -gt 0 ]; then
                    echo -e "${YELLOW}Main branch is ${behind_count} commit(s) behind remote. Consider pulling.${RESET}"
                else
                    echo -e "${GREEN}Main branch is up-to-date with remote.${RESET}"
                fi
            )
        else
            echo -e "${MAGENTA}Not a Git repository.${RESET}"
        fi
    done

    if ! $found_repo; then
        echo -e "${MAGENTA}No Git repositories found in subdirectories.${RESET}"
    fi
}

# ---------------------------------------------------------------------------
# Extra aliases/functions borrowed from mac-dot's Oh-My-Zsh-style git.zsh.
# Only names that DON'T collide with the aliases above were kept, so gc/gp/gl/
# gsts/gs above keep their existing (bash-matching) meaning. Documented in
# 'zfo git' (80-cheatsheet.zsh).
# ---------------------------------------------------------------------------
function current_branch() {
  git symbolic-ref --quiet HEAD 2>/dev/null | sed 's|^refs/heads/||' \
    || git rev-parse --short HEAD 2>/dev/null || return
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done
  echo master
  return 1
}

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: grename old_branch new_branch"
    return 1
  fi
  git branch -m "$1" "$2"
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

alias g='git'
alias gaa='git add --all'
alias gss='git status --short'
alias gsb='git status --short --branch'
alias 'gc!'='git commit --verbose --amend'
alias 'gcn!'='git commit --verbose --no-edit --amend'
alias gcmsg='git commit --message'
alias gca='git commit --verbose --all'
alias 'gca!'='git commit --verbose --all --amend'
alias gcam='git commit --all --message'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbnm='git branch --no-merged'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout develop'
alias gsw='git switch'
alias gswc='git switch --create'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias 'gpf!'='git push --force'
alias gpsup='git push --set-upstream origin $(current_branch)'
alias ggl='git pull origin $(current_branch)'
alias ggp='git push origin $(current_branch)'
alias gfa='git fetch --all --prune --jobs=10'
alias gfo='git fetch origin'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias glog='git log --oneline --decorate --graph'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glo='git log --oneline --decorate'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias gd='git diff'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstc='git stash clear'
alias gm='git merge'
alias gma='git merge --abort'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gclean='git clean --interactive -d'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2>/dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q -- "--wip--" && git reset HEAD~1'
