#!/usr/bin/env bash

# This script will backup existing dot files if they exist and install the new ones

# Variables
DOTFILES_REPO="git@github.com:gsousa7/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"
LOG_FILE="$HOME/dotfiles_install.log"

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
  "telnet" "rsync" "wget" "curl" "bash-completion" "vim" "htop" "tcpdump" "jq"
  "ncdu" "ansible" "fontconfig" "fdupes" "rename" "python3" "python3-pip"
  "netcat-openbsd" "traceroute" "ssh" "btop" "atop" "ffmpeg" "git" "pipx" "tmux"
)

# Extra tools to install via pip
EXTRA_TOOLS=("spotdl" "yt-dlp" "tldr")

# Log function to capture success and failure
log_message() {
  echo "$1" | tee -a "$LOG_FILE"
}

# Function to detect package manager
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

# Function to install core packages
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
        )
        log_message "Refreshing package repositories using apt..."
        sudo apt update
		
    elif [ "$PACKAGE_MANAGER" == "dnf" ]; then
        PACKAGES+=(
            "man-db"
            "man-pages"
            "python3-docs"
            "bash-doc"
            "info"
            "man-pages-devel"
            "system-doc"
        )
    fi

    log_message "Installing packages using $PACKAGE_MANAGER..."
    sudo "$PACKAGE_MANAGER" install -y "${PACKAGES[@]}" && \
        log_message "Packages installed successfully." || \
        log_message "Failed to install packages."
}

# Function to install pip-based extra tools
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

# Function to clone the dotfiles repository
clone_dotfiles_repo() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    log_message "Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR" && log_message "Dotfiles repository cloned successfully." || log_message "Error cloning repository. Exiting."
  else
    log_message "Dotfiles repository already exists. Skipping clone."
  fi
}

# Function to create backups and symlinks for dotfiles
symlink_dotfiles() {
  log_message "Creating symlinks for dotfiles..."
  mkdir -p "$BACKUP_DIR"

  for file in "${FILES_TO_SYMLINK[@]}"; do
    dotfile=".$file"
    if [ -f "$HOME/$dotfile" ]; then
      log_message "Backing up $dotfile to $BACKUP_DIR"
      mv "$HOME/$dotfile" "$BACKUP_DIR/" && log_message "$dotfile backed up."
    fi
    ln -sf "$DOTFILES_DIR/$file" "$HOME/$dotfile" && log_message "Symlink created for $file." || log_message "Failed to create symlink for $file."
  done

  # Special handling for htop configuration
  if [ -f "$DOTFILES_DIR/htoprc" ]; then
    # For newer versions of htop, link it in ~/.config/htop
    mkdir -p "$HOME/.config/htop"
    ln -sf "$DOTFILES_DIR/htoprc" "$HOME/.config/htop/htoprc" && log_message "Symlink created for htoprc."
  fi
}

# Function to handle bash_tools include
include_bash_tools() {
  if [ -f "$DOTFILES_DIR/$BASH_TOOLS" ]; then
    log_message "Creating symlink for $BASH_TOOLS"
    ln -sf "$DOTFILES_DIR/$BASH_TOOLS" "$HOME/.$BASH_TOOLS"

    if ! grep -q "source \$HOME/.$BASH_TOOLS" "$HOME/.bashrc"; then
      log_message "Adding include for .$BASH_TOOLS in .bashrc"
      echo -e "\n# Source Bash tools\nif [ -f \"\$HOME/.$BASH_TOOLS\" ]; then\n    . \"\$HOME/.$BASH_TOOLS\"\nfi" >> "$HOME/.bashrc"
      log_message "Include for $BASH_TOOLS added to .bashrc."
    fi
  fi
}

update_gitconfig() {
  log_message "Updating Git configuration..."
  
  # Prompt for Git user name and email
  read -p "Enter your Git username (user only): " git_user
  read -p "Enter your Git email: " git_email

  # Create gitconfig
  git config --global user.name "$git_user"
  git config --global user.email "$git_email"

  log_message "Git configuration updated."
}

install_vim_plug() {
  local plug_vim_path="$HOME/.vim/autoload/plug.vim"

  if [ ! -f "$plug_vim_path" ]; then
    log_message "Installing Vim-Plug..."
    curl -fLo "$plug_vim_path" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || log_message "Failed to install Vim-Plug."
  else
    log_message "Vim-Plug is already installed."
  fi
}

install_vim_plugins() {
  if command -v vim &> /dev/null; then
    log_message "Installing Vim plugins..."
    vim +'PlugInstall --sync' +qa
  else
    log_message "Vim is not installed. Skipping plugin installation."
  fi
}

# Main script execution
log_message "Script execution started."
detect_package_manager

# Prompt the user
read -p "Do you want to (i)nstall packages and tools, dotfiles, or (u)pdate dotfiles? [iI1/uU2]: " choice
case "$choice" in
  [iI1]*)
    install_packages
    install_extra_tools
    clone_dotfiles_repo
	update_gitconfig
    symlink_dotfiles
    include_bash_tools
    install_vim_plug
    install_vim_plugins
    ;;
  [uU2]*)
    log_message "Updating dotfiles..."
    cd "$DOTFILES_DIR" && git pull || log_message "Error pulling changes."
	log_message "Reloading bash..."
	source "$HOME/.bashrc" && log_message "Bash reloaded." || log_message "Reloading bash failed. Run: source ~/.bashrc"
    ;;
  *)
    log_message "Invalid choice. Exiting."
    exit 1
    ;;
esac

log_message "Operation complete."
