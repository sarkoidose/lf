# lf-config

> A minimalist, high-performance configuration for the **lf** terminal file manager.

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
- **Quick Creation**: Create folders and files on the fly.

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
- `chafa` (images)
- `bat` (syntax)
- `wl-copy` (clipboard)
- `trash-cli` (trash)
- `poppler` (pdf)
- `fzf` (search)

---
*Maintained by sarkoidose.*
