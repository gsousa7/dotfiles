# Custom functions
field() {
    awk -F "${2:- }" "{ print \$${1:-1} }"
}

tempo() {
    curl -s "wttr.in/${1}?format=4"
}

tempof() {
    curl -s "wttr.in/${1}"
}

dsk() {
    if [ -d "/mnt/$1" ]; then
        cd "/mnt/$1" || return
    else
        echo "Drive /mnt/$1 not found."
    fi
}

explain() {
    if [ "$#" -eq 0 ]; then
        while read -p "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

lintsh() {
  shellcheck "$1"
}

fmtsh() {
  shfmt -i 2 -sr -ci -w "$1"
}

epoch() {
    local num=${1:--1}
    printf '%(%B %d, %Y %-I:%M:%S %p %Z)T\n' "$num"
}

rgs() {
  git diff --cached --name-only -z | rg --files0-from=- -- "$@"
}

ex() {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

gif() {
    if [ $# -lt 2 ]; then
        echo "Usage: gif <input.mp4> <output.gif> [options]"
        echo "Options: small, hq, fast (padrão: default)"
        return 1
    fi

    case "$3" in
        "small")
            ffmpeg -i "$1" -vf "fps=8,scale=240:-1:flags=lanczos" -c:v gif "$2"
            ;;
        "hq")
            ffmpeg -i "$1" -vf "fps=15,scale=480:-1:flags=lanczos,palettegen" /tmp/palette.png
            ffmpeg -i "$1" -i /tmp/palette.png -vf "fps=15,scale=480:-1:flags=lanczos,paletteuse" "$2"
            rm /tmp/palette.png
            ;;
        "fast")
            ffmpeg -i "$1" -vf "fps=20,scale=400:-1:flags=lanczos" -c:v gif "$2"
            ;;
        *)
            ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos" -c:v gif "$2"
            ;;
    esac
}


# Render a folder of Markdown notes into a single-file, offline HTML "book"
# (sidebar TOC, mermaid diagrams, click-to-zoom images). Usage: mkbook <repo-folder>
alias mkbook='$HOME/scripts/.venv/bin/python3 $HOME/scripts/md_book.py'

# Check notes repos for markdown that breaks `mkbook` (fenced code inside a
# blockquote, a list with no blank line before it, trailing backslashes, two
# H1s in one file, <img> tags) or breaks on GitHub (dead links, missing
# images, root-relative /assets paths), plus lessons missing from a README.
# No args checks every repo under ~/git; ~/git/archived is skipped unless
# named. Exits non-zero when it finds something, so it works in a hook.
# Usage: booklint [repo|path ...] [-q] [--no-toc]
alias booklint='$HOME/scripts/.venv/bin/python3 $HOME/scripts/booklint.py'

# One-time/idempotent bootstrap for `mkbook`: creates its venv, installs the
# `markdown` dependency, and pre-caches mermaid.js.
mkbook-setup() {
  local venv="$HOME/scripts/.venv"
  if [ ! -d "$venv" ]; then
    echo "Creating venv at $venv..."
    python3 -m venv "$venv" || return 1
  fi
  if ! "$venv/bin/python3" -c "import markdown" 2>/dev/null; then
    echo "Installing markdown into $venv..."
    "$venv/bin/pip" install --quiet markdown || return 1
  fi
  mkdir -p "$HOME/.cache/md_book"
  if [ ! -f "$HOME/.cache/md_book/mermaid.min.js" ]; then
    echo "Pre-caching mermaid.js (one-time, ~3MB)..."
    curl -fsSL "https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js" \
      -o "$HOME/.cache/md_book/mermaid.min.js" \
      || echo "  couldn't reach the CDN now -- it will just download on the first real 'mkbook' run instead."
  fi
  echo "Environment ready. Try: mkbook <repo-folder>"
}

# Scaffold a new notes repo under ~/git in the src/NN-chapter/NN-lesson.md
# convention. Every arg after the name becomes a numbered chapter
# (default: "introduction"), pre-seeded with src/NN-<chapter>/01-intro.md and
# assets/NN-<chapter>/. Also git-inits the repo.
# Usage: mknotes <name> [chapter1] [chapter2] ...
mknotes() {
  if [ -z "$1" ]; then
    echo "usage: mknotes <name> [chapter1] [chapter2] ..."
    echo "  e.g. mknotes learn-vault"
    echo "       mknotes learn-vault secrets-engines dynamic-secrets policies"
    return 1
  fi
  local name="$1"
  shift
  local chapters=("$@")
  [ ${#chapters[@]} -eq 0 ] && chapters=("introduction")
  local dir="$HOME/git/$name"

  if [ -e "$dir" ]; then
    echo "already exists: $dir" >&2
    return 1
  fi

  local title
  title=$(echo "$name" | sed -E 's/^learn-//; s/[-_]+/ /g; s/(^| )([a-z])/\1\U\2/g')

  local toc="# $title

## Table of Contents
"

  local i=1
  local chapter chapter_title num
  for chapter in "${chapters[@]}"; do
    num=$(printf "%02d" "$i")
    chapter_title=$(echo "$chapter" | sed -E 's/[-_]+/ /g; s/(^| )([a-z])/\1\U\2/g')

    mkdir -p "$dir/src/$num-$chapter" "$dir/assets/$num-$chapter"

    cat > "$dir/src/$num-$chapter/01-intro.md" <<MD
# Introduction

MD

    toc="$toc
### $i. $chapter_title
1. [Introduction](src/$num-$chapter/01-intro.md)
"

    i=$((i + 1))
  done

  echo "$toc" > "$dir/README.md"

  git -C "$dir" init -q

  echo "Created $dir"
  echo "  README.md"
  i=1
  for chapter in "${chapters[@]}"; do
    num=$(printf "%02d" "$i")
    echo "  src/$num-$chapter/01-intro.md"
    echo "  assets/$num-$chapter/  (empty, mirrors src/)"
    i=$((i + 1))
  done
  echo
  echo "Next chapter: mkdir -p \"$dir/src/$(printf "%02d" $i)-<name>\" \"$dir/assets/$(printf "%02d" $i)-<name>\""
}
