# NvChad Config

My personal NvChad setup for C, C++, and Python development.

## What's inside

- **Completion** — blink.cmp (faster than nvim-cmp)
- **LSP** — clangd (C/C++), pyright (Python), managed by Mason
- **Formatter** — clang-format, ruff (format on save)
- **Linter** — clang-tidy (C/C++), ruff (Python) via nvim-lint
- **Debugger** — nvim-dap with codelldb and debugpy
- **File explorer** — nvim-tree
- **Fuzzy finder** — Telescope with fzf-native
- **Terminal** — toggleterm, lazygit integration
- **Testing** — neotest with Python support
- **Other** — gitsigns, trouble, noice, flash, persistence, and more

See the full list in [lua/plugins/init.lua](lua/plugins/init.lua).

## Prerequisites

Make sure you have these installed first:

- **Neovim** >= 0.10
- **Git**
- **A Nerd Font** (I use JetBrainsMono Nerd Font) — needed for icons
- **C/C++ toolchain** — gcc, g++, gdb, make
- **Python 3 + pip** — for Python LSP and debugging
- **clangd and clang-format** — some distros have them in a package called `clang-tools-extra`
- **lazygit** (optional) — for the lazygit integration

## Install

### One-liner (automated)

This does everything — backs up your current config, clones the repo, installs plugins and LSP servers:

```bash
bash <(curl -s https://raw.githubusercontent.com/1cz1/nvchad-config/main/install.sh)
```

### Step by step (manual)

**1. Back up your current config (if you have one)**

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

**2. Clone this repo**

```bash
git clone https://github.com/1cz1/nvchad-config ~/.config/nvim
```

**3. Install the plugins**

Open Neovim:

```bash
nvim
```

Lazy.nvim will install automatically. Wait for it to finish, then run:

```
:Lazy sync
```

**4. Install LSP servers and tools**

```
:MasonInstallAll
```

This installs clangd, pyright, ruff, codelldb, debugpy, cpplint, and clang-format.

**5. Set your Nerd Font**

Make sure your terminal uses a Nerd Font (like JetBrainsMono Nerd Font). Otherwise icons will look broken.

**6. Done**

Restart Neovim and you're all set.

## First time setup (optional)

- Run `:checkhealth` to check for any issues
- If you use Discord, `presence.nvim` will show your status automatically
- Your sessions are saved automatically with `persistence.nvim`

## Keybindings

| Key | Action |
|---|---|
| `Space` | Leader key |
| `;` | Enter command mode |
| `jk` | Escape insert mode |
| `Space + ff` | Find files (Telescope) |
| `Space + fg` | Live grep (Telescope) |
| `Space + e` | Toggle file explorer |
| `Space + t` | Toggle terminal |
| `Space + o` | Toggle outline |
| `Space + sh` | Switch C/C++ source/header |
| `F8` | Compile and run (C/C++) or open Overseer |
| `gr` | LSP references |
| `K` | LSP hover |
| `Space + ca` | Code action |
| `Space + rn` | Rename |
| `Space + cd` | Line diagnostics |
| `Space + ih` | Toggle inlay hints |
| `]d` / `[d` | Next / previous diagnostic |

## Updating

To update everything:

```
:Lazy sync
:MasonUpdate
```

## Removing

If you want to go back to stock NvChad:

```bash
rm -rf ~/.config/nvim
mv ~/.config/nvim.bak ~/.config/nvim
```

## Credits

Based on [NvChad](https://github.com/NvChad/NvChad) and the [starter template](https://github.com/NvChad/starter).
