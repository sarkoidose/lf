#!/bin/zsh

# =======================================================
# LF PREVIEWER - FINAL VERSION (ASUS)
# =======================================================

file="$1"
w="$2"
h="$3"

# Détection du type de fichier via MIME
mimetype=$(file --mime-type -b "$file")

case "$mimetype" in
    # --- IMAGES ---
    image/*)
        # --speed 9 : Rendu ultra-rapide pour éviter le timeout
        # --polite on : Nettoyage propre du flux Sixel
        chafa -f sixel --size "${w}x${h}" --speed 9 --animate false --polite on "$file"
        exit 1
        ;;

    # --- PDF ---
    application/pdf)
        pdftoppm -f 1 -l 1 -scale-to 800 -jpeg -singlefile "$file" /tmp/lf-pdf
        chafa -f sixel --size "${w}x${h}" --speed 9 --polite on /tmp/lf-pdf.jpg
        rm -f /tmp/lf-pdf.jpg
        exit 1
        ;;

    # --- TEXTE / CODE ---
    text/*|application/json|application/javascript|*+xml)
        bat --color=always --style=plain --terminal-width="$w" "$file" 2>/dev/null || cat "$file"
        exit 0
        ;;

    # --- PAR DÉFAUT ---
    *)
        bat --color=always --style=plain --terminal-width="$w" "$file" 2>/dev/null || file -b "$file"
        exit 0
        ;;
esac
