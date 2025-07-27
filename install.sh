#!/usr/bin/env bash

# This script will backup existing dot files if they exist, install prerequisites and tools, and install new dotfiles

# Variables
DOTFILES_REPO="git@github.com:gsousa7/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
TIMESTAMP="$(date +%Y%m%d_%H%M)"
BACKUP_DIR="/tmp/dotfiles_$TIMESTAMP"
LOG_FILE="$BACKUP_DIR/dotfiles_install.log"
ORIGINAL_BASHRC="$HOME/.bashrc"
STARSHIP_CONFIG="$HOME/.config/starship.toml"


# Create backup and log directory
mkdir -p "$BACKUP_DIR"

# Create costum directories
mkdir -p "$HOME/.config/ansible"
mkdir -p "$HOME/git"
mkdir -p "$HOME/lab"
mkdir -p "$HOME/work"

# List of dotfiles to handle
FILES_TO_SYMLINK=(
  "bash_completion"
  "vimrc"
)

# Bash tools file to include
BASH_TOOLS="bash_tools"

# List of core packages to install
PACKAGES=(
  "telnet" "rsync" "wget" "curl" "bash-completion" "vim" "htop" "tcpdump" "jq" "ncdu" "ansible" "fontconfig" "fdupes" "rename" "python3" "python3-pip" "netcat-openbsd" "traceroute" "ssh" "btop" "atop" "ffmpeg" "git" "pipx" "tmux" "zip" "unzip" "whois" "sed" "nmap" "mtr" "lolcat" "apg" "cowsay" "lsof" "bc" "tree" "xclip" "ripgrep" "fonts-powerline" "bat" "software-properties-common" "coreutils"
)

# Extra tools to install via python package manager
EXTRA_TOOLS=("spotdl" "yt-dlp" "tldr")

# Log function to capture success and failure
log_message() {
  local GREEN="\e[32m"
  local RESET="\e[0m"
  local message="$1"

  # Print colored message to console (stdout)
  echo -e "${GREEN}${message}${RESET}"

  # Print plain message to log file
  echo "${message}" >> "$LOG_FILE"
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
            "shellcheck"
            "shfmt"
        )
        sudo apt update

      

    # Install glow markdown viewer
    log_message "Installing glow..."
    if command -v glow >/dev/null 2>&1; then
        log_message "glow is already installed"
    elif [ -d /etc/apt/keyrings ] || sudo mkdir -p /etc/apt/keyrings; then
        if curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
           echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list && \
           sudo apt update && sudo apt install glow -y; then
            log_message "glow installed successfully"
        else
            log_message "Failed to install glow"
        fi
    else
        log_message "/etc/apt/keyrings directory does not exist and could not be created"
    fi
       

    elif [[ "$PACKAGE_MANAGER" == "dnf" || "$PACKAGE_MANAGER" == "yum" ]]; then
        $PACKAGE_MANAGER install -y epel-release
        PACKAGES+=(
            "man-db"
            "man-pages"
            "python3-docs"
            "bash-doc"
            "info"
            "man-pages-devel"
            "system-doc"
            "shellcheck"
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

  if ! command -v pastel &> /dev/null; then
    log_message "Installing pastel"
    wget "https://github.com/sharkdp/pastel/releases/download/v0.8.1/pastel_0.8.1_amd64.deb"
    sudo dpkg -i pastel_0.8.1_amd64.deb
    rm -f pastel_0.8.1_amd64.deb 
  else
    log_message "Pastel is already installed."
  fi
 

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

# Backup existing dotfiles
backup_dotfiles() {
 
  for file in "${FILES_TO_SYMLINK[@]}"; do
    local dotfile="$HOME/.$file"
    if [ -f "$dotfile" ] || [ -L "$dotfile" ]; then
      mv "$dotfile" "$BACKUP_DIR" && log_message "Backed up .$file"
    else
      log_message ".$file not found, skipping backup"
    fi
  done

  if [ -f "$HOME/$BASH_TOOLS" ] || [ -L "$HOME/$BASH_TOOLS" ]; then
    mv "$BASH_TOOLS" "$BACKUP_DIR/" && log_message "Backed up .$BASH_TOOLS"
  else
    log_message ".$BASH_TOOLS not found, skipping backup"
  fi

  if [ -f "$ORIGINAL_BASHRC" ] || [ -L "$ORIGINAL_BASHRC" ]; then
    cp "$ORIGINAL_BASHRC" "$BACKUP_DIR/" && log_message "Backed up .bashrc"
  else
    log_message ".bashrc not found, skipping backup"
  fi

  # Backup htoprc
  if [ -f "$HOME/.config/htop/htoprc" ] || [ -L "$HOME/.config/htop/htoprc" ]; then
    mkdir -p "$BACKUP_DIR/.config/htop"
    mv "$HOME/.config/htop/htoprc" "$BACKUP_DIR/.config/htop/" && log_message "Backed up htoprc"
  fi 

  # Backup tmux.conf
  # Backup $HOME/tmux.conf
  if [ -f "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
    mkdir -p "$BACKUP_DIR/.config/tmux"
    mv "$HOME/.tmux.conf" "$BACKUP_DIR/.config/tmux/" && log_message "Backed up .tmux.conf"
  fi

  # Backup $HOME/.config/tmux/tmux.conf
  if [ -f "$HOME/.config/tmux/tmux.conf" ] || [ -L "$HOME/.config/tmux/tmux.conf" ]; then
    mkdir -p "$BACKUP_DIR/.config/tmux"
    mv "$HOME/.config/tmux/tmux.conf" "$BACKUP_DIR/.config/tmux/" && log_message "Backed up tmux.conf"
  fi
  
  # Backup starship.toml
  if [ -f "$STARSHIP_CONFIG" ] || [ -L "$STARSHIP_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/.config/starship"
    mv "$STARSHIP_CONFIG" "$BACKUP_DIR/.config/starship/" && log_message "Backed up starship.toml"
  fi

  if [ -f "$HOME/.config/glow/glow.yml" ] || [ -L "$$HOME/.config/glow/glow.yml" ]; then
    mkdir -p "$BACKUP_DIR/.config/glow"
    mv "$HOME/.config/glow/glow.yml" "$BACKUP_DIR/$HOME/.config/glow/" && log_message "Backed up glow.yml"
  fi
}

# Symlink dotfiles from repository to home directory
symlink_dotfiles() {
  log_message "Creating symlinks from $DOTFILES_DIR to home"

  for file in "${FILES_TO_SYMLINK[@]}"; do
    ln -sf "$DOTFILES_DIR/$file" "$HOME/.$file" && log_message "Linked $file"
  done

  # Symlink tmux config to .config directory
  mkdir -p "$HOME/.config/tmux"
  ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.config/tmux/tmux.conf" && log_message "Linked tmux.conf to .config"
  
  # Symlink htop config to .config directory
  mkdir -p "$HOME/.config/htop"
  ln -sf "$DOTFILES_DIR/htoprc" "$HOME/.config/htop/htoprc" && log_message "Linked htoprc to .config"

  # Symlink ansible config to .config directory
  ln -sf "$DOTFILES_DIR/ansible.cfg" "$HOME/.config/ansible/ansible.cfg" && log_message "Linked ansible.cfg to .config"
  touch "$HOME/.config/ansible/inventory" && log_message "Created ansible inventory file in .config/ansible/inventory"

    # Symlink glow config to .config directory
  mkdir -p "$HOME/.config/glow"
  ln -sf "$DOTFILES_DIR/glow.yml" "$HOME/.config/glow/glow.yml" && log_message "Linked glow.yml to .config"
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
}

# Git configuration
update_gitconfig() {
  log_message "Updating Git configuration..."

  # Parse command-line arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      -n)
        git_user="$2"
        shift 2
        ;;
      -m)
        git_email="$2"
        shift 2
        ;;
      -b)
        git_branch="$2"
        shift 2
        ;;
      *)
        log_message "Unknown argument: $1"
        shift
        ;;
    esac
  done

  # Prompt for Git username if not provided
  if [ -z "$git_user" ]; then
    read -p "Enter your Git username (user only): " git_user
    git_user=$(echo "$git_user" | sed 's/^[ \t]*//;s/[ \t]*$//')
  fi

  # Prompt for Git email if not provided
  if [ -z "$git_email" ]; then
    read -p "Enter your Git email: " git_email
    git_email=$(echo "$git_email" | awk '{print tolower($0)}')
  fi

  # Prompt for Git branch if not provided
  if [ -z "$git_branch" ]; then
    read -p "What is your init branch? (master or main): " git_branch
    git_branch=$(echo "$git_branch" | sed 's/^[ \t]*//;s/[ \t]*$//')
    if [[ "$git_branch" != "master" && "$git_branch" != "main" ]]; then
      log_message "Invalid branch name. Please enter 'master' or 'main'."
      exit 1
    fi
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
  log_message "Change the font in your terminal and Visual Studio Code to a nerd font."
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
  
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  
  log_message "Run tmux and press Ctrl a + I to install plugins."
}

install_starship() {
  log_message "Installing Starship prompt..."
  
  if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
    log_message "Starship installed successfully."
    if ! grep -Fxq 'eval "$(starship init bash)"' ~/.bashrc; then
      echo 'eval "$(starship init bash)"' >> ~/.bashrc
    fi
    log_message "Starship prompt added to .bashrc."
  else
    log_message "Starship is already installed or failed."
  fi

  # Backup default starship.toml
  if [ -f "$STARSHIP_CONFIG" ] || [ -L "$STARSHIP_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/.config/starship"
    mv "$STARSHIP_CONFIG" "$BACKUP_DIR/.config/starship/starship.toml_$TIMESTAMP" && log_message "Backed up default starship.toml"
  fi

  ln -sf "$DOTFILES_DIR/starship_full.toml" "$HOME/.config/starship.toml"
  log_message "Starship full/detailed configuration file linked."
}

update_everything () {
  log_message "Updating dotfiles..."
  pip install --upgrade pip pipx
  pipx upgrade-all
  pipx ensurepath
  cd "$DOTFILES_DIR" && git pull || log_message "Error pulling changes."
  log_message "To apply all changes, restart your shell or run: 'source ~/.bashrc' or 'rb'"

}


# Main script execution
log_message "Script execution started."
echo ""
detect_package_manager

# Parse command-line arguments
action=""
extra_args=()
git_user=""
git_email=""
git_branch=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -i)
      action="install"
      shift
      ;;
    -u)
      action="update"
      shift
      ;;
    -n)
      git_user="$2"
      extra_args+=("$1" "$2")
      shift 2
      ;;
    -m)
      git_email="$2"
      extra_args+=("$1" "$2")
      shift 2
      ;;
    -b)
      git_branch="$2"
      extra_args+=("$1" "$2")
      shift 2
      ;;
    *)
      log_message "Unknown argument: $1"
      exit 1
      ;;
  esac
done

# Validate mandatory arguments for the install action
if [[ "$action" == "install" ]]; then
  if [[ -z "$git_user" || -z "$git_email" || -z "$git_branch" ]]; then
    log_message "Error: The -i (install) action requires -n (Git username), -m (Git email), and -b (Git branch)."
    exit 1
  fi
fi

# Perform action based on argument or prompt user
if [[ -z "$action" ]]; then
  read -p "Do you want to (i)nstall packages and tools, dotfiles, (u)pdate dotfiles or (q)uit? [i/u/q]: " choice
  case "$choice" in
    i)
      action="install"
      ;;
    u)
      action="update"
      ;;
    q)
      log_message "Exiting without changes."
      exit 0
      ;;
    *)
      log_message "Invalid choice. Exiting."
      exit 1
      ;;
  esac
fi

# Execute the selected action
case "$action" in
  install)
    install_packages
    echo ""
    install_extra_tools
    echo ""
    install_fonts
    echo ""
    update_gitconfig "${extra_args[@]}" # Pass Git configuration arguments
    echo ""
    clone_dotfiles_repo
    echo ""
    backup_dotfiles
    echo ""
    symlink_dotfiles
    echo ""
    include_bash_tools
    echo ""
    install_vim_prereq
    echo ""
    install_vim_plugins
    echo ""
    install_tmux_plugins
    echo ""
    install_starship
    echo ""
    
    ;;
  update)
    update_everything
    ;;
  *)
    log_message "Invalid action. Exiting."
    exit 1
    ;;
esac

echo ""
log_message "Operation complete. If needed check the log file at $LOG_FILE"
echo ""
log_message "To apply all changes, restart your shell or run: 'source ~/.bashrc'"
echo ""
log_message "Run tmux and press Ctrl a + I to install plugins."
echo ""
log_message "Current skin is set to detailed/full, to change skin run 'pskins' for simple configuration or 'pskinf' for detailed/full configuration."  
echo ""
log_message "Backups saved in: $BACKUP_DIR"
echo ""
log_message "If in WSL instead of OS with Linux, change the variable DESKTOPWINSL to your Windows Desktop path, example: /mnt/c/Users/<Windows_User>/"
log_message "If in WSL instead of OS with Linux, install manually the fonts in /usr/local/share/fonts and delete the fonts zip files."
log_message "Turn on the WSL integration in Visual Studio Code"
echo ""
log_message "Log in to GitHub to import configuration and settings"