#!/usr/bin/env zsh

# LF PREVIEWER - REFACTORED FOR RELIABILITY

file="$1"
w="$2"
h="$3"

# Setup cleanup trap for temp files
cleanup() {
    rm -f /tmp/lf-pdf-*.jpg
}
trap cleanup EXIT

# Check if command exists
check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: '$1' not found. Install it to enable previews."
        return 1
    fi
    return 0
}

# Display text with fallback
display_text() {
    local fallback="$1"
    if check_cmd bat 2>/dev/null; then
        bat --color=always --style=plain --terminal-width="$w" "$file" 2>/dev/null
    else
        eval "$fallback"
    fi
}

# Get MIME type
mimetype=$(file --mime-type -b "$file")

case "$mimetype" in
    # Images
    image/*)
        check_cmd chafa || exit 0
        timeout 5 chafa -f symbols --size "${w}x${h}" --animate false "$file"
        exit 0
        ;;

    # PDF
    application/pdf)
        check_cmd pdftoppm chafa || exit 0
        tmpfile="/tmp/lf-pdf-$$.jpg"
        if timeout 5 pdftoppm -f 1 -l 1 -scale-to 800 -jpeg -singlefile "$file" "${tmpfile%.*}" 2>/dev/null; then
            timeout 5 chafa -f sixel --size "${w}x${h}" --speed 9 --polite on "$tmpfile"
        fi
        exit 0
        ;;

    # Archives
    application/zip|application/x-tar|application/x-7z-compressed|application/x-rar|application/x-gzip)
        if check_cmd 7z 2>/dev/null; then
            7z l "$file" 2>/dev/null && exit 0
        fi
        if check_cmd tar 2>/dev/null; then
            tar -tf "$file" 2>/dev/null && exit 0
        fi
        echo "Error: No archive tool available"
        exit 1
        ;;

    # Text and code
    text/*|application/json|application/javascript|*+xml)
        display_text "cat \"\$file\""
        exit 0
        ;;

    # Default
    *)
        display_text "file -b \"\$file\""
        exit 0
        ;;
esac
