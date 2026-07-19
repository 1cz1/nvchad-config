# NVChad — IDE Setup (C/C++/Python/Cyber)

This document describes the IDE configuration I installed for your NvChad setup, why each plugin was chosen, default keybindings (what I applied), usage examples, and common workflows.

Location
- File: ~/.config/nvim/NVCHAD_IDE_SETUP.md
- NvChad plugin list updated at: ~/.config/nvim/lua/plugins/init.lua
- Config stubs: ~/.config/nvim/lua/configs/

Quick status
- I installed and registered the requested plugins with lazy.nvim and ran `:Lazy sync` to clone/build them.
- Basic configs and sensible defaults were created for many plugins (LSP, cmp, luasnip, treesitter, telescope, nvim-tree, gitsigns, dap, toggleterm, etc.).
- Some advanced integrations (neotest adapters, cmake tooling, clangd extensions tweaks, detailed noice/lualine themes) are left with recommended defaults and are documented below.

Principles used
- Keep startup fast: most plugins are lazy-loaded by events or commands (lazy.nvim defaults). Treesitter is configured only for required languages.
- VS Code-like experience: LSP, nvim-cmp, snippets, fuzzy finder (telescope + fzf native), file explorer, bufferline, statusline, and dap UI emulate VS Code flows in terminal.
- Live diagnostics while typing: diagnostics configured to update_in_insert = true.

Core plugins (installed & why)
- neovim/nvim-lspconfig — LSP client configurations.
- williamboman/mason.nvim & mason-lspconfig.nvim — manages LSP/linters/formatters installation.
- hrsh7th/nvim-cmp — completion engine (source for LSP, buffer, snippets).
- L3MON4D3/LuaSnip + rafamadriz/friendly-snippets — snippets support and ready snippet collection.
- nvim-treesitter/nvim-treesitter — fast, accurate syntax highlighting and better trees for code-aware features.
- stevearc/conform.nvim — fast formatting pipeline (configured for clang-format, ruff/black fallback).
- nvim-telescope/telescope.nvim + plenary.nvim — fuzzy finder & utilities.
- folke/which-key.nvim — discoverable keybindings.
- lewis6991/gitsigns.nvim — inline git indicators and actions.
- windwp/nvim-autopairs — auto-closing brackets/quotes.
- numToStr/Comment.nvim — toggle comments quickly.
- folke/todo-comments.nvim — highlight and jump to TODOs.

File management
- nvim-tree/nvim-tree.lua — file explorer (toggle with <leader>e).
- telescope-file-browser.nvim — telescope-based file browser integration.
- ahmedkhalf/project.nvim — project management / workspace detection.

UI
- nvim-lualine/lualine.nvim — statusline (fast & customizable).
- akinsho/bufferline.nvim — buffer tabs line.
- stevearc/dressing.nvim — better vim.ui for prompts.
- folke/noice.nvim + nvim-notify — nicer UI for messages and notifications.
- lukas-reineke/indent-blankline.nvim — indentation guides.

Diagnostics
- folke/trouble.nvim — diagnostics list panel and quick fix UI.
- Diagnostics configured to update while typing (vim.diagnostic.config update_in_insert = true) and virtual text enabled.

C/C++
- clangd (via mason) — primary LSP for C/C++.
- clang-format (formatter) — formatting.
- p00f/clangd_extensions.nvim — extra clangd features (inlay hints, AST, etc.).
- Civitasv/cmake-tools.nvim — CMake workflow integration.

Python
- pyright (via mason) — Python LSP.
- ruff (via mason) — fast linter/formatter.
- black (formatter) — canonical code formatting.
- debugpy (via pip / mason) — debug adapter for Python.

Debugging
- mfussenegger/nvim-dap + rcarriga/nvim-dap-ui + theHamsta/nvim-dap-virtual-text — debug adapter, UI panels and inline variable values.

Terminal
- akinsho/toggleterm.nvim — integrated terminal toggling (<leader>t).

Git
- kdheepak/lazygit.nvim — launch lazygit in a floating terminal.

Testing
- nvim-neotest/neotest + neotest-python — test runner integration for Python (requires adapter install).

Productivity
- folke/flash.nvim — fast motion/preview.
- telescope-fzf-native.nvim — faster sorting for telescope.
- folke/persistence.nvim — session saving/restoring.

What I actually changed (files I created/updated)
- ~/.config/nvim/lua/plugins/init.lua — plugin list and lazy-loading entries.
- ~/.config/nvim/lua/configs/*.lua — config stubs for many plugins (lspconfig, mason, cmp, luasnip, treesitter, telescope, nvimtree, gitsigns, toggleterm, dap, conform, trouble, dap-virtual-text)
- ~/.config/nvim/NVCHAD_IDE_SETUP.md — this file.

Keybindings applied (what I set in configs)
- LSP navigation and actions (in lspconfig on_attach)
  - gd → goto definition
  - gr → references
  - K → hover
  - <leader>rn → rename
  - <C-k> (normal & insert) → signature help
- Completion (nvim-cmp)
  - <C-Space> → trigger completion
  - <CR> → confirm
  - <Tab>/<S-Tab> → next/prev completion or snippet jump
- File explorer
  - <leader>e → Toggle NvimTree
- Telescope
  - <leader>ff → Find files
  - <leader>fg → Live grep
- ToggleTerm
  - <leader>t → Toggle terminal

Notes on additional recommended keybindings
- Debugging (neovim-dap): I didn't bind keys by default so you can choose keys that fit you. Common choices:
  - <F5> → dap.continue
  - <F10> → dap.step_over
  - <F11> → dap.step_into
  - <F12> → dap.step_out
  - <leader>db → set breakpoint
  - <leader>dr → run to cursor

How to use (examples)
- Install LSPs / tools via Mason UI
  - Open Neovim and run :Mason
  - Install clangd, clang-format, pyright, ruff, debugpy
- Build and run a C program
  - :terminal gcc -std=c11 -O2 main.c -o main && ./main
  - Or use toggleterm (<leader>t) to run build commands
- Use Telescope to open files
  - <leader>ff then type a filename
- Run tests (Python)
  - nvim-neotest integration requires installing neotest-python adapter; then run :lua require('neotest').run.run() or bind keys
- Debug Python
  - Ensure debugpy is installed (pip install debugpy) or via Mason
  - Configure a dap configuration in lua (I added Python adapter). Use dap-ui to open panels.

Common workflows (Daily)
- Open project
  - cd to project in terminal then nvim . or open Neovim and use :Telescope find_files with project.nvim to filter by project root
- Find files
  - <leader>ff → fuzzy find
- Search text
  - <leader>fg → live grep
- Run code
  - Use ToggleTerm (<leader>t) or :terminal to run build/test commands
- Debug code
  - Launch dap, open dap-ui (require('dapui').open()), set breakpoints, run
- Fix errors
  - Diagnostics appear live while typing (insert-mode updates). Use :Trouble to view list, or hover on diagnostics with K
- Git workflow
  - Use gitsigns for inline hunks, and lazygit via :LazyGit (if you map it) for commit/branch management

C/C++ Workflow
- Install clangd & clang-format via Mason
- Open project with a compile_commands.json (CMake: run cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON)
- clangd will provide code actions, inlay hints (if clangd_extensions enabled), and autocompletion
- Format with clang-format (on save via conform) or :lua require('conform').format{buf=0}
- Build & run in toggleterm or use cmake-tools.nvim commands (if you enable cmake server integration)
- Debug with nvim-dap using lldb or cpptools adapter; configure adapter in ~/.config/nvim/lua/configs/dap.lua if desired

Python Workflow
- Install pyright, ruff, black, debugpy via Mason/pip
- LSP (pyright) + completion (nvim-cmp) + snippets (LuaSnip) provide VS Code-like UX
- Formatting: conform uses ruff/black per config
- Tests: neotest + neotest-python run tests, show results inline
- Debug: debugpy via dap adapter (I created a basic adapter in configs/dap.lua)

Cybersecurity Workflow (pen-tests, tooling, scripts)
- Use project.nvim to open recon/tooling directories quickly
- Use telescope + live_grep to search patterns and secrets
- Use toggleterm to run tools (nmap, ffuf, gobuster, sqlmap) inside Neovim terminal for fast iteration
- Use quickfix/Trouble to collect and triage findings

How to update/remove plugins
- Update all plugins: open Neovim and run :Lazy sync or :Lazy update
- Remove a plugin: remove its table entry from ~/.config/nvim/lua/plugins/init.lua and run :Lazy clean (or :Lazy sync)
- For LSP/tools managed by Mason: open :Mason and uninstall or use :MasonUninstall <pkg>

Notes, next steps and suggestions (I kept this short)
- I created working configs for core features and installed plugins with Lazy. To finish personalization I can:
  - Add full dap keybindings and sample launch.json-style configs for C++ (lldb) and Python.
  - Wire neotest keybindings for running single tests / nearest tests.
  - Enable more treesitter modules and filetype-specific completions.
  - Move plugin configs to lua/custom/ to preserve across upstream NvChad updates.

If you want, I will now:
- (A) Finish wiring all remaining plugin configurations and keybindings (dap, neotest, clangd_extensions, cmake-tools) and push them to files, then restart and run :Lazy sync + :MasonInstall for the required servers.
- (B) Or generate a minimal final README only and leave advanced wiring for interactive steps.

Tell me A or B. If A, I will proceed and finish everything automatically now.
