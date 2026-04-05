#!/bin/bash
set -euo pipefail

echo "=== [chezmoi] Installing packages and tools ==="

# ------------------------------
# 1. APT packages
# ------------------------------
echo ">>> Installing apt packages..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
    zsh \
    git \
    curl \
    wget \
    build-essential \
    btop \
    flameshot \
    fzf \
    ripgrep \
    fd-find \
    fcitx5 \
    fcitx5-hangul \
    fcitx5-config-qt \
    unzip

# ------------------------------
# 2. Nerd Fonts (MesloLGS — recommended by Powerlevel10k)
# ------------------------------
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -f "$FONT_DIR/MesloLGSNerdFont-Regular.ttf" ]; then
    echo ">>> Installing MesloLGS Nerd Font..."
    mkdir -p "$FONT_DIR"
    curl -fsSL -o "$FONT_DIR/MesloLGSNerdFont-Regular.ttf"    "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Regular/MesloLGSNerdFont-Regular.ttf"
    curl -fsSL -o "$FONT_DIR/MesloLGSNerdFont-Bold.ttf"       "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Bold/MesloLGSNerdFont-Bold.ttf"
    curl -fsSL -o "$FONT_DIR/MesloLGSNerdFont-Italic.ttf"     "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/Italic/MesloLGSNerdFont-Italic.ttf"
    curl -fsSL -o "$FONT_DIR/MesloLGSNerdFont-BoldItalic.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S/BoldItalic/MesloLGSNerdFont-BoldItalic.ttf"
    curl -fsSL -o "$FONT_DIR/MesloLGSDZNerdFont-Regular.ttf"  "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Meslo/S-DZ/Regular/MesloLGSDZNerdFont-Regular.ttf"
    curl -fsSL -o "$FONT_DIR/SymbolsNerdFont-Regular.ttf"     "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf"
    curl -fsSL -o "$FONT_DIR/SymbolsNerdFontMono-Regular.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFontMono-Regular.ttf"
    fc-cache -f "$FONT_DIR"
    echo "    MesloLGS Nerd Font installed. Set it as your terminal font."
fi

# ------------------------------
# 3. Oh My Zsh
# ------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">>> Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ------------------------------
# 4. Powerlevel10k (oh-my-zsh custom theme)
# ------------------------------
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo ">>> Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# ------------------------------
# 5. Zsh plugins (oh-my-zsh custom)
# ------------------------------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo ">>> Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo ">>> Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ------------------------------
# 6. Neovim (latest stable)
# ------------------------------
if ! command -v nvim &>/dev/null; then
    echo ">>> Installing Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    rm -f nvim-linux-x86_64.tar.gz
fi

# ------------------------------
# 7. Rust (via rustup)
# ------------------------------
if ! command -v cargo &>/dev/null; then
    echo ">>> Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# ------------------------------
# 8. Zellij
# ------------------------------
if ! command -v zellij &>/dev/null; then
    echo ">>> Installing Zellij..."
    cargo install zellij
fi

# ------------------------------
# 9. GitHub CLI
# ------------------------------
if ! command -v gh &>/dev/null; then
    echo ">>> Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update -qq
    sudo apt-get install -y -qq gh
fi

# ------------------------------
# 10. NVM + Node.js
# ------------------------------
if [ ! -d "$HOME/.nvm" ]; then
    echo ">>> Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if ! command -v node &>/dev/null; then
    echo ">>> Installing Node.js LTS..."
    nvm install --lts
fi

# ------------------------------
# 11. Set default shell to zsh
# ------------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo ">>> Setting zsh as default shell..."
    chsh -s "$(which zsh)" || echo "    (chsh failed — run manually: chsh -s $(which zsh))"
fi

echo "=== [chezmoi] Setup complete! ==="
