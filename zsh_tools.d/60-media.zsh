# youtube-dl functions
_getyt_mp3() {
    local output="$1" url="$2"
    yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --output "${DESKTOPWINSL}Desktop/$output" "$url"
}

_getyt_mp4() {
    local output="$1" url="$2"; shift 2
    yt-dlp -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=1080]+bestaudio/best[height<=1080]/best' \
           --merge-output-format mp4 "$@" \
           --output "${DESKTOPWINSL}Desktop/$output" "$url"
}

## Get mp3 file of youtube
getyt() {
    _getyt_mp3 "%(title)s.%(ext)s" "$1"
}

## Get mp4 file of youtube
getytmp4() {
    _getyt_mp4 "%(title)s.%(ext)s" "$1"
}

## Get mp3 file of youtube playlist
getytplist() {
    _getyt_mp3 "%(playlist_title)s/%(title)s.%(ext)s" "$1"
}

## Get mp4 file of youtube playlist
getytplistmp4() {
    _getyt_mp4 "%(playlist_title)s/%(title)s.%(ext)s" "$1"
}

## Get mp4 file of youtube with subs
getytmp4subs() {
    _getyt_mp4 "%(title)s.%(ext)s" "$1" --write-subs --embed-subs --sub-langs "en,pt,es" --sub-format "srt/vtt/best"
}

## Get mp4 file of youtube playlist with subs
getytplistmp4subs() {
    _getyt_mp4 "%(playlist_title)s/%(title)s.%(ext)s" "$1" --write-subs --embed-subs --sub-langs "en,pt,es" --sub-format "srt/vtt/best"
}

## Debug function - check available formats
getytformats() {
    echo "Available formats for: $1"
    yt-dlp --list-formats "$1"
}

## Flexible download function with options
getytflex() {
    local url="$1"
    local format="$2"
    local quality="$3"

    case "$format" in
        "mp3"|"audio")
            _getyt_mp3 "%(title)s.%(ext)s" "$url"
            ;;
        "mp4"|"video")
            local height=1080
            case "$quality" in
                "4k"|"2160") height=2160 ;;
                "1440"|"2k") height=1440 ;;
                "720") height=720 ;;
            esac
            yt-dlp -f "bestvideo[height<=$height]+bestaudio/best[height<=$height]/best" \
                   --merge-output-format mp4 \
                   --output "${DESKTOPWINSL}Desktop/%(title)s.%(ext)s" "$url"
            ;;
        *)
            echo "Usage: getytflex <url> <format> [quality]"
            echo "Format: mp3|audio|mp4|video"
            echo "Quality (for video): 720|1080|1440|4k"
            echo "Example: getytflex 'https://youtu.be/...' mp4 1080"
            ;;
    esac
}

# spotify functions
_getspot() {
    spotdl --output "${DESKTOPWINSL}Desktop/$1" --format mp3 --bitrate 320k "$2"
}

## Get Spotify track
getspot() {
    _getspot "{artist} - {title}" "$1"
}

## Get Spotify album
getalb() {
    _getspot "{artist} - {album}/{artist} - {title}" "$1"
}

# Get Spotify playlist
getplay() {
    _getspot "{playlist}/{artist} - {title}" "$1"
}

