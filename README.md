# Personal and Professional Dotfiles Repository
This repository includes the following custom configurations:
- Bash configuration customization (prompt, history, colors)
  - `.bash_completion`, `.bashrc`, `.htoprc` and `.tmux.conf`
- Git aliases
- Kubernetes aliases
- Utility aliases
- Vim configuration customization (`.vimrc` with theme, linting, shortcuts and tools)

## Table of Contents
1. [Installation](#1-installation)
2. [Usage](#2-usage)
3. [Notes](#3-notes)


## **1. Installation**
### Pre-requisites
The following are required for this configuration to work:
- Sudo access configured for the user
- `git` installed

#### Sudo access
To grant sudo access without a password prompt, type `visudo` and add the following line at the end of the file:
```bash
<user> ALL=(ALL) NOPASSWD: ALL
```
Replace `<user>` with the user you want to configure.

#### Git installation
For Debian-based systems:
```bash
sudo apt install -y git
```

For RHEL-based systems:
```bash
sudo dnf install -y git
```

### Clone the repository
```bash
git clone git@github.com:gsousa7/dotfiles.git $HOME/dotfiles
```

### Navigate into the directory
```bash
cd $HOME/dotfiles
```

### Make the install script executable
```bash
chmod +x install.sh
```

### Run the script
```bash
./install.sh
```

### Script description
- This script will install prequisites packages and tool packages
- Install man pages for Debian-based or RHEL-based systems
- Install `spotdl`, `yt-dlp` and `tldr` via Python package manager and add them to `$PATH`
- Clone this repository to `$HOME/dotfiles`
- Backup current dotfiles and link from the local repository to the `$HOME` directory
- Prompt for git configuration (Name, Mail and Init branch)
- Install `vim-plug` and vim plugins
- Update dotfiles from remote repository


## 2. Usage
- To install, type **1** (or **I** or **i**) when prompted.
- To update, type **2** (or **U** or **u**).
- To view available aliases and functions, run:
  ```bash
  lscom help 
  ```
  or
  ```bash
  lscom
  ```
- To see Vim info, run:
  ```bash
  vimfo
  ```

## 3. Notes
- `.bashrc` file will only be modified to load `.bash_tools`, making it easier to manage.
- To update Python packages use the following commands
```bash
pip install --upgrade pip pipx
pipx upgrade yt-dlp tldr spotdl
pipx ensurepath
source ~/.bashrc 
```
- Inspired by [bahamas10's dotfiles](https://github.com/bahamas10/dotfiles).

