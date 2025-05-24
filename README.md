# Personal and Professional Dotfiles Repository
This repository includes the following custom configurations:
- Bash configuration customization (prompt, history, colors)
  - `.bash_completion`, `.bashrc` and `.bash_tools`
- Git aliases
- Kubernetes aliases
- Utility aliases and functions
- htop, tmux and vim configuration customization 
  - `.htoprc` with theme and better visibility
  - `.tmux.conf` with theme and better visibility
  - `.vimrc` with theme, linting, shortcuts and tools

## Table of Contents
1. [Installation](#1-installation)
2. [Dotfiles Usage](#2-dotfiles-usage)
3. [Notes](#3-notes)


## 1. Installation

The installation script can run interactively and non-interactively

### Pre-requisites
The following are required for this configuration to work:
- Debian-based or RHEL-based Linux system, including WSL
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

### Script description
- This script will install prequisites packages and tool packages
- Install man pages for Debian-based or RHEL-based systems
- Install `spotdl`, `yt-dlp` and `tldr` via Python package manager and add them to `$PATH`
- Clone this repository to `$HOME/dotfiles`
- Clone trueline repository to `$HOME/.config/trueline`
- Backup current dotfiles and link from the local repository to the `/tmp/dotfiles_<timestamp>` directory
- Configure git name, mail and branch
- Install `vim-plug` and vim plugins
- Install `tmux` plugins
- Update dotfiles from remote repository

### Actions
- `-i`: Install packages, tools, and dotfiles.
- `-u`: Update dotfiles from the remote repository.

### Parameters
- `-n`: Git username.
- `-m`: Git email.
- `-b`: Git branch (must be `main` or `master`).

### Download and Run the Script

#### Download

Clone this repository or use the following command:
```bash
wget https://raw.githubusercontent.com/gsousa7/dotfiles/main/install.sh -O /tmp/install.sh
```
Grant the correct permission to the file, example `chmod +x /tmp/install.sh`

#### Interactive Mode
Run the script without arguments to be prompted for actions:
```bash
/tmp/install.sh
```

#### Non-Interactive Mode
Run the script with arguments to skip prompts:
- Install packages, tools, and dotfiles with Git configuration provided as parameters:
```bash
/tmp/install.sh -i -n <user> -m <mail@mail.com> -b <branch>
```
- Update dotfiles from the remote repository (no need to provide parameters):
```bash
/tmp/install.sh -u
```


## Troubleshooting
- **Permission Issues**:
   Grant sudo permissions to the user

- **Font Issues**:
   If fonts are not applied, rebuild the font cache:
   ```bash
   sudo fc-cache -fv
   ```
   
---

## 2. Dotfiles usage
- To view available aliases and functions, run:
  ```bash
  lscom help 
  ```
  or
  ```bash
  lscom
  ```
- To see `vim` info, run:
  ```bash
  vimfo
  ```
- To see `tmux` info, run:
  ```bash
  tmuxfo
  ```
- To see Visual Studio Code info, run:
  ```bash
  vscfo
  ```

## 3. Notes
- `.bashrc` file will only be modified to load `.bash_tools` and starship, making it easier to manage.
- If no SSH key is found, the script will prompt you to create one and add it to your GitHub account `ssh-keygen`
- If running in WSL, you may need to manually install the fonts from `/usr/local/share/fonts`.
- Inspired by [bahamas10's dotfiles](https://github.com/bahamas10/dotfiles) and [ChrisTitusTech dotfiles](https://github.com/christitustech/mybash). 