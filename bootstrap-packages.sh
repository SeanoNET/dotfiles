#!/bin/bash
# Full bootstrap for Arch/EndeavourOS - from zero to working desktop
# One-liner for fresh machine:
#   bash <(curl -s https://raw.githubusercontent.com/SeanoNET/dotfiles/main/bootstrap-packages.sh)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Dotfiles Bootstrap - Full Desktop Provisioning${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}✗ This script should NOT be run as root${NC}"
   echo -e "  Run without sudo - the script will ask for password when needed"
   exit 1
fi

# ── Auto-clone logic ─────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$HOME/dotfiles"

if [[ -d "$SCRIPT_DIR/.git" && -d "$SCRIPT_DIR/i3" && -d "$SCRIPT_DIR/zsh" ]]; then
    DOTFILES_DIR="$SCRIPT_DIR"
    echo -e "${GREEN}✓${NC} Running from dotfiles repo: $DOTFILES_DIR"
elif [[ -d "$DOTFILES_DIR/.git" && -d "$DOTFILES_DIR/i3" ]]; then
    echo -e "${GREEN}✓${NC} Found existing dotfiles at $DOTFILES_DIR"
else
    echo -e "${YELLOW}→${NC} Cloning dotfiles to $DOTFILES_DIR..."
    sudo pacman -S --needed --noconfirm git
    git clone https://github.com/SeanoNET/dotfiles.git "$DOTFILES_DIR"
    echo -e "${GREEN}✓${NC} Dotfiles cloned"
    echo -e "${YELLOW}→${NC} Re-executing from cloned repo..."
    exec bash "$DOTFILES_DIR/bootstrap-packages.sh"
fi

# ── Helper functions ─────────────────────────────────────────────────

is_installed() {
    pacman -Qi "$1" &>/dev/null
}

install_if_missing() {
    local package=$1
    local source=$2  # "official" or "aur"

    if is_installed "$package"; then
        echo -e "${GREEN}✓${NC} $package already installed"
        return 0
    fi

    echo -e "${YELLOW}→${NC} Installing $package..."

    if [[ "$source" == "official" ]]; then
        sudo pacman -S --noconfirm --needed "$package"
    else
        $AUR_HELPER -S --noconfirm --needed "$package"
    fi

    if is_installed "$package"; then
        echo -e "${GREEN}✓${NC} $package installed successfully"
    else
        echo -e "${RED}✗${NC} Failed to install $package"
        return 1
    fi
}

is_flatpak_installed() {
    flatpak list --app --columns=application 2>/dev/null | grep -q "^$1$"
}

# ── AUR helper detection ────────────────────────────────────────────

echo -e "${BLUE}Checking for AUR helper...${NC}"
if command -v yay &>/dev/null; then
    AUR_HELPER="yay"
    echo -e "${GREEN}✓${NC} Found yay"
elif command -v paru &>/dev/null; then
    AUR_HELPER="paru"
    echo -e "${GREEN}✓${NC} Found paru"
else
    echo -e "${RED}✗${NC} No AUR helper found (yay or paru)"
    echo -e "${YELLOW}Installing yay...${NC}"
    sudo pacman -S --needed --noconfirm git base-devel
    cd /tmp
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay-bin
    AUR_HELPER="yay"
    echo -e "${GREEN}✓${NC} yay installed"
fi

# ── Official Repository Packages ────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Official Repository Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

OFFICIAL_PACKAGES=(
    # WM / Display
    "i3-wm"
    "polybar"
    "picom"
    "rofi"
    "dunst"
    "xss-lock"
    "i3lock"
    "dex"
    "feh"
    "flameshot"
    "scrot"
    "imagemagick"
    "xorg-setxkbmap"
    "xorg-xbacklight"
    "polkit-gnome"
    "nautilus"
    "xscreensaver"

    # Terminals
    "alacritty"
    "tmux"

    # Shell
    "zsh"
    "stow"

    # Fonts
    "ttf-jetbrains-mono"
    "ttf-jetbrains-mono-nerd"

    # CLI Tools
    "fzf"
    "zoxide"
    "eza"
    "helix"
    "bat"
    "glow"
    "git-delta"
    "playerctl"
    "yazi"
    "lazygit"
    "starship"
    "python"
    "python-i3ipc"
    "pacman-contrib"

    # Dev Tools
    "docker"
    "docker-compose"
    "github-cli"
    "kubectl"
    "kubectx"
    "git"

    # Qt Theming
    "qt5ct"
    "qt6ct"

    # Networking / Audio
    "networkmanager"
    "nm-connection-editor"
    "wireplumber"
    "pavucontrol"

    # Apps
    "obsidian"
    "steam"
    "power-profiles-daemon"

    # Flatpak (installed here so the flatpak section can use it)
    "flatpak"
)

for package in "${OFFICIAL_PACKAGES[@]}"; do
    install_if_missing "$package" "official"
done

# ── AUR Packages ────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    AUR Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

AUR_PACKAGES=(
    "1password-beta"
    "azure-cli"
    "autotiling"
    "bluetuith"
    "ghostty"
    "bambustudio-bin"
    "scrcpy"
    "spotify-player-full"
    "zen-browser-bin"
)

for package in "${AUR_PACKAGES[@]}"; do
    install_if_missing "$package" "aur"
done

# ── Flatpak Packages ───────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Flatpak Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if ! flatpak remote-list 2>/dev/null | grep -q flathub; then
    echo -e "${YELLOW}→${NC} Adding Flathub remote..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    echo -e "${GREEN}✓${NC} Flathub remote added"
else
    echo -e "${GREEN}✓${NC} Flathub remote already configured"
fi

FLATPAK_PACKAGES=(
    "com.discordapp.Discord"
)

for app in "${FLATPAK_PACKAGES[@]}"; do
    if is_flatpak_installed "$app"; then
        echo -e "${GREEN}✓${NC} $app already installed"
    else
        echo -e "${YELLOW}→${NC} Installing $app..."
        flatpak install -y flathub "$app"
        echo -e "${GREEN}✓${NC} $app installed"
    fi
done

# ── Install-Script Tools ───────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Install-Script Tools (oh-my-zsh, zinit, nvm, tpm)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# oh-my-zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo -e "${GREEN}✓${NC} oh-my-zsh already installed"
else
    echo -e "${YELLOW}→${NC} Installing oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo -e "${GREEN}✓${NC} oh-my-zsh installed"
fi

# zinit
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ -d "$ZINIT_HOME" ]]; then
    echo -e "${GREEN}✓${NC} zinit already installed"
else
    echo -e "${YELLOW}→${NC} Installing zinit..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    echo -e "${GREEN}✓${NC} zinit installed"
fi

# nvm
if [[ -d "$HOME/.nvm" ]]; then
    echo -e "${GREEN}✓${NC} nvm already installed"
else
    echo -e "${YELLOW}→${NC} Installing nvm..."
    PROFILE=/dev/null bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
    echo -e "${GREEN}✓${NC} nvm installed"
fi

# tpm (tmux plugin manager)
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
    echo -e "${GREEN}✓${NC} tpm already installed"
else
    echo -e "${YELLOW}→${NC} Installing tpm..."
    mkdir -p "$(dirname "$TPM_DIR")"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo -e "${GREEN}✓${NC} tpm installed"
fi

# ── GNU Stow Symlinks ──────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    GNU Stow Symlinks${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

STOW_PACKAGES=(
    alacritty
    background
    ghostty
    git
    helix
    i3
    lazygit
    picom
    polybar
    rofi
    starship
    tmux
    vscode
    xprofile
    yazi
    zed
    zsh
)

for pkg in "${STOW_PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        echo -e "${YELLOW}→${NC} Stowing $pkg..."
        stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg" 2>&1 | while read -r line; do
            echo -e "  ${RED}$line${NC}"
        done
        echo -e "${GREEN}✓${NC} $pkg stowed"
    else
        echo -e "${YELLOW}⚠${NC} $pkg directory not found, skipping"
    fi
done

# ── Rofi Theme ──────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Rofi Theme${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

ROFI_THEME_DIR="$HOME/.local/share/rofi/themes"
ROFI_THEME_FILE="$ROFI_THEME_DIR/spotlight-dark.rasi"

if [[ -f "$ROFI_THEME_FILE" ]]; then
    echo -e "${GREEN}✓${NC} Rofi spotlight-dark theme already installed"
else
    echo -e "${YELLOW}→${NC} Installing rofi spotlight-dark theme..."
    mkdir -p "$ROFI_THEME_DIR"
    TMPDIR=$(mktemp -d)
    git clone --depth 1 https://github.com/newmanls/rofi-themes-collection.git "$TMPDIR"
    cp "$TMPDIR/themes/spotlight-dark.rasi" "$ROFI_THEME_FILE"
    rm -rf "$TMPDIR"
    echo -e "${GREEN}✓${NC} Rofi theme installed"
fi

# ── Post-Installation Configuration ─────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Post-Installation Configuration${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Docker service
if systemctl is-enabled docker &>/dev/null; then
    echo -e "${GREEN}✓${NC} Docker service already enabled"
else
    echo -e "${YELLOW}→${NC} Enabling Docker service..."
    sudo systemctl enable --now docker
    echo -e "${GREEN}✓${NC} Docker service enabled"
fi

# Docker group
if groups | grep -q docker; then
    echo -e "${GREEN}✓${NC} User already in docker group"
else
    echo -e "${YELLOW}→${NC} Adding user to docker group..."
    sudo usermod -aG docker "$USER"
    echo -e "${GREEN}✓${NC} User added to docker group"
fi

# power-profiles-daemon
if systemctl is-enabled power-profiles-daemon &>/dev/null; then
    echo -e "${GREEN}✓${NC} power-profiles-daemon already enabled"
else
    echo -e "${YELLOW}→${NC} Enabling power-profiles-daemon..."
    sudo systemctl enable --now power-profiles-daemon
    echo -e "${GREEN}✓${NC} power-profiles-daemon enabled"
fi

# Change shell to zsh
if [[ "$SHELL" == *"zsh"* ]]; then
    echo -e "${GREEN}✓${NC} Default shell is already zsh"
else
    echo -e "${YELLOW}→${NC} Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo -e "${GREEN}✓${NC} Default shell changed to zsh"
fi

# tmux plugins (headless install)
if [[ -x "$TPM_DIR/bin/install_plugins" ]]; then
    echo -e "${YELLOW}→${NC} Installing tmux plugins..."
    "$TPM_DIR/bin/install_plugins" || true
    echo -e "${GREEN}✓${NC} tmux plugins installed"
else
    echo -e "${YELLOW}⚠${NC} tpm install_plugins not found, skip tmux plugin install"
fi

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}    Bootstrap complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}Manual steps remaining:${NC}"
echo -e "  1. Log out and back in (docker group + shell change)"
echo -e "  2. Set up monitor layout with arandr"
echo -e "  3. Resolve any stow conflicts printed above"
echo -e "  4. In tmux: prefix + I (if tpm plugin install didn't run)"
echo -e "  5. Run: nvm install --lts (for Node.js)"
echo ""
