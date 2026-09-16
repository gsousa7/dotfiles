# get vim help
vimfo() {
    echo ""
    echo -e "${BLUE}Vim Cheatsheet - Editing Essentials${RESET}\n"
    echo -e "${MAGENTA}Leader Key: Space${RESET}\n"

    # Save/Quit
    echo -e "${ORANGE}Save & Quit:${RESET}"
    echo -e "${MAGENTA}Space w     ${RESET}- Save file"
    echo -e "${MAGENTA}Space q     ${RESET}- Quit"
    echo -e "${MAGENTA}Space x     ${RESET}- Save and quit"
    echo -e "${MAGENTA}:wq         ${RESET}- Save and quit (alternative)"
    echo -e "${MAGENTA}:q!         ${RESET}- Quit without saving"
    echo

    # Movement
    echo -e "${ORANGE}Movement:${RESET}"
    echo -e "${MAGENTA}h j k l     ${RESET}- Left, Down, Up, Right"
    echo -e "${MAGENTA}w           ${RESET}- Next word"
    echo -e "${MAGENTA}b           ${RESET}- Previous word"
    echo -e "${MAGENTA}0           ${RESET}- Start of line"
    echo -e "${MAGENTA}\$           ${RESET}- End of line"
    echo -e "${MAGENTA}gg          ${RESET}- Top of file"
    echo -e "${MAGENTA}G           ${RESET}- Bottom of file"
    echo -e "${MAGENTA}:<number>   ${RESET}- Go to line number (e.g., :42)"
    echo -e "${MAGENTA}Ctrl d      ${RESET}- Page down"
    echo -e "${MAGENTA}Ctrl u      ${RESET}- Page up"
    echo

    # Editing
    echo -e "${ORANGE}Insert & Edit:${RESET}"
    echo -e "${MAGENTA}i           ${RESET}- Insert before cursor"
    echo -e "${MAGENTA}a           ${RESET}- Insert after cursor"
    echo -e "${MAGENTA}o           ${RESET}- New line below"
    echo -e "${MAGENTA}O           ${RESET}- New line above"
    echo -e "${MAGENTA}x           ${RESET}- Delete character"
    echo -e "${MAGENTA}dd          ${RESET}- Delete line"
    echo -e "${MAGENTA}yy          ${RESET}- Copy line"
    echo -e "${MAGENTA}p           ${RESET}- Paste"
    echo -e "${MAGENTA}u           ${RESET}- Undo"
    echo -e "${MAGENTA}Ctrl r      ${RESET}- Redo"
    echo -e "${MAGENTA}.           ${RESET}- Repeat last command"
    echo -e "${MAGENTA}gcc         ${RESET}- Comment/uncomment line"
    echo

    # Visual Mode
    echo -e "${ORANGE}Visual Mode:${RESET}"
    echo -e "${MAGENTA}v           ${RESET}- Character select"
    echo -e "${MAGENTA}V           ${RESET}- Line select"
    echo -e "${MAGENTA}Ctrl v      ${RESET}- Block select"
    echo -e "${YELLOW}In visual mode:${RESET}"
    echo -e "${MAGENTA}>           ${RESET}- Indent right"
    echo -e "${MAGENTA}<           ${RESET}- Indent left"
    echo -e "${MAGENTA}J           ${RESET}- Move lines down"
    echo -e "${MAGENTA}K           ${RESET}- Move lines up"
    echo -e "${MAGENTA}gc          ${RESET}- Comment selection"
    echo -e "${MAGENTA}y           ${RESET}- Copy"
    echo -e "${MAGENTA}d           ${RESET}- Delete"
    echo

    # Search & Replace
    echo -e "${ORANGE}Search & Replace:${RESET}"
    echo -e "${MAGENTA}/pattern    ${RESET}- Search forward"
    echo -e "${MAGENTA}n           ${RESET}- Next match"
    echo -e "${MAGENTA}N           ${RESET}- Previous match"
    echo -e "${MAGENTA}Space /     ${RESET}- Clear search highlights"
    echo -e "${MAGENTA}*           ${RESET}- Search word under cursor"
    echo -e "${MAGENTA}:%s/old/new/g    ${RESET}- Replace all in file"
    echo -e "${MAGENTA}:%s/old/new/gc   ${RESET}- Replace with confirmation"
    echo

    # Mouse
    echo -e "${ORANGE}Mouse:${RESET}"
    echo -e "${MAGENTA}Click       ${RESET}- Position cursor"
    echo -e "${MAGENTA}Drag select ${RESET}- Auto-copy to clipboard"
    echo -e "${MAGENTA}Scroll      ${RESET}- Scroll up/down"
    echo

    # Splits (Optional)
    echo -e "${ORANGE}Splits (Optional):${RESET}"
    echo -e "${MAGENTA}:sp <file>  ${RESET}- Horizontal split"
    echo -e "${MAGENTA}:vsp <file> ${RESET}- Vertical split"
    echo -e "${MAGENTA}Ctrl h/j/k/l${RESET}- Navigate between splits"
    echo -e "${MAGENTA}Ctrl w c    ${RESET}- Close split"
    echo

    # Linting
    echo -e "${ORANGE}Linting (ALE):${RESET}"
    echo -e "${MAGENTA}]e          ${RESET}- Next error/warning"
    echo -e "${MAGENTA}[e          ${RESET}- Previous error/warning"
    echo -e "${YELLOW}Auto-fixes on save${RESET}"
    echo

    echo -e "${ORANGE}Markdown (vim-markdown / vim-table-mode):${RESET}"
    echo -e "${MAGENTA}za / zo / zc${RESET} - Toggle/open/close fold under cursor"
    echo -e "${MAGENTA}zR / zM     ${RESET} - Open all folds / close all folds"
    echo -e "${MAGENTA}]] / [[     ${RESET} - Next/previous header (same or higher level)"
    echo -e "${MAGENTA}Space mt    ${RESET} - Table of contents (:Toc)"
    echo -e "${MAGENTA}Space mm    ${RESET} - Toggle table mode (auto-align | as you type)"
    echo -e "${MAGENTA}gqq / gqap  ${RESET} - Reflow current line/paragraph to 'textwidth'"
    echo -e "${MAGENTA}]s / [s / z=${RESET} - Next/previous misspelling / suggest fix (spell is on)"
    echo

    # Git
    echo -e "${ORANGE}Git (Optional):${RESET}"
    echo -e "${MAGENTA}:Git status ${RESET}- Show git status"
    echo -e "${MAGENTA}:Git diff   ${RESET}- Show changes"
    echo -e "${MAGENTA}:Git add %  ${RESET}- Stage current file"
    echo -e "${MAGENTA}:Git commit ${RESET}- Commit"
    echo -e "${MAGENTA}]c / [c     ${RESET}- Jump to next/prev git change"
    echo

    # Tips
    echo -e "${ORANGE}Useful Commands:${RESET}"
    echo -e "${MAGENTA}Space ve    ${RESET}- Edit vimrc"
    echo -e "${MAGENTA}Space vr    ${RESET}- Reload vimrc"
    echo -e "${MAGENTA}:help <topic>${RESET}- Get help"
    echo -e "${MAGENTA}Ctrl z      ${RESET}- Suspend Vim (fg to return)"
    echo
}

# Tmux help
tmuxfo() {
    echo ""
    echo -e "${BLUE}Tmux Cheatsheet${RESET}\n"
    echo -e "${MAGENTA}Ctrl a${RESET}                  - Leader key"
    echo

    echo -e "${ORANGE}Session management${RESET}"
    echo -e "${MAGENTA}tmux new -s <name>${RESET} or ${MAGENTA}tn${RESET}                   - Create new session"
    echo -e "${MAGENTA}tmux new-session -A -s <name>${RESET} or ${MAGENTA}tns${RESET}       - Create session if not exists or attach"
    echo -e "${MAGENTA}tmux ls${RESET} or ${MAGENTA}tl${RESET}                             - List sessions"
    echo -e "${MAGENTA}tmux attach -t <name>${RESET} or ${MAGENTA}ta${RESET}                - Attach to session"
    echo -e "${MAGENTA}tmux switch -t <name>${RESET} or ${MAGENTA}ts${RESET}                - Switch to another session"
    echo -e "${MAGENTA}tmux rename-session -t <old> <new>${RESET} or ${MAGENTA}tres${RESET}  - Rename session"
    echo -e "${MAGENTA}tmux kill-session -t <name>${RESET} or ${MAGENTA}tks${RESET}         - Kill session"
    echo -e "${MAGENTA}tmux kill-server${RESET} or ${MAGENTA}tkss${RESET}                   - Kill tmux server"
    echo -e "${MAGENTA}Ctrl a \$${RESET}                  - Rename current session"
    echo -e "${MAGENTA}Ctrl a d${RESET}                  - Detach from session"
    echo -e "${MAGENTA}Ctrl a s${RESET}                  - List and select sessions"
    echo -e "${MAGENTA}Ctrl a Ctrl t${RESET}             - Choose session from tree"
    echo

    echo -e "${ORANGE}Window management${RESET}"
    echo -e "${MAGENTA}Ctrl a c${RESET}                  - Create new window"
    echo -e "${MAGENTA}Ctrl a x${RESET}                  - Close current window"
    echo -e "${MAGENTA}Ctrl a n${RESET} or ${MAGENTA}Alt n${RESET}         - Next window"
    echo -e "${MAGENTA}Ctrl a p${RESET} or ${MAGENTA}Alt p${RESET}         - Previous window"
    echo -e "${MAGENTA}Ctrl a w${RESET}                  - List windows"
    echo -e "${MAGENTA}Ctrl a ,${RESET} or ${MAGENTA}trew${RESET}          - Rename current window"
    echo -e "${MAGENTA}Ctrl a m${RESET}             - Move window to specific index"
    echo -e "${MAGENTA}Alt 1-5${RESET}                 - Jump to window <1-9>"
    echo -e "${MAGENTA}tmux list-windows${RESET} or ${MAGENTA}tw${RESET}   - List windows"
    echo

    echo -e "${ORANGE}Pane creation and layout${RESET}"
    echo -e "${MAGENTA}Ctrl a |${RESET} or ${MAGENTA}Alt \\\\${RESET}         - Split vertically"
    echo -e "${MAGENTA}Ctrl a -${RESET} or ${MAGENTA}Alt -${RESET}         - Split horizontally"
    echo -e "${MAGENTA}Ctrl a space${RESET}              - Cycle through layouts"
    echo -e "${MAGENTA}Ctrl a =${RESET}                  - Equalize pane sizes"
    echo -e "${MAGENTA}Alt left/right/up/down arrow${RESET} - Move between panes"
    echo -e "${MAGENTA}Alt Shift H${RESET}                  - Swap pane with previous"
    echo -e "${MAGENTA}Alt Shift L${RESET}                  - Swap pane with next"
    echo

    echo -e "${ORANGE}Pane navigation${RESET}"
    echo -e "${MAGENTA}Alt left/right/up/down arrow${RESET} - Move between panes"
    echo -e "${MAGENTA}Ctrl a q${RESET}                     - Show pane numbers (press number to select)"
    echo -e "${MAGENTA}Ctrl a z${RESET}                     - Toggle pane zoom (fullscreen)"
    echo -e "${MAGENTA}Ctrl a {${RESET}                     - Swap pane with previous"
    echo -e "${MAGENTA}Ctrl a }${RESET}                     - Swap pane with next"
    echo -e "${MAGENTA}Ctrl a Ctrl s${RESET}                - Synchronize panes (send input to all panes)"
    echo

    echo -e "${ORANGE}Pane resizing${RESET}"
    echo -e "${MAGENTA}Alt Shift left arrow${RESET}      - Decrease width by 5"
    echo -e "${MAGENTA}Alt Shift right arrow${RESET}     - Increase width by 5"
    echo -e "${MAGENTA}Alt Shift down arrow${RESET}      - Decrease height by 2"
    echo -e "${MAGENTA}Alt Shift up arrow${RESET}        - Increase height by 2"
    echo

    echo -e "${ORANGE}Pane management${RESET}"
    echo -e "${MAGENTA}Ctrl a x${RESET}                  - Close current pane"
    echo -e "${MAGENTA}Ctrl a !${RESET}                  - Break pane into new window"
    echo

    echo -e "${ORANGE}Copy mode and clipboard${RESET}"
    echo -e "${MAGENTA}Ctrl a [${RESET}                  - Enter copy mode"
    echo -e "${MAGENTA}Ctrl c${RESET} or ${MAGENTA}q${RESET}               - Exit copy mode"
    echo -e "${MAGENTA}Space${RESET}                     - Start selection in copy mode"
    echo -e "${MAGENTA}Enter${RESET}                     - Copy selection in copy mode"
    echo -e "${MAGENTA}Ctrl a ]${RESET}                  - Paste copied text"
    echo -e "${MAGENTA}Shift + mouse drag${RESET}        - Highlight and copy text"
    echo -e "${MAGENTA}v${RESET}                         - Start selection in vi mode"
    echo -e "${MAGENTA}y${RESET}                         - Copy selection to system clipboard (tmux-yank)"
    echo -e "${MAGENTA}Y${RESET}                         - Copy current line to system clipboard (tmux-yank)"
    echo -e "${MAGENTA}Ctrl a y${RESET}                  - Copy current pane working directory"
    echo

    echo -e "${ORANGE}Configuration${RESET}"
    echo -e "${MAGENTA}Ctrl a r${RESET}                  - Reload tmux configuration file"
    echo -e "${MAGENTA}Ctrl a :${RESET}                  - Enter command mode"
    echo

    echo -e "${ORANGE}Plugin management - TPM${RESET}"
    echo -e "${MAGENTA}Ctrl a Ctrl I${RESET}             - Install plugins"
    echo -e "${MAGENTA}Ctrl a Ctrl u${RESET}             - Update plugins"
    echo -e "${MAGENTA}Ctrl a Alt u${RESET}              - Uninstall removed plugins"
    echo -e "${MAGENTA}Ctrl a S${RESET}             - Save tmux session (tmux-resurrect)"
    echo -e "${MAGENTA}Ctrl a Ctrl r${RESET}             - Restore tmux session (tmux-resurrect)"
    echo -e "${YELLOW}tmux-continuum auto-saves in the background and auto-restores the layout the next${RESET}"
    echo -e "${YELLOW}time you start tmux - no keybind needed, but it won't launch tmux for you after a reboot.${RESET}"
    echo

    echo -e "${ORANGE}Advanced session commands${RESET}"
    echo -e "${MAGENTA}tmux new-session -d -s <name>${RESET}         - Start a detached session"
    echo -e "${MAGENTA}tmux select-layout tiled${RESET} or ${MAGENTA}tslt${RESET}      - Tile all panes"


    echo
}

# VS Code help
vscfo() {
    echo ""
    echo -e "${BLUE}Visual Studio Code Cheatsheet:${RESET}"
    echo ""
    echo -e "${ORANGE}Navigation:${RESET}"
    echo -e "${MAGENTA}Ctrl p             ${RESET} - Quick Open - Rapidly find and open files"
    echo -e "${MAGENTA}Ctrl Shift p       ${RESET} - Open Command Palette"
    echo -e "${MAGENTA}Ctrl Shift ç       ${RESET} - Open Terminal"
    echo

    echo -e "${ORANGE}Editing:${RESET}"
    echo -e "${MAGENTA}Ctrl /             ${RESET}  - Toggle line comment"
    echo -e "${MAGENTA}Shift Alt a        ${RESET}  - Toggle block comment"
    echo -e "${MAGENTA}Shift Alt f        ${RESET}  - Format entire file"
    echo -e "${MAGENTA}Alt Up/Down        ${RESET}  - Move entire line or selected lines up or down"
    echo -e "${MAGENTA}Shift Alt Up/Down  ${RESET}  - Copy the current line or selection up or down"
    echo -e "${MAGENTA}Ctrl Shift k       ${RESET}  - Delete the current line"
    echo -e "${MAGENTA}Shift Alt Right/Left${RESET} - Expand or shrink the current selection"
    echo -e "${MAGENTA}Ctrl Shift l       ${RESET}  - Select all occurrences of current selection"
    echo

    echo -e "${ORANGE}Multi-cursor:${RESET}"
    echo -e "${MAGENTA}Ctrl d             ${RESET}                                             - Select next occurrence of current word"
    echo -e "${MAGENTA}Ctrl Shift l       ${RESET}                                             - Add cursors to all instances of the current selection"
    echo -e "${MAGENTA}Alt Click          ${RESET}                                             - Multi-cursor editing"
    echo -e "${MAGENTA}Ctrl Alt Up/Down   ${RESET}                                             - Add a cursor above or below the current line"
    echo -e "${MAGENTA}Shift Alt Drag     ${RESET}                                             - Column (block) selection"
    echo -e "${MAGENTA}editor.multiCursorModifier${RESET}                                      - Set to Ctrl+Click or Alt+Click for multi-cursor (see Selection menu)"
    echo -e "${MAGENTA}Press and Hold scrollwheel button and drag the mouse up or down${RESET} - Create a cursor on each line."
    echo

    echo -e "${ORANGE}Panels & Views:${RESET}"
    echo -e "${MAGENTA}Ctrl \`            ${RESET}  - Toggle integrated terminal"
    echo -e "${MAGENTA}Ctrl Shift x       ${RESET} - Open the Extensions panel"
    echo -e "${MAGENTA}Ctrl Shift g       ${RESET} - Open the Source Control panel"
    echo -e "${MAGENTA}Ctrl Shift m       ${RESET} - Open the Problems panel"
    echo

    echo -e "${ORANGE}Interface & Layout:${RESET}"
    echo -e "${MAGENTA}Ctrl k z           ${RESET} - Zen Mode (distraction-free)"
    echo -e "${MAGENTA}Ctrl \\             ${RESET} - Split the editor into two"
    echo -e "${MAGENTA}Ctrl b             ${RESET} - Show or hide the sidebar"
    echo

    echo -e "${ORANGE}Command Palette & Settings:${RESET}"
    echo -e "${MAGENTA}Ctrl Shift p       ${RESET} - Access all commands"
    echo -e "${MAGENTA}Ctrl k Ctrl s      ${RESET} - Open the keyboard shortcuts editor"
    echo -e "${MAGENTA}Ctrl ,             ${RESET} - Open the settings panel"
    echo

    echo -e "${ORANGE}Debugging:${RESET}"
    echo -e "${MAGENTA}F5                 ${RESET}   - Start or continue debugging"
    echo -e "${MAGENTA}Shift F5           ${RESET}   - Stop debugging"
    echo -e "${MAGENTA}F9                 ${RESET}   - Add or remove a breakpoint"
    echo -e "${MAGENTA}F10 / F11 / Shift F11${RESET} - Step over, into, or out during debugging"
    echo

    echo -e "${ORANGE}Productivity & Customization:${RESET}"
    echo -e "${MAGENTA}Shift Alt f        ${RESET} - Format the entire file"
    echo -e "${MAGENTA}Ctrl = / Ctrl -    ${RESET} - Increase/decrease editor font size"
    echo -e "${MAGENTA}Customize Shortcuts${RESET} - Open Keyboard Shortcuts editor (Ctrl k Ctrl s) or edit keybindings.json for advanced customization"
    echo

    echo -e "${ORANGE}Copilot:${RESET}"
    echo -e "${MAGENTA}Tab                ${RESET}      - Accepts the entire inline suggestion"
    echo -e "${MAGENTA}Alt + ]            ${RESET}      - Show next alternative inline suggestion"
    echo -e "${MAGENTA}Alt + [            ${RESET}      - Show previous alternative inline suggestion"
    echo -e "${MAGENTA}Ctrl + Right Arrow ${RESET}      - Accepts the next word of inline suggestion (partial accept)"
    echo -e "${MAGENTA}Ctrl + Alt + Right Arrow${RESET} - Accepts the next line of inline suggestion (partial accept)"
    echo -e "${MAGENTA}Esc                ${RESET}      - Dismisses the current inline suggestion"
    echo -e "${MAGENTA}Alt + \\           ${RESET}       - Forces Copilot to trigger an inline suggestion"
    echo -e "${MAGENTA}Ctrl + Enter       ${RESET}      - Opens the GitHub Copilot: Open Completions panel"
    echo -e "${MAGENTA}Ctrl + I           ${RESET}      - Starts Inline Chat"
    echo -e "${MAGENTA}Ctrl + Alt + I     ${RESET}      - Opens the dedicated Copilot Chat view"
    echo

    echo -e "${ORANGE}Other:${RESET}"
    echo -e "${MAGENTA}Ctrl k v           ${RESET} - Preview Markdown"
    echo -e "${MAGENTA}Windows key .      ${RESET} - Open emoji picker"
	echo -e "${MAGENTA}Ctrl k 1           ${RESET} - Add markdown bash code block"
	echo -e "${MAGENTA}Ctrl k 2           ${RESET} - Add markdown bash code block with output"
    echo
}

