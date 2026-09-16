# List starship palettes and set one
pcolor() {
    if [ "$(readlink ~/.config/starship.toml)" != "$HOME/dotfiles/starship_full.toml" ]; then
        echo "Palette can only be changed when the full Starship configuration is active."
        return 1
    fi

    echo "Available starship palettes:"
    echo "1) gruvbox_dark"
    echo "2) nord"
    echo "3) nord inverted"
    echo "4) dracula"
    echo "5) solarized_dark"
    echo "6) solarized_light"
    echo "7) catppuccin_mocha"
    echo "8) guezwhoz"

    read -p "Enter the number of the palette you want to use: " choice

    local palette=""
    case $choice in
        1) palette="gruvbox_dark" ;;
        2) palette="nord" ;;
        3) palette="nord_inverted" ;;
        4) palette="dracula" ;;
        5) palette="solarized_dark" ;;
        6) palette="solarized_light" ;;
        7) palette="catppuccin_mocha" ;;
        8) palette="guezwhoz" ;;
        *)
            echo "Invalid choice. Exiting."
            return 1
            ;;
    esac

    starship config palette "$palette"
    echo "Starship palette updated to $palette. Restart your terminal to see the changes."
}


eskin() {
    echo "Available eza themes:"
    echo "1) default"
    echo "2) gruvbox-dark"
    echo "3) dracula"
    echo "4) solarized-dark"
    echo "5) solarized-light"
    echo "6) black"
    echo "7) catppuccin"
    echo "8) frosty"
    echo "9) gruvbox-light"
    echo "10) one_dark"
    echo "11) rose-pine-dawn"
    echo "12) rose-pine-moon"
    echo "13) rose-pine"
    echo "14) tokyonight"
    echo "15) white"

    read -p "Enter the number of the theme you want to use: " choice

    local theme_file=""
    case $choice in
        1) theme_file="default.yml" ;;
        2) theme_file="gruvbox-dark.yml" ;;
        3) theme_file="dracula.yml" ;;
        4) theme_file="solarized-dark.yml" ;;
        5) theme_file="solarized-light.yml" ;;
        6) theme_file="black.yml" ;;
        7) theme_file="catppuccin.yml" ;;
        8) theme_file="frosty.yml" ;;
        9) theme_file="gruvbox-light.yml" ;;
        10) theme_file="one_dark.yml" ;;
        11) theme_file="rose-pine-dawn.yml" ;;
        12) theme_file="rose-pine-moon.yml" ;;
        13) theme_file="rose-pine.yml" ;;
        14) theme_file="tokyonight.yml" ;;
        15) theme_file="white.yml" ;;
        *)
            echo "Invalid choice. Exiting."
            return 1
            ;;
    esac

    ln -sf "$HOME/.config/eza/assets/themes/$theme_file" ~/.config/eza/theme.yml
    echo "Eza theme updated to $theme_file."
}


ffblur() {
  local REPO_URL="https://github.com/datguypiko/Firefox-Mod-Blur.git"
  local REPO_DIR="$HOME/Firefox-Mod-Blur"
  local PROFILE_DIR="/mnt/c/Users/Gonçalo Sousa/AppData/Roaming/Mozilla/Firefox/Profiles/dthrxw1f.default-release-1768090321784"
  local CHROME_DIR="$PROFILE_DIR/chrome"

  if [ ! -d "$PROFILE_DIR" ]; then
    echo "ffblur: Profile not found -> $PROFILE_DIR" >&2
    return 1
  fi

  if [ -d "$REPO_DIR/.git" ]; then
    echo "==> Update local repo..."
    git -C "$REPO_DIR" fetch --depth 1 origin master || return 1
    git -C "$REPO_DIR" reset --hard FETCH_HEAD || return 1
  else
    echo "==> Cloning repo (first time)..."
    git clone --depth 1 "$REPO_URL" "$REPO_DIR" || return 1
  fi

  mkdir -p "$CHROME_DIR"
  echo "==> Copy to: $CHROME_DIR"
  cp -f "$REPO_DIR/userChrome.css"  "$CHROME_DIR/" || return 1
  cp -f "$REPO_DIR/userContent.css" "$CHROME_DIR/" || return 1
  rm -rf "$CHROME_DIR/ASSETS"
  cp -r "$REPO_DIR/ASSETS" "$CHROME_DIR/ASSETS" || return 1

  echo "==> Finished. Restart Firefox to apply changes"
}

function hl() {
  # If input is being piped to the function (e.g., lsblk | hl)
  if [ -p /dev/stdin ]; then
    # Process the piped input. Use 'batcat' since your system uses it.
    batcat -l conf -p
  # If a command is provided as an argument (e.g., hl lsblk)
  else
    # Execute the command and pipe its output to batcat
    "$@" | batcat -l conf -p
  fi
}
