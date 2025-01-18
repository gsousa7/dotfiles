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
  "gitconfig"
  "htoprc"
  "vimrc"
)

# Bash tools file to include
BASH_TOOLS="bash_tools"

# List of packages to install
PACKAGES=(
  "telnet" "rsync" "wget" "curl" "bash-completion" "vim" "htop" "tcpdump" "jq"
  "ncdu" "ansible" "fontconfig" "fdupes" "rename" "python3" "python3-pip"
  "nc" "netcat" "traceroute" "ssh" "btop" "atop" "ffmpeg" "git"
)

# Extra tools to install
EXTRA_TOOLS=("spotdl" "yt-dlp")

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

# Function to install pip if it's not installed
install_pip() {
  if ! command -v pip &> /dev/null; then
    log_message "pip not found, attempting to install pip..."
    if [ "$PACKAGE_MANAGER" == "apt" ]; then
      sudo apt install -y python3-pip && log_message "pip installed successfully."
    elif [ "$PACKAGE_MANAGER" == "dnf" ]; then
      sudo dnf install -y python3-pip && log_message "pip installed successfully."
    else
      log_message "Error: Unable to install pip. Exiting."
      exit 1
    fi
  else
    log_message "pip is already installed."
  fi
}

# Function to install core packages and extra tools
install_packages_and_tools() {
  log_message "Installing core packages and extra tools..."
  
  if [ "$PACKAGE_MANAGER" == "apt" ]; then
    log_message "Refreshing package repositories using apt..."
    sudo apt update
  fi

  log_message "Installing packages using $PACKAGE_MANAGER..."
  case "$PACKAGE_MANAGER" in
    "apt"|"dnf"|"yum")
      sudo "$PACKAGE_MANAGER" install -y "${PACKAGES[@]}" && log_message "Packages installed successfully."
      ;;
    *)
      log_message "Unsupported package manager. Exiting."
      exit 1
      ;;
  esac

  log_message "Installing extra tools..."
  for tool in "${EXTRA_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
      log_message "Installing $tool..."
      pip install "$tool" && log_message "$tool installed successfully." || log_message "Failed to install $tool."
    else
      log_message "$tool is already installed."
    fi
  done
}

# Function to clone the dotfiles repository if not already cloned
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
    dotfile=".$file"  # Add leading dot for the home directory
    if [ -f "$HOME/$dotfile" ]; then
      log_message "Backing up $dotfile to $BACKUP_DIR"
      mv "$HOME/$dotfile" "$BACKUP_DIR/" && log_message "$dotfile backed up."
    fi
    ln -sf "$DOTFILES_DIR/$file" "$HOME/$dotfile" && log_message "Symlink created for $file." || log_message "Failed to create symlink for $file."
  done
}

# Function to handle bash_tools include
include_bash_tools() {
  if [ -f "$DOTFILES_DIR/$BASH_TOOLS" ]; then
    log_message "Creating symlink for $BASH_TOOLS"
    ln -sf "$DOTFILES_DIR/$BASH_TOOLS" "$HOME/.$BASH_TOOLS"

    if ! grep -q "source \$HOME/.$BASH_TOOLS" "$HOME/.bashrc"; then
      log_message "Adding include for .$BASH_TOOLS in .bashrc"
      echo -e "\n# Source Bash tools\nif [ -f \"\$HOME/.$BASH_TOOLS\" ]; then\n    . \"\$HOME/.$BASH_TOOLS\"\nfi" >> "$HOME/.bashrc" && log_message "Include for $BASH_TOOLS added to .bashrc."
    fi
  fi
}

# Function to pull the latest changes from the dotfiles repository
pull_dotfiles_changes() {
  log_message "Pulling the latest changes from GitHub..."
  cd "$DOTFILES_DIR" || { log_message "Error accessing dotfiles directory. Exiting."; exit 1; }
  git pull && log_message "Dotfiles updated successfully." || log_message "Error pulling changes. Exiting."
}

# Main script execution
log_message "Script execution started."
detect_package_manager
install_pip

# Prompt the user to choose between packages, dotfiles, or all
read -p "Do you want to (i)nstall packages and tools, dotfiles, or (u)pdate dotfiles? [iI1/uU2]: " choice
case "$choice" in
  [iI1]*)
    log_message "Installing packages, tools, and dotfiles..."
    install_packages_and_tools
    clone_dotfiles_repo
    symlink_dotfiles
    include_bash_tools
    ;;
  [uU2]*)
    log_message "Updating dotfiles..."
    pull_dotfiles_changes
    ;;
  *)
    log_message "Invalid choice. Exiting."
    exit 1
    ;;
esac

log_message "Operation complete."

