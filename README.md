# 📁 lf-config

> A minimalist, high-performance configuration for the **lf** terminal file manager.

![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)
![Stars](https://img.shields.io/github/stars/sarkoidose/lf?style=flat-square)
![Language](https://img.shields.io/github/languages/top/sarkoidose/lf?style=flat-square)

---

## ✨ Features

- 🖼️ **Image Previews**: Ultra-fast Sixel rendering using `chafa`.
- 🔍 **Gnosis-Diff**: Built-in TUI diff tool for comparing files (`gd`).
- 📄 **PDF Support**: Quick preview of PDF documents.
- 🌈 **Syntax Highlighting**: Beautiful code previews with `bat`.
- 📦 **One-Key Archive**: Extract almost any archive format with `X`.
- 📋 **Clipboard Integration**: Copy full file paths instantly with `Y`.
- 🗑️ **Safe Trash**: Integration with `trash-put` (D) to avoid accidental loss.
- 🚀 **Fast Creation**: Create folders (`n`) and files (`N`) on the fly.

## ⌨️ Keybindings

| Key | Action |
| :--- | :--- |
| `n` | Create a new directory |
| `N` | Create a new file |
| `X` | Extract archive (zip, tar, 7z, rar, etc.) |
| `Y` | Copy full path to clipboard (`wl-copy`) |
| `o` | Open with system default (`xdg-open`) |
| `D` | Move to trash |
| `gd` | Compare marked file with current file (**Gnosis-Diff**) |
| `e` | Edit with `$EDITOR` |
| `.` | Toggle hidden files |

## 🛠️ Installation

```bash
# Clone the repo
git clone https://github.com/sarkoidose/lf.git ~/.config/lf

# Ensure preview scripts are executable
chmod +x ~/.config/lf/*.sh
```

### Dependencies
To get the most out of this config, install:
- `chafa` (for images)
- `bat` (for code preview)
- `wl-copy` (for clipboard)
- `trash-cli` (for the trash command)
- `poppler` (for `pdftoppm`)
- `fzf` (for search)

---
*Generated with ❤️ for a minimalist workflow.*
