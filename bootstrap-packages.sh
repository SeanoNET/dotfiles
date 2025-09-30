#!/bin/bash
# Bootstrap script for Arch/EndeavourOS package installation
# Only installs 3rd party packages that aren't part of the base EndeavourOS installation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Package Bootstrap Script - 3rd Party Packages Only${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}✗ This script should NOT be run as root${NC}"
   echo -e "  Run without sudo - the script will ask for password when needed"
   exit 1
fi

# Function to check if package is installed
is_installed() {
    pacman -Qi "$1" &>/dev/null
}

# Function to install package if not present
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

# Check for AUR helper
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

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Official Repository Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Official repo packages (3rd party tools not in base EndeavourOS)
OFFICIAL_PACKAGES=(
    "azure-cli"           # Azure command-line tools
    "docker"             # Container platform
    "docker-compose"     # Docker orchestration
    "git-delta"          # Better git diff viewer
    "github-cli"         # GitHub CLI tool
    "lazygit"            # Git TUI
    "obsidian"           # Note-taking app
    "steam"              # Gaming platform
    "ttf-jetbrains-mono" # JetBrains Mono font
)

for package in "${OFFICIAL_PACKAGES[@]}"; do
    install_if_missing "$package" "official"
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    AUR Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# AUR packages
AUR_PACKAGES=(
    "1password"                  # Password manager
    "orca-slicer"                # 3D printing slicer
    "spotify-player-full"        # Spotify TUI player
    "zen-browser-bin"            # Privacy-focused browser
)

for package in "${AUR_PACKAGES[@]}"; do
    install_if_missing "$package" "aur"
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Package installation complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}Post-installation steps:${NC}"
echo -e "  1. Start Docker service: ${BLUE}sudo systemctl enable --now docker${NC}"
echo -e "  2. Add user to docker group: ${BLUE}sudo usermod -aG docker \$USER${NC}"
echo -e "  3. Reboot for xpadneo driver: ${BLUE}sudo reboot${NC}"
echo ""