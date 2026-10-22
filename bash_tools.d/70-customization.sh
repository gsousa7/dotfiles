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
  local REPO_DIR
  local PROFILE_DIR="/mnt/c/Users/Gonçalo Sousa/AppData/Roaming/Mozilla/Firefox/Profiles/dthrxw1f.default-release-1768090321784"
  local CHROME_DIR="$PROFILE_DIR/chrome"

  if [ ! -d "$PROFILE_DIR" ]; then
    echo "ffblur: Profile not found -> $PROFILE_DIR" >&2
    return 1
  fi

  REPO_DIR="$(mktemp -d /tmp/Firefox-Mod-Blur.XXXXXX)" || return 1

  echo "==> Cloning repo to $REPO_DIR..."
  if ! git clone --depth 1 "$REPO_URL" "$REPO_DIR"; then
    rm -rf "$REPO_DIR"
    return 1
  fi

  mkdir -p "$CHROME_DIR"
  echo "==> Copy to: $CHROME_DIR"
  if ! { cp -f "$REPO_DIR/userChrome.css" "$CHROME_DIR/" \
      && cp -f "$REPO_DIR/userContent.css" "$CHROME_DIR/" \
      && rm -rf "$CHROME_DIR/ASSETS" \
      && cp -r "$REPO_DIR/ASSETS" "$CHROME_DIR/ASSETS"; }; then
    rm -rf "$REPO_DIR"
    return 1
  fi

  rm -rf "$REPO_DIR"
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
