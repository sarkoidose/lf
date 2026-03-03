#!/usr/bin/env zsh

# LF PREVIEWER - ENHANCED VERSION WITH ERROR HANDLING

file="$1"
w="$2"
h="$3"

# Check if command exists
check_cmd() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: '$1' not found. Install it to enable previews."
        return 1
    fi
    return 0
}

# Detect file type via MIME
mimetype=$(file --mime-type -b "$file")

case "$mimetype" in
    # Images
    image/*)
        check_cmd chafa || exit 0
        chafa -f sixel --size "${w}x${h}" --speed 9 --animate false --polite on "$file"
        exit 1
        ;;

    # PDF
    application/pdf)
        check_cmd pdftoppm || exit 0
        check_cmd chafa || exit 0
        pdftoppm -f 1 -l 1 -scale-to 800 -jpeg -singlefile "$file" /tmp/lf-pdf
        chafa -f sixel --size "${w}x${h}" --speed 9 --polite on /tmp/lf-pdf.jpg
        rm -f /tmp/lf-pdf.jpg
        exit 1
        ;;

    # Archives
    application/zip|application/x-tar|application/x-7z-compressed|application/x-rar|application/x-gzip)
        7z l "$file" 2>/dev/null || tar -tf "$file"
        exit 0
        ;;

    # Text and code
    text/*|application/json|application/javascript|*+xml)
        if check_cmd bat 2>/dev/null; then
            bat --color=always --style=plain --terminal-width="$w" "$file" 2>/dev/null
        else
            cat "$file"
        fi
        exit 0
        ;;

    # Default
    *)
        if check_cmd bat 2>/dev/null; then
            bat --color=always --style=plain --terminal-width="$w" "$file" 2>/dev/null
        else
            file -b "$file"
        fi
        exit 0
        ;;
esac
