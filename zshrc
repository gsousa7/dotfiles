# =========================================================
# zshrc — loader, symlinked to ~/.zshrc by install.sh.
# Parallel to bash_tools/.bashrc: same aliases/functions where possible
# (see zsh_tools.d/), plus zsh-specific niceties borrowed from mac-dot
# (completion, autosuggestions, syntax highlighting, history search).
# =========================================================

# ---- Completion ----
_compdump="$HOME/.cache/zsh/zcompdump"
mkdir -p "${_compdump:h}"

# Homebrew's own completions need to be on fpath before compinit runs
[[ -d /home/linuxbrew/.linuxbrew/share/zsh/site-functions ]] && fpath=(/home/linuxbrew/.linuxbrew/share/zsh/site-functions $fpath)
[[ -d /usr/local/share/zsh/site-functions ]] && fpath=(/usr/local/share/zsh/site-functions $fpath)

autoload -Uz compinit

# Use the cache as-is if younger than a day, otherwise rebuild it
if [[ -s "$_compdump" ]] && (( $(date +%s) - $(stat -c '%Y' "$_compdump" 2>/dev/null || echo 0) < 86400 )); then
  compinit -C -d "$_compdump"
else
  compinit -d "$_compdump"
fi
unset _compdump

autoload -Uz +X bashcompinit && bashcompinit   # for bash-style completions (gcloud, ...)

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''

# ---- Plugin manager (no framework - clones plugins to $ZPLUGINDIR on first run) ----
ZPLUGINDIR="$HOME/.local/share/zsh/plugins"

_zplugin_load() {
  # $1 = owner, $2 = repo (== plugin name)
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# syntax-highlighting must be loaded last (it wraps ZLE)
_zplugin_load zsh-users         zsh-autosuggestions
_zplugin_load zsh-users         zsh-history-substring-search
_zplugin_load zdharma-continuum fast-syntax-highlighting

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ---- Modules (order matters) ----
#   env         -> exports, colors, history/nav options, Homebrew
#   aliases     -> eza/navigation aliases
#   git/kubernetes -> aliases + helper functions
#   functions   -> generic utilities (field, tempo, explain, ...)
#   media       -> yt-dlp/spotdl
#   customization -> starship palette, eza theme, ffblur
#   cheatsheet  -> vimfo/tmuxfo/vscfo/zfo
#   help        -> show_*_commands / lscom
_dotfiles_zsh_dir="$(dirname "$(readlink -f "${(%):-%x}")")/zsh_tools.d"
for _dotfiles_zsh_file in "$_dotfiles_zsh_dir"/*.zsh; do
  . "$_dotfiles_zsh_file"
done
unset _dotfiles_zsh_dir _dotfiles_zsh_file

# ---- Prompt (Starship, shared config with bash - starship_full.toml) ----
export VIRTUAL_ENV_DISABLE_PROMPT=1
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
