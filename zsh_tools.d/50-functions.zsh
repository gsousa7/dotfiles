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
        while read "cmd?Command: "; do
            curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols=$(tput cols)" --data-urlencode "q=$1"
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

# NOTE: bash's epoch() uses printf's '%()T' date extension, which zsh doesn't
# have - use the 'date' command instead (GNU date, matching this repo's
# Debian/RHEL/WSL targets).
epoch() {
    local num=${1:--1}
    if [ "$num" = "-1" ]; then
        date '+%B %d, %Y %-I:%M:%S %p %Z'
    else
        date -d "@$num" '+%B %d, %Y %-I:%M:%S %p %Z'
    fi
}

rgs() {
  git diff --cached --name-only -z | rg --files0-from=- -- "$@"
}

ex() {
 if [ -z "$1" ]; then
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
