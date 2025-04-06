#!/usr/bin/env bash

# This script will backup existing dot files if they exist, install prerequisites and tools, and install new dotfiles

# Variables
DOTFILES_REPO="git@github.com:gsousa7/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
TRUELINE_REPO="git@github.com:petobens/trueline.git"
TRUELINE_DIR="$HOME/trueline"
TIMESTAMP="$(date +%Y%m%d_%H%M)"
BACKUP_DIR="/tmp/dotfiles_$TIMESTAMP"
LOG_FILE="$BACKUP_DIR/dotfiles_install.log"

# Create backup and log directory
mkdir -p "$BACKUP_DIR"

# List of dotfiles to handle
FILES_TO_SYMLINK=(
  "bash_completion"
  "htoprc"
  "vimrc"
  "tmux.conf"
)

# Bash tools file to include
BASH_TOOLS="bash_tools"

# List of core packages to install
PACKAGES=(
  "telnet" "rsync" "wget" "curl" "bash-completion" "vim" "htop" "tcpdump" "jq" "ncdu" "ansible" "fontconfig" "fdupes" "rename" "python3" "python3-pip" "netcat-openbsd" "traceroute" "ssh" "btop" "atop" "ffmpeg" "git" "pipx" "tmux" "zip" "unzip" "whois" "sed" "nmap" "ncdu" "mtr" "lolcat" "apg" "cowsay" "lsof" "bc" "tree"
)

# Extra tools to install via python package manager
EXTRA_TOOLS=("spotdl" "yt-dlp" "tldr")

# Log function to capture success and failure
log_message() {
  echo "$1" | tee -a "$LOG_FILE"
}

# Detect package manager
detect_package_manager() {
  log_message "Detecting package manager..."
  if command -v dnf &> /dev/null; then
    PACKAGE_MANAGER="dnf"
  elif command -v yum &> /dev/null; then
    PACKAGE_MANAGER="yum"
  elif command -v apt-get &> /dev/null; then
    PACKAGE_MANAGER="apt"
  else
    log_message "Error: No supported package manager found (dnf/yum/apt). Exiting."
    exit 1
  fi
  log_message "Package manager detected: $PACKAGE_MANAGER"
}

# Install core packages
install_packages() {
    log_message "Installing core packages..."

    # Append documentation packages based on package manager
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
        PACKAGES+=(
            "man-db"
            "manpages"
            "manpages-dev"
            "python3-doc"
            "bash-doc"
            "info"
            "debian-reference-en"
            "fonts-powerline"
        )
        log_message "Refreshing package repositories using apt..."
        sudo apt update

    elif [[ "$PACKAGE_MANAGER" == "dnf" || "$PACKAGE_MANAGER" == "yum" ]]; then
        PACKAGES+=(
            "man-db"
            "man-pages"
            "python3-docs"
            "bash-doc"
            "info"
            "man-pages-devel"
            "system-doc"
            "powerline-fonts"
        )
    fi

    log_message "Installing packages using $PACKAGE_MANAGER..."
    sudo "$PACKAGE_MANAGER" install -y "${PACKAGES[@]}" && log_message "Packages installed successfully." || log_message "Failed to install packages."
    log_message "Configuring vim as main editor"
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
      sudo update-alternatives --set editor /usr/bin/vim.basic
    elif [[ "$PACKAGE_MANAGER" == "dnf" || "$PACKAGE_MANAGER" == "yum" ]]; then
      sudo alternatives --set editor /usr/bin/vim
    fi
}

# Install pip-based extra tools
install_extra_tools() {
  log_message "Installing extra tools via pipx..."

  # Ensure pipx is installed
  if ! command -v pipx &> /dev/null; then
    log_message "pipx not found. Installing python3-pip and pipx..."
    sudo "$PACKAGE_MANAGER" install -y python3-pip pipx || { log_message "Failed to install python3-pip and pipx. Exiting."; exit 1; }
  fi

  # Install each extra tool using pipx
  for tool in "${EXTRA_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
      log_message "Installing $tool..."
      pipx install "$tool" && log_message "$tool installed successfully." || log_message "Failed to install $tool."
    else
      log_message "$tool is already installed."
    fi
  done

  # Ensure pipx is in the PATH
  pipx ensurepath
}

# Clone the dotfiles repository
clone_dotfiles_repo() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    log_message "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR" && log_message "Dotfiles repository cloned successfully." || log_message "Error cloning repository. Exiting."
  else
    log_message "Dotfiles repository already exists. Skipping clone."
  fi
}

# Clone the trueline prompt repository
clone_trueline_repo() {
  if [ ! -d "$TRUELINE_DIR" ]; then
    log_message "Cloning trueline repository..."
    git clone "$TRUELINE_REPO" "$TRUELINE_DIR" && log_message "Trueline repository cloned successfully." || log_message "Error cloning repository. Exiting."
  else
    log_message "Trueline repository already exists. Skipping clone."
  fi
}

# Backup existing dotfiles
backup_dotfiles() {
 
  for file in "${FILES_TO_SYMLINK[@]}"; do
    local dotfile="$HOME/.$file"
    if [ -f "$dotfile" ] || [ -L "$dotfile"]; then
      mv "$dotfile" "$BACKUP_DIR" && log_message "Backed up .$file"
    else
      log_message ".$file not found, skipping"
    fi
  done

  if [ -f "$BASH_TOOLS" ] || [ -L "$BASH_TOOLS"]; then
    cp "$$BASH_TOOLS" "$BACKUP_DIR/" && log_message "Backed up .$file"
  else
    log_message ".$BASH_TOOLS not found, skipping"
  fi


  # Backup htoprc
  if [ -f "$HOME/.config/htop/htoprc" ] || [ -L "$HOME/.config/htop/htoprc" ]; then
    mkdir -p "$BACKUP_DIR/.config/htop"
    mv "$HOME/.config/htop/htoprc" "$$BACKUP_DIR/.config/htop/" && log_message "Backed up htoprc"
  fi 
}

# Symlink dotfiles from repository to home directory
symlink_dotfiles() {
  log_message "Creating symlinks from $DOTFILES_DIR to home"

  for file in "${FILES_TO_SYMLINK[@]}"; do
    ln -sf "$DOTFILES_DIR/$file" "$HOME/.$file" && log_message "Linked $file"
  done

  # Symlink htoprc
  if [ -f "$DOTFILES_DIR/htoprc" ]; then
    mkdir -p "$HOME/.config/htop"
    ln -sf "$DOTFILES_DIR/htoprc" "$HOME/.config/htop/htoprc" && log_message "Linked htoprc"
  fi
}

# Include bash_tools on .bashrc
include_bash_tools() {
  # Create symlink for bash_tools file
  if [ -f "$DOTFILES_DIR/$BASH_TOOLS" ]; then
    log_message "Creating symlink for $BASH_TOOLS"
    ln -sf "$DOTFILES_DIR/$BASH_TOOLS" "$HOME/.$BASH_TOOLS"

    # Add source line to .bashrc if not present
    if ! grep -Fxq "if [ -f \"\$HOME/.$BASH_TOOLS\" ]; then" "$HOME/.bashrc"; then
      log_message "Adding include for .$BASH_TOOLS in .bashrc"
      cat <<EOF >> "$HOME/.bashrc"

# Source Bash tools
if [ -f "\$HOME/.$BASH_TOOLS" ]; then
    . "\$HOME/.$BASH_TOOLS"
fi
EOF
      log_message "Include for $BASH_TOOLS added to .bashrc."
    fi
  else
    log_message "$DOTFILES_DIR/$BASH_TOOLS not found. Skipping symlink and sourcing."
  fi

  # Include trueline on .bashrc
  local trueline_script="$TRUELINE_DIR/trueline.sh"
  if [ -f "$trueline_script" ]; then
    if ! grep -Fxq "if [ -f \"\$HOME/trueline/trueline.sh\" ]; then" "$HOME/.bashrc"; then
      log_message "Adding source for trueline.sh in .bashrc"
      cat <<EOF >> "$HOME/.bashrc"

# Source Trueline prompt
if [ -f "\$HOME/trueline/trueline.sh" ]; then
    . "\$HOME/trueline/trueline.sh"
fi
EOF
      log_message "Source for trueline.sh added to .bashrc."
    fi
  else
    log_message "Trueline script not found at $trueline_script. Skipping."
  fi
}



# Git configuration
update_gitconfig() {
  log_message "Updating Git configuration..."

  # Prompt for Git name and trim spaces (begin and end)
  read -p "Enter your Git username (user only): " git_user
  git_user=$(echo "$git_user" | sed 's/^[ \t]*//;s/[ \t]*$//')

  # Prompt for Git mail and convert it to lowercase
  read -p "Enter your Git email: " git_email
  git_email=$(echo "$git_email" | awk '{print tolower($0)}')

  # Prompt for init branch, trim space (begin and end) and validate input
  read -p "What is your init branch? (master or main) " git_branch
  git_branch=$(echo "$git_branch" | sed 's/^[ \t]*//;s/[ \t]*$//')
    if [[ "$git_branch" != "master" && "$git_branch" != "main" ]]; then
      log_message "Invalid branch name. Please enter 'master' or 'main'."
      exit 1
    fi

  # Create gitconfig
  git config --global user.name "$git_user"
  git config --global user.email "$git_email"
  git config --global init.defaultBranch "$git_branch"
  log_message "Git configuration updated."

  # Check if SSH key is added
  if ! [ -f "$HOME/.ssh/id_rsa.pub" ] && ! [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    log_message "No SSH key found. Create SSH key with 'ssh-keygen -C \"$git_email\"' or 'ssh-keygen -t ed25519 -C \"$git_email\"' and add it to GitHub."
  fi
}


# Ensure that pre-requisites are meet and installed
install_vim_prereq() {
  # Install vim-plug
  local plug_vim_path="$HOME/.vim/autoload/plug.vim"

  if [ ! -f "$plug_vim_path" ]; then
    log_message "Installing Vim-Plug..."
    curl -fLo "$plug_vim_path" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || log_message "Failed to install Vim-Plug."
  else
    log_message "Vim-Plug is already installed."
  fi
  
  # Install Dracula theme
  local dracula_path="$HOME/.vim/pack/themes/start/dracula"
  
  if [ ! -d "$dracula_path" ]; then
    log_message "Installing Dracula theme..."
    mkdir -p "$HOME/.vim/pack/themes/start"
    git clone https://github.com/dracula/vim.git "$dracula_path" || log_message "Failed to install Dracula theme."
    log_message "Dracula theme installed successfully."
  else
    log_message "Dracula theme is already installed."
  fi
}

# Install Nerd Fonts
install_fonts() {
  log_message "Installing Nerd Fonts"

  local fonts_version="3.3.0"
  local fonts_dir="/usr/local/share/fonts"
  local fonts=(
    BitstreamVeraSansMono
    CodeNewRoman
    DroidSansMono
    FiraCode
    FiraMono
    Go-Mono
    Hack
    Hermit
    JetBrainsMono
    Meslo
    Noto
    Overpass
    ProggyClean
    RobotoMono
    SourceCodePro
    SpaceMono
    Ubuntu
    UbuntuMono
  )

 
  # Create fonts directory if it doesn't exist
  if [[ ! -d "$fonts_dir" ]]; then
    log_message "Creating font directory at $fonts_dir"
    sudo mkdir -p "$fonts_dir"
  fi

  # Download and install fonts
  for font in "${fonts[@]}"; do
    local zip_file="${font}.zip"
    local font_check
    font_check=$(find "$fonts_dir" -iname "${font//-/}*.ttf" | head -n 1)

    if [[ -z "$font_check" ]]; then
      log_message "Installing $font Nerd Font..."
      local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${fonts_version}/${zip_file}"
      wget -q "$url"
      sudo unzip -o "$zip_file" -d "$fonts_dir" >/dev/null
      rm -f "$zip_file"
    else
      log_message "$font Nerd Font already installed. Skipping."
    fi
  done

  # Rebuild font cache
  sudo fc-cache -fv

  log_message "Fonts installed."
  log_message "If running in WSL, open $fonts_dir and manually install fonts."
}

# Installs vim plugins declared in .vimrc
install_vim_plugins() {
  if command -v vim &> /dev/null; then
    log_message "Installing Vim plugins..."
    vim +'PlugInstall --sync' +qa
  else
    log_message "Vim is not installed. Skipping plugin installation."
  fi
}

# Install tmux plugins
install_tmux_plugins() {
  log_message "Installing tmux plugins..."

  local plugin_path="${HOME}/.config/tmux/plugins"
  local tpm_path="${plugin_path}/tpm"

  if [ ! -d "$tpm_path" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "${tpm_path}"
    "${tpm_path}/bin/install_plugins"
  else
    log_message "Tmux plugin manager already installed. Skipping."
  fi

  "${tpm_path}/bin/install_plugins"
}

# Main script execution
log_message "Script execution started."
detect_package_manager

# Prompt user
read -p "Do you want to (i)nstall packages and tools, dotfiles, or (u)pdate dotfiles? [iI1/uU2]: " choice
case "$choice" in
  [iI1]*)
    install_packages
    install_extra_tools
    update_gitconfig
    clone_dotfiles_repo
    clone_trueline_repo
    install_fonts
    backup_dotfiles
    symlink_dotfiles
    include_bash_tools
    install_vim_prereq
    install_vim_plugins
    install_tmux_plugins
    ;;
  [uU2]*)
    log_message "Updating dotfiles..."
    cd "$DOTFILES_DIR" && git pull || log_message "Error pulling changes."
    log_message "To apply all changes, restart your shell or run: 'source ~/.bashrc' or 'rb'"
    ;;
  *)
    log_message "Invalid choice. Exiting."
    exit 1
    ;;
esac

log_message "Operation complete."
log_message "To apply all changes, restart your shell or run: 'source ~/.bashrc' or 'rb'"
log_message "Backups saved in: $BACKUP_DIR"