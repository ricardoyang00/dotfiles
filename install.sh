#!/bin/bash

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}[INFO] Starting Dotfiles Installation...${NC}"

# --- 1. Homebrew ---
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}[INFO] Homebrew not found. Installing now...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}[OK] Homebrew is already installed.${NC}"
fi

# --- 2. Core Dependencies and Apps ---
echo -e "${BLUE}[INFO] Installing tools (stow, zsh, wezterm)...${NC}"
# Installing the WezTerm application itself via Cask
brew install stow zsh
brew install --cask wezterm

# --- 3. Fonts and Tools ---
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting
brew install eza zoxide thefuck

echo -e "${BLUE}[INFO] Checking for Nerd Fonts...${NC}"
if ! brew list --cask font-meslo-lg-nerd-font &> /dev/null; then
    echo -e "Installing MesloLGS Nerd Font..."
    brew install --cask font-meslo-lg-nerd-font
else
    echo -e "${GREEN}[OK] Nerd Font already installed.${NC}"
fi

# --- 4. Symlinking with Stow ---
echo -e "${BLUE}[INFO] Linking configurations with GNU Stow...${NC}"


cd "$(dirname "$0")"

stow wezterm
stow zsh

# --- 5. Finalizing Shell ---
echo -e "${BLUE}[INFO] Finalizing shell setup...${NC}"

# Homebrew zsh path
BREW_ZSH="/opt/homebrew/bin/zsh"

if [ "$SHELL" != "$BREW_ZSH" ]; then
    echo -e "Adding Homebrew Zsh to allowed shells (requires sudo)..."
    if ! grep -Fxq "$BREW_ZSH" /etc/shells; then
        echo -e "$BREW_ZSH" | sudo tee -a /etc/shells
    fi
    echo -e "Changing default shell to Homebrew Zsh..."
    chsh -s "$BREW_ZSH"
fi

echo -e "${GREEN}[DONE] Installation complete. Please restart your terminal.${NC}"