# lf-config

> A minimalist, high-performance configuration for the **lf** terminal file manager with enhanced error handling.

![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)
![Stars](https://img.shields.io/github/stars/sarkoidose/lf?style=flat-square)
![Language](https://img.shields.io/github/languages/top/sarkoidose/lf?style=flat-square)

---

## Features

- **Image Previews**: Ultra-fast Sixel rendering using `chafa`.
- **Gnosis-Diff**: Built-in TUI diff tool for comparing files (`gd`).
- **PDF Support**: Quick preview of PDF documents.
- **Syntax Highlighting**: Code previews with `bat`.
- **Archive Management**: List and extract multiple archive formats (zip, tar, 7z, rar).
- **Clipboard Integration**: Copy full file paths to system clipboard.
- **Safe Trash**: Integration with `trash-put` to avoid accidental loss.
- **Quick Creation**: Create folders and files with error feedback.
- **Robust Error Handling**: Clear error messages when dependencies are missing.

## Keybindings

| Key | Action |
| :--- | :--- |
| `n` | Create a new directory |
| `N` | Create a new file |
| `X` | Extract archive |
| `Y` | Copy full path to clipboard |
| `o` | Open with system default |
| `D` | Move to trash |
| `gd` | Compare marked file with current file (**Gnosis-Diff**) |
| `e` | Edit with `$EDITOR` |
| `.` | Toggle hidden files |
| `f` | Jump to file/folder (**fzf**) |

## Installation

```bash
# Clone the repo
git clone https://github.com/sarkoidose/lf.git ~/.config/lf

# Ensure preview scripts are executable
chmod +x ~/.config/lf/*.sh
```

### Dependencies

Install these for full functionality:

```bash
# Required
sudo pacman -S lf fzf trash-cli  # or apt/brew/etc

# Optional (for previews)
sudo pacman -S chafa bat poppler wl-clipboard unrar p7zip
```

### Verify Installation

```bash
# Check all dependencies
for cmd in lf fzf trash-put chafa bat wl-copy pdftoppm 7z unzip; do
    command -v "$cmd" >/dev/null && echo "✓ $cmd" || echo "✗ $cmd missing"
done
```

## Configuration

### Gnosis-Diff Path

If your `gnosis-diff` installation is at a different location, set the environment variable:

```bash
export GNOSIS_DIFF=/path/to/gnosis_diff.py
# Then launch lf
lf
```

Or edit the path directly in `lfrc`:

```sh
cmd gdiff ${
    GNOSIS_DIFF="$HOME/your/custom/path/gnosis_diff.py"
    # ... rest of command
}
```

## Troubleshooting

### Missing `chafa` → images not previewed
Install: `sudo pacman -S chafa` (or equivalent for your OS)

### Missing `bat` → code not syntax-highlighted
Install: `sudo pacman -S bat` (or equivalent for your OS)

### `wl-copy` not found → clipboard copy fails
Install: `sudo pacman -S wl-clipboard` (Wayland) or `xclip` (X11)

All errors will be reported in lf's message bar when you try to use a feature with missing dependencies.

---

*Maintained by sarkoidose.*
