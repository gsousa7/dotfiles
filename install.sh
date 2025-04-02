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
  "zip" "unzip" "whois" "sed" "nmap" "ncdu" "mtr" "lolcat" "apg" "cowsay"
  "lsof" "bc"
)

# Extra tools to install via pip
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

# Create backups and symlinks for dotfiles
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

  # HTOP configuration to link it in ~/.config/htop
  if [ -f "$DOTFILES_DIR/htoprc" ]; then
    mkdir -p "$HOME/.config/htop"
    ln -sf "$DOTFILES_DIR/htoprc" "$HOME/.config/htop/htoprc" && log_message "Symlink created for htoprc."
  fi
}

# Include bash_tools
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
      echo "Invalid branch name. Please enter 'master' or 'main'."
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
    curl -fLo "$plug_vim_path" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || log_message "Failed to install Vim-Plug."
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

  # Install fonts
  declare -a fonts=(
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

  fonts_version='3.3.0'
  fonts_dir="/usr/local/share/fonts"

  if [[ ! -d "$fonts_dir" ]]; then
     mkdir -p "$fonts_dir"
  fi

  for font in "${fonts[@]}"; do
     zip_font_file="${font}.zip"
     download_font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${fonts_version}/${zip_font_file}"
     echo "Downloading $download_font_url"
     wget "$download_font_url"
     unzip -o "$zip_font_file" -d "$fonts_dir"
     rm "$zip_font_file"
  done
  
  fc-cache -fv
  echo "If running in WSL open $fonts_dir and install fonts."
}

# Installs vim plugins in .vimrc
install_vim_plugins() {
  if command -v vim &> /dev/null; then
    log_message "Installing Vim plugins..."
    vim +'PlugInstall --sync' +qa
  else
    log_message "Vim is not installed. Skipping plugin installation."
  fi
}

install_tmux_plugins() {
  log_message "Installing tmux plugins..."

  local plugin_path="${HOME}/.config/tmux/plugins"
  local tpm_path="${plugin_path}/tpm"

  git clone --depth 1 https://github.com/tmux-plugins/tpm "${tpm_path}"

$  "${tpm_path}/bin/install_plugins"
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
    symlink_dotfiles
    include_bash_tools
    install_vim_prereq
    install_vim_plugins
    install_tmux_plugins
    ;;
  [uU2]*)
    log_message "Updating dotfiles..."
    cd "$DOTFILES_DIR" && git pull || log_message "Error pulling changes."
    echo "Reload bash or close and open a new shell"
    ;;
  *)
    log_message "Invalid choice. Exiting."
    exit 1
    ;;
esac

log_message "Operation complete."
