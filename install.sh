#!/bin/bash

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo "${BLUE}[INFO] Starting Dotfiles Installation...${NC}"

# --- 1. Homebrew ---
if ! command -v brew &> /dev/null; then
    echo "${BLUE}[INFO] Homebrew not found. Installing now...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "${GREEN}[OK] Homebrew is already installed.${NC}"
fi

# --- 2. Core Dependencies and Apps ---
echo "${BLUE}[INFO] Installing tools (stow, zsh, wezterm)...${NC}"
# Installing the WezTerm application itself via Cask
brew install stow zsh
brew install --cask wezterm

# --- 3. Fonts ---
echo "${BLUE}[INFO] Checking for Nerd Fonts...${NC}"
if ! brew list --cask font-meslo-lg-nerd-font &> /dev/null; then
    echo "Installing MesloLGS Nerd Font..."
    brew install --cask font-meslo-lg-nerd-font
else
    echo "${GREEN}[OK] Nerd Font already installed.${NC}"
fi

# --- 4. Symlinking with Stow ---
echo "${BLUE}[INFO] Linking configurations with GNU Stow...${NC}"


cd "$(dirname "$0")"

# Temporary backup directory
BACKUP_DIR="$HOME/dotfiles_old"
mkdir -p "$BACKUP_DIR"

for file in ~/.zshrc ~/.p10k.zsh ~/.wezterm.lua; do
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "Backing up existing $file to $BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
    fi
done


stow wezterm
stow zsh

# --- 5. Finalizing Shell ---
echo "${BLUE}[INFO] Finalizing shell setup...${NC}"

# Homebrew zsh path
BREW_ZSH="/opt/homebrew/bin/zsh"

if [ "$SHELL" != "$BREW_ZSH" ]; then
    echo "Adding Homebrew Zsh to allowed shells (requires sudo)..."
    if ! grep -Fxq "$BREW_ZSH" /etc/shells; then
        echo "$BREW_ZSH" | sudo tee -a /etc/shells
    fi
    echo "Changing default shell to Homebrew Zsh..."
    chsh -s "$BREW_ZSH"
fi

# --- 6. Cleanup ---
echo "${BLUE}[INFO] Cleaning up backup files...${NC}"
if [ -d "$BACKUP_DIR" ]; then
    rm -rf "$BACKUP_DIR"
    echo "${GREEN}[OK] $BACKUP_DIR removed.${NC}"
fi

echo "${GREEN}[DONE] Installation complete. Please restart your terminal.${NC}"