show_git_commands() {
    echo ""
    echo -e "${ORANGE}List of Git aliases and functions:${RESET}"
    echo -e "${MAGENTA}lazygit${RESET}         - Commit and push changes to a specified branch. Usage: ${YELLOW}lazygit '<commit_message>' <branch_name>${RESET}"
    echo -e "${MAGENTA}nb${RESET}              - Create a new Git branch. Usage: nb ${YELLOW}<branch_name>${RESET}"
    echo -e "${MAGENTA}gall${RESET}            - Add all changes to Git staging area (equal to git add -A)."
    echo -e "${MAGENTA}gst${RESET}             - Show the current status of the Git repository."
    echo -e "${MAGENTA}gdst${RESET}            - Show the current status of the Git repositories existing in current directory"
    echo -e "${MAGENTA}gppr${RESET}            - Show if the 'main' branch in local Git repositories is pushed to remote"
    echo -e "${MAGENTA}ga${RESET}              - Add file to Git staging area. Usage: ga <file>"
    echo -e "${MAGENTA}gf${RESET}              - Fetch updates from the remote Git repository (git fetch)."
    echo -e "${MAGENTA}gb${RESET}              - Show the list of Git branches."
    echo -e "${MAGENTA}gc${RESET}              - Commit staged changes with a message. Usage: ${YELLOW}gc '<commit_message>'${RESET}"
    echo -e "${MAGENTA}gcl${RESET}             - Clone a Git repository. Usage: ${YELLOW}gcl <repository_url>${RESET}"
    echo -e "${MAGENTA}gi${RESET}              - Initialize a new Git repository."
    echo -e "${MAGENTA}gl${RESET}              - Show the Git log with a detailed, colored graph, including hash, date, author, email, and subject."
    echo -e "${MAGENTA}gls${RESET}             - Show a concise, one-line graph of all Git log branches with decorations."
    echo -e "${MAGENTA}glps${RESET}            - Show the Git log across all branches, with concise commit details and file change statistics."
    echo -e "${MAGENTA}glpd${RESET}            - Show the Git log across all branches, with concise commit details and full patch (diff) information."
    echo -e "${MAGENTA}gstr${RESET}            - Show a simplified graph of the Git log, displaying only decorated commits (e.g., merge points, branch tips)."
    echo -e "${MAGENTA}gp${RESET}              - Push changes to a remote Git repository. Usage: ${YELLOW}gp <branch_name>${RESET}"
    echo -e "${MAGENTA}gu${RESET}              - Pull updates from the remote Git repository (git pull)."
    echo -e "${MAGENTA}gs${RESET}              - Switch Git branches. Usage: ${YELLOW}gs <branch_name>${RESET}"
    echo -e "${MAGENTA}gsts${RESET}            - Show the short status of the Git repository."
    echo -e "${MAGENTA}gdif${RESET}            - Show the differences between the working directory and the last commit."
    echo -e "${MAGENTA}gloa${RESET}            - Filter Git log by author. Usage: ${YELLOW}git log --author <author name or email>${RESET}"
    echo -e "${MAGENTA}glof${RESET}            - Follow a file's history in Git log through renames. Usage: ${YELLOW}git log --follow <file>${RESET}"
    echo
    echo -e "${YELLOW}zsh only: a larger OMZ-style set (gco, gcb, gsw, gpsup, gwip, ...) is available too - see 'zfo git'.${RESET}"
    echo
}

show_kubernetes_commands() {
    echo ""
    echo -e "${ORANGE}List of Kubernetes aliases and functions:${RESET}"
    echo -e "${MAGENTA}k${RESET}      - Kubernetes alias for kubectl."
    echo -e "${MAGENTA}ks${RESET}     - Kubernetes alias for kubectl with the kube-system namespace."
    echo
    echo -e "${BLUE}## Cluster Commands:${RESET}"
    echo -e "${MAGENTA}kci${RESET}    - Display cluster information."
    echo -e "${MAGENTA}kgnw${RESET}   - Get the list of nodes with wide output (shows additional information)."
    echo
    echo -e "${BLUE}## Create resources:${RESET}"
    echo -e "${MAGENTA}kcf${RESET}    - Create a Kubernetes resource from a file. ${YELLOW}Usage: kcf <file.yaml>${RESET}"
    echo -e "${MAGENTA}kaf${RESET}    - Apply a Kubernetes resource from a file. ${YELLOW}Usage: kaf <file.yaml>${RESET}"
    echo
    echo -e "${BLUE}## Get resources:${RESET}"
    echo -e "${MAGENTA}kgn${RESET}    - Get the list of nodes in the Kubernetes cluster."
    echo -e "${MAGENTA}kgp${RESET}    - Get the list of pods in the Kubernetes cluster."
    echo -e "${MAGENTA}kgpa${RESET}   - Get the list of pods in all namespaces in the Kubernetes cluster."
    echo -e "${MAGENTA}kgs${RESET}    - Get the list of services in the Kubernetes cluster."
    echo -e "${MAGENTA}kgd${RESET}    - Get the list of deployments in the Kubernetes cluster."
    echo -e "${MAGENTA}kgns${RESET}   - Get the list of namespaces in the Kubernetes cluster."
    echo
    echo -e "${BLUE}## Delete:${RESET}"
    echo -e "${MAGENTA}kd${RESET}     - Delete a Kubernetes resource. Usage: ${YELLOW}kd <resource_type> <resource_name>${RESET}"
    echo -e "${MAGENTA}kdp${RESET}    - Delete a Kubernetes pod. Usage: ${YELLOW}kdp <pod_name>${RESET}"
    echo -e "${MAGENTA}kds${RESET}    - Delete a Kubernetes service. Usage: ${YELLOW}kds <service_name>${RESET}"
    echo -e "${MAGENTA}kdd${RESET}    - Delete a Kubernetes deployment. Usage: ${YELLOW}kdd <deployment_name>${RESET}"
    echo -e "${MAGENTA}kdn${RESET}    - Delete a Kubernetes namespace. Usage: ${YELLOW}kdn <namespace_name>${RESET}"
    echo
    echo -e "${BLUE}## Documentation & Logs:${RESET}"
    echo -e "${MAGENTA}kexp${RESET}   - Show documentation for a Kubernetes resource type or existing resource. Usage: ${YELLOW}kexp <resource>${RESET}"
    echo -e "${MAGENTA}kdesc${RESET}  - Describe Kubernetes resources. Usage: ${YELLOW}kdesc <resource_type> <resource_name>${RESET}"
    echo -e "${MAGENTA}kl${RESET}     - Show logs for a pod. Usage: ${YELLOW}kl <pod_name>${RESET}"
    echo
    echo -e "${BLUE}## Others:${RESET}"
    echo -e "${MAGENTA}ked${RESET}    - Edit a Kubernetes resource. Usage: ${YELLOW}ked <resource_type>/<resource_name>${RESET}"
    echo -e "${MAGENTA}ke${RESET}     - Execute a command inside a running pod. Usage: ${YELLOW}ke <pod_name> -- <command>${RESET}"
    echo -e "${MAGENTA}ksetns${RESET} - Jump to namespace for kubectl context. Usage: ${YELLOW}ksetns <namespace>${RESET}"
    echo
    echo -e "${YELLOW}zsh only: extra read-only aliases (kgpw, kgi, kge, kn, kx, ...) are available too - see 'zfo kubectl'.${RESET}"
    echo
}

show_eza_commands() {
    echo ""
    echo -e "${ORANGE}List of Eza commands and aliases:${RESET}"
    echo -e "${BLUE}--- Git Status Legend ---${RESET}"
    echo "This shows a two-character column indicating staged and unstaged statuses."
    echo ""
    echo -e "${BLUE}Character Meanings:${RESET}"
    echo -e "  ${MAGENTA}- ${RESET} - Not modified"
    echo -e "  ${MAGENTA}M ${RESET} - Modified file"
    echo -e "  ${MAGENTA}N ${RESET} - New file"
    echo -e "  ${MAGENTA}D ${RESET} - Deleted"
    echo -e "  ${MAGENTA}R ${RESET} - Renamed"
    echo -e "  ${MAGENTA}T ${RESET} - Type-change"
    echo -e "  ${MAGENTA}I ${RESET} - Ignored"
    echo -e "  ${MAGENTA}U ${RESET} - Conflicted"
    echo -e "${MAGENTA}l         ${RESET} - Lists files with icons, sorted by name."
    echo -e "${MAGENTA}ls        ${RESET} - Lists all files (-a) with icons and Git status, sorted by name."
    echo -e "${MAGENTA}ll        ${RESET} - Lists all files (-lah) with icons and Git status in long format, sorted by name."
    echo -e "${MAGENTA}lls       ${RESET} - Lists all files in long format, with icons and Git status, sorted by size."
    echo -e "${MAGENTA}ld        ${RESET} - Lists only directories with Git status and icons."
    echo -e "${MAGENTA}lf        ${RESET} - Lists only files with Git status and icons."
    echo -e "${MAGENTA}lda       ${RESET} - Lists all directories (-lah) with Git status and icons."
    echo -e "${MAGENTA}lfa       ${RESET} - Lists all files (-lah) with Git status and icons."
    echo -e "${MAGENTA}tree      ${RESET} - Shows a tree view (-aT) of all files with icons."
    echo -e "${MAGENTA}ltree     ${RESET} - Shows a long tree view (-lahT) of all files with Git status."
    echo -e "${MAGENTA}lt        ${RESET} - Creates a long tree view (-lTg) with icons, sorted by name."
    echo -e "${MAGENTA}lt2       ${RESET} - Same as lt, but shows only 2 levels deep."
    echo -e "${MAGENTA}lt3       ${RESET} - Same as lt, but shows only 3 levels deep."
    echo -e "${MAGENTA}lt4       ${RESET} - Same as lt, but shows only 4 levels deep."
    echo -e "${MAGENTA}lta       ${RESET} - Creates a long tree view (-lTag) including hidden files, with Git status and icons."
    echo -e "${MAGENTA}lta2      ${RESET} - Same as lta, but shows only 2 levels deep."
    echo -e "${MAGENTA}lta3      ${RESET} - Same as lta, but shows only 3 levels deep."
    echo -e "${MAGENTA}lta4      ${RESET} - Same as lta, but shows only 4 levels deep."
    echo -e "${MAGENTA}l.        ${RESET} - Lists the contents of the parent directory (../)."
    echo -e "${MAGENTA}l..       ${RESET} - Lists the contents of the directory 2 levels up (../../)."
    echo -e "${MAGENTA}l...      ${RESET} - Lists the contents of the directory 3 levels up (../../../)."
}

show_utility_commands() {
    echo ""
    echo -e "${ORANGE}List of Terminal Utility alias and functions:${RESET}"
    echo -e "${MAGENTA}v         ${RESET} - vim"
    echo -e "${MAGENTA}aqui      ${RESET} - Open the current directory in Windows Explorer (WSL Only)."
    echo -e "${MAGENTA}fmedia    ${RESET} - Move all .mkv and .mp4 files to the current directory."
    echo -e "${MAGENTA}cdd       ${RESET} - Change directory to Windows Desktop on WSL (WSL Only)."
    echo -e "${MAGENTA}explain   ${RESET} - Explains the given command or enters interactive mode to explain commands."
    echo -e "${MAGENTA}tldr      ${RESET} - Explains the given command and provides examples."
    echo -e "${MAGENTA}data      ${RESET} - Print the current date and time."
    echo -e "${MAGENTA}tempolx   ${RESET} - Get the weather in Lisboa."
    echo -e "${MAGENTA}temposx   ${RESET} - Get the weather in Seixal."
    echo -e "${MAGENTA}tempolxf  ${RESET} - Get the full weather info in Lisboa."
    echo -e "${MAGENTA}temposxf  ${RESET} - Get the full weather info in Seixal."
    echo -e "${MAGENTA}tempo     ${RESET} - Get the weather in a specified city. Usage: ${YELLOW}tempo <city>${RESET}"
    echo -e "${MAGENTA}tempof    ${RESET} - Get the full weather info in a specified city. Usage: ${YELLOW}tempof <city>${RESET}"
    echo -e "${MAGENTA}dus       ${RESET} - Show disk usage of files and directories."
    echo -e "${MAGENTA}net       ${RESET} - Show network interfaces and their status."
    echo -e "${MAGENTA}ippub     ${RESET} - Show Public IP."
    echo -e "${MAGENTA}ippubf    ${RESET} - Show information on ISP and Public IP"
    echo -e "${MAGENTA}field     ${RESET} - Extract specific fields from a line. Usage: ${YELLOW}field <column_number> <delimiter>${RESET}"
    echo -e "${MAGENTA}epoch     ${RESET} - Convert epoch to human-readable date. Usage: ${YELLOW}epoch <epoch_time>${RESET}"
    echo -e "${MAGENTA}lintsh    ${RESET} - Lint shell scripts using ShellCheck. Usage: ${YELLOW}lintsh <file.sh>${RESET}"
    echo -e "${MAGENTA}fmtsh     ${RESET} - Format shell scripts using shfmt. Usage: ${YELLOW}fmtsh <file.sh>${RESET}"
    echo -e "${MAGENTA}rz        ${RESET} - Reload the shell (exec zsh)"
    echo -e "${MAGENTA}etx       ${RESET} - Open $HOME/.config/tmux/tmux.conf in vim"
    echo -e "${MAGENTA}es        ${RESET} - Open current starship configuration in vim - $HOME/.config/starship.toml"
    echo -e "${MAGENTA}ez        ${RESET} - Open $HOME/dotfiles/zshrc in vim"
    echo -e "${MAGENTA}ezt       ${RESET} - Open $HOME/dotfiles/zsh_tools.d in vim"
    echo -e "${MAGENTA}eb        ${RESET} - Open $HOME/.bashrc in vim"
    echo -e "${MAGENTA}ebt       ${RESET} - Open $HOME/dotfiles/bash_tools.d in vim"
    echo -e "${MAGENTA}evrc      ${RESET} - Open $HOME/.vimrc in vim"
    echo -e "${MAGENTA}eai       ${RESET} - Open $HOME/.config/ansible/inventory in vim"
    echo -e "${MAGENTA}wdir      ${RESET} - Change directory to $HOME/work"
    echo -e "${MAGENTA}gdir      ${RESET} - Change directory to $HOME/git"
    echo -e "${MAGENTA}ldir      ${RESET} - Change directory to $HOME/lab"
    echo -e "${MAGENTA}ddir      ${RESET} - Change directory to $HOME/dotfiles"
    echo -e "${MAGENTA}dsk       ${RESET} - Change directory to a specified directory in /mnt. Usage: ${YELLOW}dsk <drive>${RESET}"
    echo -e "${MAGENTA}vimfo     ${RESET} - Show custom vim keymaps and cheatsheet"
    echo -e "${MAGENTA}tmuxfo    ${RESET} - Show custom tmux keymaps and cheatsheet"
    echo -e "${MAGENTA}vscfo     ${RESET} - Show Visual Studio Code keymaps and cheatsheet"
    echo -e "${MAGENTA}svim      ${RESET} - Edit files with sudo. Equal to 'sudoedit' and 'sudo -e'"
    echo -e "${MAGENTA}..        ${RESET} - Go up one directory"
    echo -e "${MAGENTA}...       ${RESET} - Go up two directories"
    echo -e "${MAGENTA}.3        ${RESET} - Go up three directories"
    echo -e "${MAGENTA}.4        ${RESET} - Go up four directories"
    echo -e "${MAGENTA}.5        ${RESET} - Go up five directories"
    echo -e "${MAGENTA}rg        ${RESET} - Enhanced ripgrep: searches hidden files, smart case, custom colors, no zips. Usage: ${YELLOW}rg <pattern> [path]${RESET}"
    echo -e "${MAGENTA}rga       ${RESET} - Search all files: includes hidden, ignored, and binary files. Usage: ${YELLOW}rga <pattern> [path]${RESET}"
    echo -e "${MAGENTA}rgs       ${RESET} - Search only staged Git files. Usage: ${YELLOW}rgs <pattern>${RESET}"
    echo -e "${MAGENTA}pastel    ${RESET} - Generate, list, analyze, convert and manipulate colors${RESET}"
    echo -e "${MAGENTA}glow      ${RESET} - Render Markdown files in the terminal with syntax highlighting. Usage: ${YELLOW}glow <file.md>${RESET} or interactive mode with files in current directory ${YELLOW}glow${RESET}"
    echo -e "${MAGENTA}bat       ${RESET} - View files with syntax highlighting, line numbers, and Git integration. Usage: ${YELLOW}bat <file>${RESET}"
    echo -e "${MAGENTA}bats      ${RESET} - View files as plain text, without pager, syntax highlighting, line numbers, or Git integration. Usage: ${YELLOW}bats <file>${RESET}"
    echo -e "${MAGENTA}cat      ${RESET}  - Same as bats but with no line numbers. Usage: ${YELLOW}cat <file>${RESET}"
    echo -e "${MAGENTA}ex        ${RESET} - Extracts various compressed file types automatically. Usage: ${YELLOW}ex <path/file_name_1.ext> [path/file_name_2.ext]...${RESET}"
    echo -e "${MAGENTA}hl        ${RESET} - Highlights the output of a command using batcat. Usage: ${YELLOW}hl <command> ${RESET}or ${YELLOW}<command> | hl${RESET}"
    echo -e "${MAGENTA}s5m       ${RESET} - Sleep 5 minutes."
    echo -e "${MAGENTA}s10m      ${RESET} - Sleep 10 minutes."
	echo -e "${MAGENTA}ffblur    ${RESET} - Update Firefox Blur theme"
}

show_brew_commands () {
    echo ""
    echo -e "${ORANGE}List of Brew commands:${RESET}"
    echo -e "${MAGENTA}brew install     ${RESET} - Installs a package. Usage: ${YELLOW}brew install <formula>${RESET}"
    echo -e "${MAGENTA}brew update      ${RESET} - Updates Homebrew and its package list. Usage: ${YELLOW}brew update${RESET}"
    echo -e "${MAGENTA}brew upgrade     ${RESET} - Upgrades all outdated installed packages. Usage: ${YELLOW}brew upgrade${RESET}"
    echo -e "${MAGENTA}brew search      ${RESET} - Searches for available packages. Usage: ${YELLOW}brew search <text>${RESET}"
    echo -e "${MAGENTA}brew list        ${RESET} - Lists all installed packages. Usage: ${YELLOW}brew list${RESET}"
    echo -e "${MAGENTA}brew uninstall   ${RESET} - Uninstalls a package. Usage: ${YELLOW}brew uninstall <formula>${RESET}"
    echo -e "${MAGENTA}brew doctor      ${RESET} - Diagnoses problems with your installation. Usage: ${YELLOW}brew doctor${RESET}"
}

show_media_commands() {
    echo ""
    echo -e "${ORANGE}List of Media Download functions:${RESET}"
    echo -e "${BLUE}## Youtube (Download audio and/or video):${RESET}"
    echo -e "${MAGENTA}getyt         ${RESET}    - Download audio from a YouTube video and save it in desktop as MP3. Usage: ${YELLOW}getyt <url>${RESET}"
    echo -e "${MAGENTA}getytmp4      ${RESET}    - Download audio from a YouTube video and save it in desktop as MP4 1080p. Usage: ${YELLOW}getytmp4 <url>${RESET}"
    echo -e "${MAGENTA}getytplist    ${RESET}    - Download audio from all videos and save it in desktop in a YouTube playlist. Usage: ${YELLOW}getytplist <url>${RESET}"
    echo -e "${MAGENTA}getytplistmp4 ${RESET}    - Download all videos and save it in desktop in a YouTube playlist in MP4 format. Usage: ${YELLOW}getytplistmp4 <url>${RESET}"
    echo -e "${MAGENTA}getytplistmp4subs${RESET} - Download all videos and save it in desktop in a YouTube playlist in MP4 format with subtitles. Usage: ${YELLOW}getytplistmp4subs <url>${RESET}"
    echo -e "${MAGENTA}getytmp4subs  ${RESET}    - Download a YouTube video and save it in desktop in MP4 format (1080p) with subtitles. Usage: ${YELLOW}getytmp4subs <url>${RESET}"
    echo -e "${MAGENTA}getytformats  ${RESET}    - Check available video/audio formats for a YouTube video (debug tool). Usage: ${YELLOW}getytformats <url>${RESET}"
    echo -e "${MAGENTA}getytflex     ${RESET}    - Flexible YouTube downloader with quality options. Usage: ${YELLOW}getytflex <url> <format> [quality]${RESET} \nFormat: ${YELLOW}mp3|audio|mp4|video${RESET} | Quality: ${YELLOW}720|1080|1440|4k${RESET}"
    echo
    echo -e "${BLUE}## Spotify (Download audio):${RESET}"
    echo -e "${MAGENTA}getspot       ${RESET} - Download a song from Spotify and save it in desktop. Usage: ${YELLOW}getspot <url>${RESET}"
    echo -e "${MAGENTA}getalb        ${RESET} - Download an album from Spotify and save it in desktop. Usage: ${YELLOW}getalb <url>${RESET}"
    echo -e "${MAGENTA}getplay       ${RESET} - Download a playlist from Spotify and save it in desktop. Usage: ${YELLOW}getplay <url>${RESET}"
    echo -e "${MAGENTA}gif           ${RESET} - Generate GIF from video with the following formats small, hq, fast or normal (no need to provide this option is default). Usage: ${YELLOW}gif <input_video> <output_gif> [small|hq|fast]${RESET}"
    echo
}

show_starship_commands() {
    echo ""
    echo -e "${ORANGE}List of Customization functions:${RESET}"
    echo -e "${MAGENTA}pcolor           ${RESET}     - Lists themes and change theme of prompt"
    echo -e "${MAGENTA}starship config  ${RESET}     - Show current Starship prompt configuration."
    echo -e "${MAGENTA}starship print-config${RESET} - Print the current Starship prompt configuration."
    echo -e "${MAGENTA}starship explain ${RESET}     - Explain current Starship prompt configuration."
    echo
    echo -e "${BLUE}Git Status Indicators:${RESET}\n"
    echo -e "  ${MAGENTA} (count)${RESET}            - ${RED}conflicted:${RESET} You have merge conflicts that need to be resolved."
    echo -e "  ${BLUE}󰘽${RESET}                    - ${BLUE}up_to_date:${RESET} Your current branch is clean and in sync with its remote."
    echo -e "  ${RED}󰋗 (count)${RESET}            - ${RED}untracked:${RESET} You have new, untracked files."
    echo -e "  ${MAGENTA} (count)${RESET}            - ${YELLOW}ahead:${RESET} Your local branch is ahead of its remote by 'count' commits."
    echo -e "  ${MAGENTA} (ahead)  (behind)${RESET} - ${YELLOW}diverged:${RESET} Your local branch has diverged from its remote; it's ahead by 'ahead' and behind by 'behind' commits."
    echo -e "  ${MAGENTA} (count)${RESET}            - ${YELLOW}behind:${RESET} Your local branch is behind its remote by 'count' commits."
    echo -e "  ${BLUE} (count)${RESET}            - ${BLUE}stashed:${RESET} You have changes stashed."
    echo -e "  ${YELLOW}󰛿 (count)${RESET}            - ${YELLOW}modified:${RESET} You have uncommitted, modified files."
    echo -e "  ${BLUE}󰐗 (count)${RESET}            - ${BLUE}staged:${RESET} You have 'count' changes staged for commit (added to index)."
    echo -e "  ${YELLOW}󰍸 (count)${RESET}            - ${YELLOW}renamed:${RESET} You have uncommitted, renamed files."
    echo -e "  ${RED}󰍶 (count)${RESET}            - ${RED}deleted:${RESET} You have uncommitted, deleted files."
    echo
}

show_help() {
    echo ""
    echo -e "${YELLOW}Available sections:${RESET}"
    echo "- eza            (or exa, ls, list - Enhanced ls command)"
    echo "- git            (Git commands)"
    echo "- kubernetes     (or k8s - Kubernetes commands)"
    echo "- utils          (or cli, utility, utilities, terminal - Terminal utilities)"
    echo "- youtube        (or yt, spotify, media - Media download commands)"
    echo "- starship       (or theme, prompt, ps1, custom, customization, skin - Starship prompt customization)"
    echo "- brew           (Homebrew commands)"
    echo "- vim            (or vi, editor - Vim commands)"
    echo "- tmux           (Tmux commands)"
    echo "- vsc            (or vscode, code - VS Code commands)"
    echo "- zfo            (extra zsh-only git/kubectl aliases - see 'zfo' directly)"
    echo "- all            (Show all sections)"
    echo
    echo -e "${YELLOW}Usage: lscom [section]${RESET}"
    echo
}


# Main lscom function
lscom() {
    local section="${1:-all}"

    case "$section" in
    "git")
        show_git_commands
        ;;
    "brew" | "homebrew")
        show_brew_commands
        ;;
    "k8s" | "kubernetes")
        show_kubernetes_commands
        ;;
    "utils" | "utilities" | "terminal" | "utility" | "cli")
        show_utility_commands
        ;;
    "youtube" | "yt" | "spotify" | "media")
        show_media_commands
        ;;
    "starship" | "prompt" | "ps1" | "custom" | "customization" | "theme" | "skin")
        show_starship_commands
        ;;
    "eza" | "exa" | "ls" | "list")
        show_eza_commands
        ;;
    "vim" | "vi" | "editor")
        vimfo
        ;;
    "tmux")
        tmuxfo
        ;;
    "vsc" | "vscode" | "code")
        vscfo
        ;;
    "zfo")
        zfo
        ;;
    "all" | "full" | "")
        show_git_commands
        echo
        show_kubernetes_commands
        echo
        show_utility_commands
        echo
        show_media_commands
        echo
        show_starship_commands
        echo
        show_brew_commands
        echo
        show_eza_commands
        echo
        vimfo
        echo
        tmuxfo
        echo
        vscfo
        echo
        zfo
        ;;
    *)
        show_help
        ;;
    esac
}
