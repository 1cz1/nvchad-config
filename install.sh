#!/usr/bin/env bash
#
# NvChad Config installer
# https://github.com/1cz1/nvchad-config
#
# This script will:
#   1. Check prerequisites
#   2. Back up your current Neovim config (if any)
#   3. Clone this config to ~/.config/nvim
#   4. Install plugins with lazy.nvim
#   5. Install LSP servers and tools with Mason
#
set -e

# --- Colors for pretty output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info()  { echo -e "${CYAN}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC}   $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERR]${NC}  $1"; }

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  NvChad Config Installer${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# --- Check prerequisites ---
info "Checking prerequisites..."

# Neovim
if command -v nvim &>/dev/null; then
  NVIM_VERSION=$(nvim --version | head -1 | grep -oP '\d+\.\d+' | head -1)
  ok "Neovim $NVIM_VERSION found"
else
  err "Neovim not found. Please install Neovim >= 0.10."
  err "  https://github.com/neovim/neovim/blob/master/INSTALL.md"
  exit 1
fi

# Git
if command -v git &>/dev/null; then
  ok "Git found"
else
  err "Git not found. Please install Git."
  exit 1
fi

# Nerd Font check (just a friendly warning)
if command -v fc-list &>/dev/null; then
  if fc-list | grep -qi "nerd font" &>/dev/null; then
    ok "Nerd Font found"
  else
    warn "No Nerd Font detected. Icons may look broken."
    warn "Install one: https://www.nerdfonts.com/font-downloads"
  fi
fi

# C/C++ toolchain
if command -v gcc &>/dev/null; then
  ok "GCC found"
else
  warn "GCC not found. Install it for C/C++ compilation support."
fi

if command -v g++ &>/dev/null; then
  ok "G++ found"
else
  warn "G++ not found. Install it for C++ compilation support."
fi

if command -v gdb &>/dev/null; then
  ok "GDB found"
else
  warn "GDB not found (optional, for debugging)."
fi

# Python
if command -v python3 &>/dev/null; then
  ok "Python 3 found"
else
  warn "Python 3 not found. Python LSP and debugging won't work."
fi

# lazygit (optional)
if command -v lazygit &>/dev/null; then
  ok "lazygit found"
else
  warn "lazygit not found (optional, for git UI integration)."
fi

echo ""

# --- Warn about existing config ---
if [ -d "$HOME/.config/nvim" ]; then
  echo -e "${YELLOW}============================================${NC}"
  echo -e "${YELLOW}  WARNING: Existing Neovim config found${NC}"
  echo -e "${YELLOW}============================================${NC}"
  echo ""
  echo "  I'll move it to ~/.config/nvim.bak"
  echo "  (and ~/.local/share/nvim.bak if it exists)."
  echo ""
  read -rp "  Continue? [y/N] " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "  Aborted."
    exit 1
  fi
fi

# --- Backup existing config ---
if [ -d "$HOME/.config/nvim" ]; then
  info "Backing up ~/.config/nvim -> ~/.config/nvim.bak"
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

if [ -d "$HOME/.local/share/nvim" ]; then
  info "Backing up ~/.local/share/nvim -> ~/.local/share/nvim.bak"
  mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
fi

echo ""

# --- Clone the config ---
info "Cloning config to ~/.config/nvim ..."
git clone https://github.com/1cz1/nvchad-config "$HOME/.config/nvim"
ok "Config cloned"

echo ""

# --- Install plugins ---
info "Installing plugins with lazy.nvim (this may take a while)..."
nvim --headless "+Lazy! sync" +qa
ok "Plugins installed"

echo ""

# --- Install Mason tools ---
info "Installing LSP servers and tools with Mason..."
nvim --headless "+MasonInstallAll" +qa
ok "Mason tools installed"

echo ""

# --- Done ---
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  All done!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "  Open Neovim and you're ready to go:"
echo ""
echo "    nvim"
echo ""
echo "  First time? A few tips:"
echo "    - Run :checkhealth to see if everything works"
echo "    - Press Space then ff to search files"
echo "    - Press Space then t to open a terminal"
echo "    - Open a .c or .cpp file and press F8 to compile and run"
echo ""
