#!/usr/bin/env zsh

# =======================================================
# LF PREVIEWER - FINAL VERSION (ASUS)
# =======================================================

file="$1"
w="$2"
h="$3"

# Extension en minuscules (zsh: :e = extension, :l = lowercase)
ext="${file:e:l}"

# Helper: afficher une image avec chafa + redimensionnement si nécessaire
preview_image() {
    local img="$1"
    local tmpimg=""

    # Redimensionner à la volée pour éviter les timeouts sur les grandes images
    if command -v convert &>/dev/null; then
        tmpimg="/tmp/lf_preview_$$.jpg"
        if ! convert "$img" -resize 800x800\> "$tmpimg" 2>/dev/null; then
            rm -f "$tmpimg"
            tmpimg=""
        fi
    fi

    chafa -f sixel --size "${w}x${h}" --speed 9 --animate false --polite on "${tmpimg:-$img}"
    [[ -n "$tmpimg" ]] && rm -f "$tmpimg"
}

# Détection par extension pour les formats mal reconnus par file --mime-type
case "$ext" in
    # Formats RAW (non reconnus comme image/* par file)
    cr2|nef|arw|dng|orf|rw2|raf|pef)
        tmpraw="/tmp/lf_raw_$$.jpg"
        if command -v dcraw &>/dev/null; then
            dcraw -c -e "$file" > "$tmpraw" 2>/dev/null && preview_image "$tmpraw"
        elif command -v rawtherapee-cli &>/dev/null; then
            rawtherapee-cli -o "$tmpraw" -c "$file" 2>/dev/null && preview_image "$tmpraw"
        else
            echo "Aperçu RAW non disponible (installer dcraw ou rawtherapee)"
            file -b "$file"
        fi
        rm -f "$tmpraw"
        exit 1
        ;;

    # Formats HEIC/HEIF (support variable selon la version de libmagic)
    heic|heif)
        tmpheic="/tmp/lf_heic_$$.jpg"
        if command -v heif-convert &>/dev/null; then
            heif-convert "$file" "$tmpheic" 2>/dev/null && preview_image "$tmpheic"
        elif command -v convert &>/dev/null; then
            convert "$file" "$tmpheic" 2>/dev/null && preview_image "$tmpheic"
        else
            echo "Aperçu HEIC non disponible (installer libheif-examples ou imagemagick)"
            file -b "$file"
        fi
        rm -f "$tmpheic"
        exit 1
        ;;
esac

# Détection du type de fichier via MIME
mimetype=$(file --mime-type -b "$file")

case "$mimetype" in
    # --- IMAGES ---
    image/*)
        # Redimensionnement automatique + rendu Sixel
        preview_image "$file"
        exit 1
        ;;

    # --- PDF ---
    application/pdf)
        pdftoppm -f 1 -l 1 -scale-to 800 -jpeg -singlefile "$file" /tmp/lf-pdf
        chafa -f sixel --size "${w}x${h}" --speed 9 --polite on /tmp/lf-pdf.jpg
        rm -f /tmp/lf-pdf.jpg
        exit 1
        ;;

    # --- ARCHIVES ---
    application/zip|application/x-tar|application/x-7z-compressed|application/x-rar|application/x-gzip)
        7z l "$file" 2>/dev/null || tar -tf "$file"
        exit 0
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
