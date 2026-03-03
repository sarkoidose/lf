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

## Dependencies

### Core
- `lf` - File manager
- `fzf` - Fuzzy finder (for `f` keybinding)
- `trash-cli` - Safe deletion (for `D` keybinding)

### Preview & Display
- `chafa` - Image to Sixel conversion
- `bat` - Syntax highlighting for text
- `poppler` - PDF utilities (includes `pdftoppm`)
- `wl-clipboard` - Wayland clipboard (for `Y` keybinding)

### Archive Tools
- `p7zip` - 7z support (includes `7z`)
- `unrar` - RAR extraction
- Plus built-in: `tar`, `gzip`, `bzip2`, `unzip`

### Optional
- `gnosis-diff` - Advanced file comparison (for `gd` keybinding)

## Verify Installation

Check which dependencies are installed:

```bash
for cmd in lf fzf trash-put chafa bat wl-copy pdftoppm 7z unrar; do
    command -v "$cmd" >/dev/null && echo "✓ $cmd" || echo "✗ $cmd missing"
done
```

Missing tools will show errors when used, but won't break lf.

## Configuration

### Gnosis-Diff Path

If your `gnosis-diff` installation is at a different location, set the environment variable:

```bash
export GNOSIS_DIFF=/path/to/gnosis_diff.py
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

### Images not previewing
Missing `chafa`. Install it and restart lf.

### Code not syntax-highlighted
Missing `bat`. Install it and restart lf.

### Clipboard copy (`Y`) fails
Missing `wl-copy` (Wayland). On X11, use `xclip` or `xsel` instead.

### Archives won't extract
Missing archive tools (`7z`, `unrar`, etc.). Install the required tool for your archive format.

### PDFs not previewing
Missing `pdftoppm` (usually comes with `poppler`). Install it.

All missing dependencies will show error messages in lf when you try to use them.

---

*Maintained by sarkoidose.*
