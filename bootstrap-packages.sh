#!/bin/bash
# Full bootstrap for Arch/EndeavourOS - from zero to working desktop
# One-liner for fresh machine:
#   curl -s https://raw.githubusercontent.com/SeanoNET/dotfiles/wayland/bootstrap-packages.sh | bash

set -euo pipefail

# Allow individual package installs to fail without aborting the script
install_failed=0

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
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_BRANCH="wayland"
SCRIPT_DIR=""

# BASH_SOURCE is empty when piped via curl | bash
if [[ -n "${BASH_SOURCE[0]:-}" && "${BASH_SOURCE[0]}" != "bash" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

if [[ -n "$SCRIPT_DIR" && -d "$SCRIPT_DIR/.git" && -d "$SCRIPT_DIR/zsh" ]]; then
    DOTFILES_DIR="$SCRIPT_DIR"
    echo -e "${GREEN}✓${NC} Running from dotfiles repo: $DOTFILES_DIR"
elif [[ -d "$DOTFILES_DIR/.git" && -d "$DOTFILES_DIR/zsh" ]]; then
    echo -e "${GREEN}✓${NC} Found existing dotfiles at $DOTFILES_DIR"
else
    echo -e "${YELLOW}→${NC} Cloning dotfiles ($DOTFILES_BRANCH branch) to $DOTFILES_DIR..."
    sudo pacman -S --needed --noconfirm git
    git clone -b "$DOTFILES_BRANCH" https://github.com/SeanoNET/dotfiles.git "$DOTFILES_DIR"
    echo -e "${GREEN}✓${NC} Dotfiles cloned"
    echo -e "${YELLOW}→${NC} Re-executing from cloned repo..."
    exec bash "$DOTFILES_DIR/bootstrap-packages.sh" </dev/tty
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
        sudo pacman -S --noconfirm --needed "$package" || true
    else
        $AUR_HELPER -S --noconfirm --needed "$package" || true
    fi

    if is_installed "$package"; then
        echo -e "${GREEN}✓${NC} $package installed successfully"
    else
        echo -e "${RED}✗${NC} Failed to install $package (continuing...)"
        install_failed=1
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

# ── Sync package database ──────────────────────────────────────────
echo -e "${BLUE}Syncing package database...${NC}"
sudo pacman -Sy

# ── Official Repository Packages ────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Official Repository Packages${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

OFFICIAL_PACKAGES=(
    # Wayland / Sway
    "sway"
    "waybar"
    "swayidle"
    "swaybg"
    "grim"
    "slurp"
    "wl-clipboard"
    "brightnessctl"
    "wlr-randr"
    "xdg-desktop-portal-wlr"
    "xdg-desktop-portal-gtk"
    "xorg-xwayland"
    "dunst"
    "kanshi"
    "dex"
    "imagemagick"
    "polkit-gnome"
    "nautilus"
    "cliphist"
    "gnome-keyring"
    "chromium"

    # Terminal
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
    "neovim"
    "bat"
    "glow"
    "git-delta"
    "playerctl"
    "yazi"
    "lazygit"
    "starship"
    "python"
    "pacman-contrib"
    "rofi"

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

    # Utilities
    "jq"
    "fd"
    "btop"
    "unzip"

    # Audio (PipeWire stack)
    "pipewire"
    "pipewire-pulse"
    "pipewire-audio"
    "wireplumber"
    "wiremix"

    # Networking
    "networkmanager"
    "nm-connection-editor"

    # Editors
    "code"
    "zed"

    # Apps
    "spotify-player"
    "obsidian"
    "power-profiles-daemon"
    "azure-cli"
    "autotiling"
    "ghostty"
    "scrcpy"
    "thunderbird"

    # Login manager
    "ly"

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
    "bluetuith"
    "bambustudio-bin"
    "localsend-bin"
    "opencode-bin"
    "swaylock-effects"
    "vicinae-bin"
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
echo -e "${BLUE}    Install-Script Tools${NC}"
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

# nvm + Node.js LTS
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR" ]]; then
    echo -e "${GREEN}✓${NC} nvm already installed"
else
    echo -e "${YELLOW}→${NC} Installing nvm..."
    PROFILE=/dev/null bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
    echo -e "${GREEN}✓${NC} nvm installed"
fi
# Install Node.js LTS
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if command -v node &>/dev/null; then
    echo -e "${GREEN}✓${NC} Node.js already installed ($(node --version))"
else
    echo -e "${YELLOW}→${NC} Installing Node.js LTS..."
    nvm install --lts
    echo -e "${GREEN}✓${NC} Node.js LTS installed ($(node --version))"
fi

# claude code
if command -v claude &>/dev/null; then
    echo -e "${GREEN}✓${NC} claude code already installed"
else
    echo -e "${YELLOW}→${NC} Installing claude code..."
    curl -fsSL https://claude.ai/install.sh | bash
    echo -e "${GREEN}✓${NC} claude code installed"
fi

# ── GNU Stow Symlinks ──────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    GNU Stow Symlinks${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

STOW_PACKAGES=(
    background
    chromium
    dunst
    ghostty
    git
    kanshi
    lazygit
    rofi
    starship
    sway
    swaylock
    tmux
    nvim
    vscode
    waybar
    yazi
    zed
    zsh
)

for pkg in "${STOW_PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
        echo -e "${YELLOW}→${NC} Stowing $pkg..."
        # Back up existing real files before stow overwrites them
        while IFS= read -r target; do
            dest="$HOME/$target"
            if [[ -f "$dest" && ! -L "$dest" ]]; then
                mkdir -p "$BACKUP_DIR/$(dirname "$target")"
                cp "$dest" "$BACKUP_DIR/$target"
                echo -e "  ${BLUE}↪${NC} Backed up $target"
            fi
        done < <(cd "$DOTFILES_DIR/$pkg" && find . -type f | sed 's|^\./||')
        # Adopt existing files so stow can replace them with symlinks
        stow --dir="$DOTFILES_DIR" --target="$HOME" --adopt "$pkg" 2>/dev/null || true
        # Restore dotfiles versions and create proper symlinks
        (cd "$DOTFILES_DIR" && git checkout -- "$pkg")
        stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg" 2>&1 | while read -r line; do
            echo -e "  ${RED}$line${NC}"
        done
        echo -e "${GREEN}✓${NC} $pkg stowed"
    else
        echo -e "${YELLOW}⚠${NC} $pkg directory not found, skipping"
    fi
done

# ── Theme Setup ─────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Theme Setup (Tokyo Night Storm)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# GTK dark theme
echo -e "${YELLOW}→${NC} Configuring GTK dark theme..."
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true
echo -e "${GREEN}✓${NC} GTK dark theme configured"

# Qt theme (qt5ct/qt6ct)
for ver in qt5ct qt6ct; do
    config_dir="$HOME/.config/$ver"
    config_file="$config_dir/$ver.conf"
    if [[ ! -f "$config_file" ]]; then
        echo -e "${YELLOW}→${NC} Creating $ver config..."
        mkdir -p "$config_dir"
        cat > "$config_file" <<QTCONF
[Appearance]
style=Fusion
color_scheme_path=
custom_palette=false
standard_dialogs=default

[Fonts]
fixed="JetBrains Mono,10,-1,5,50,0,0,0,0,0"
general="JetBrains Mono,10,-1,5,50,0,0,0,0,0"
QTCONF
        echo -e "${GREEN}✓${NC} $ver config created"
    else
        echo -e "${GREEN}✓${NC} $ver config already exists"
    fi
done

# VS Code Tokyo Night extension
if command -v code &>/dev/null; then
    echo -e "${YELLOW}→${NC} Installing VS Code Tokyo Night extension..."
    code --install-extension enkia.tokyo-night || true
    echo -e "${GREEN}✓${NC} VS Code Tokyo Night extension installed"
fi

# Yazi Tokyo Night flavor
if command -v ya &>/dev/null; then
    echo -e "${YELLOW}→${NC} Installing Yazi Tokyo Night flavor..."
    ya pkg add BennyOe/tokyo-night || true
    echo -e "${GREEN}✓${NC} Yazi Tokyo Night flavor installed"
fi

# ── Post-Installation Configuration ─────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Post-Installation Configuration${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# SSH setup
if [[ -d "$HOME/.ssh" ]]; then
    echo -e "${GREEN}✓${NC} ~/.ssh directory exists"
else
    echo -e "${YELLOW}→${NC} Creating ~/.ssh directory..."
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo -e "${GREEN}✓${NC} ~/.ssh directory created"
fi

if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
    echo -e "${GREEN}✓${NC} SSH key already exists"
else
    echo -e "${YELLOW}→${NC} Generating SSH key..."
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -C "$USER@$(hostname)" </dev/tty
    echo -e "${GREEN}✓${NC} SSH key generated"
    echo -e "${YELLOW}⚠${NC}  Public key:"
    cat "$HOME/.ssh/id_ed25519.pub"
    echo ""
fi

# ly display manager — disable any competing DM first
for dm in gdm sddm lightdm lxdm; do
    if systemctl is-enabled "$dm" &>/dev/null; then
        echo -e "${YELLOW}→${NC} Disabling $dm (replacing with ly)..."
        sudo systemctl disable "$dm"
        echo -e "${GREEN}✓${NC} $dm disabled"
    fi
done

if [[ -f "$DOTFILES_DIR/ly/config.ini" ]]; then
    echo -e "${YELLOW}→${NC} Installing ly config..."
    sudo mkdir -p /etc/ly
    sudo cp "$DOTFILES_DIR/ly/config.ini" /etc/ly/config.ini
    echo -e "${GREEN}✓${NC} ly config installed"
fi
if systemctl is-enabled ly@tty1 &>/dev/null; then
    echo -e "${GREEN}✓${NC} ly service already enabled"
else
    echo -e "${YELLOW}→${NC} Enabling ly service..."
    sudo systemctl enable ly@tty1
    echo -e "${GREEN}✓${NC} ly service enabled (will start on next boot)"
fi

# SMB mounts (Unraid NAS + Home Assistant)
if [[ -f "$DOTFILES_DIR/smb/fstab.smb" ]]; then
    echo -e "${YELLOW}→${NC} Setting up SMB mounts..."
    # Install cifs-utils if not present
    if ! pacman -Qi cifs-utils &>/dev/null; then
        sudo pacman -S --needed --noconfirm cifs-utils
    fi
    # Create mount points
    sudo mkdir -p /mnt/unraid/{backups,appdata,media,share} /mnt/hass-config
    # Create credentials directory
    sudo mkdir -p /etc/samba/credentials
    # Append SMB entries to fstab if not already present
    if ! grep -q "fstab.smb" /etc/fstab 2>/dev/null; then
        echo "" | sudo tee -a /etc/fstab > /dev/null
        echo "# SMB mounts managed by dotfiles (smb/fstab.smb)" | sudo tee -a /etc/fstab > /dev/null
        cat "$DOTFILES_DIR/smb/fstab.smb" | sudo tee -a /etc/fstab > /dev/null
        echo -e "${GREEN}✓${NC} SMB fstab entries added"
    else
        echo -e "${GREEN}✓${NC} SMB fstab entries already present"
    fi
    # Create credential files with defaults if they don't exist
    if [[ ! -f /etc/samba/credentials/unraid ]]; then
        sudo tee /etc/samba/credentials/unraid > /dev/null <<'CRED'
username=CHANGEME
password=CHANGEME
CRED
        sudo chmod 600 /etc/samba/credentials/unraid
        echo -e "${YELLOW}!${NC} Created /etc/samba/credentials/unraid — edit with your credentials"
    else
        echo -e "${GREEN}✓${NC} /etc/samba/credentials/unraid already exists"
    fi
    if [[ ! -f /etc/samba/credentials/hass ]]; then
        sudo tee /etc/samba/credentials/hass > /dev/null <<'CRED'
username=CHANGEME
password=CHANGEME
CRED
        sudo chmod 600 /etc/samba/credentials/hass
        echo -e "${YELLOW}!${NC} Created /etc/samba/credentials/hass — edit with your credentials"
    else
        echo -e "${GREEN}✓${NC} /etc/samba/credentials/hass already exists"
    fi
    # Reload systemd to pick up automount units
    sudo systemctl daemon-reload
    echo -e "${GREEN}✓${NC} SMB automount configured (mounts on first access)"
fi

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
    sudo chsh -s "$(which zsh)" "$USER"
    echo -e "${GREEN}✓${NC} Default shell changed to zsh"
fi

# tpm + tmux plugins (must run after stow so configs are in place)
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
    echo -e "${GREEN}✓${NC} tpm already installed"
else
    echo -e "${YELLOW}→${NC} Installing tpm..."
    mkdir -p "$(dirname "$TPM_DIR")"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo -e "${GREEN}✓${NC} tpm installed"
fi
# Install tmux plugins by cloning directly — TPM's install_plugins
# requires a tmux server to resolve the plugin path, which may not
# work on a fresh machine before tmux has ever run.
TMUX_PLUGIN_DIR="$HOME/.config/tmux/plugins"
TMUX_PLUGINS=(
    "tmux-plugins/tmux-sensible"
    "janoamaral/tokyo-night-tmux"
    "tmux-plugins/tmux-resurrect"
    "lost-melody/tmux-command-palette"
    "jabirali/tmux-tilish"
    "jaclu/tmux-menus"
    "sainnhe/tmux-fzf"
)
for plugin in "${TMUX_PLUGINS[@]}"; do
    plugin_name="$(basename "$plugin")"
    plugin_path="$TMUX_PLUGIN_DIR/$plugin_name"
    if [[ -d "$plugin_path" ]]; then
        echo -e "${GREEN}✓${NC} tmux plugin $plugin_name already installed"
    else
        echo -e "${YELLOW}→${NC} Installing tmux plugin $plugin_name..."
        git clone --single-branch --recursive "https://github.com/$plugin" "$plugin_path" >/dev/null 2>&1 \
            && echo -e "${GREEN}✓${NC} $plugin_name installed" \
            || echo -e "${RED}✗${NC} $plugin_name failed to install"
    fi
done

# ── Snapper (Btrfs Snapshots) ──────────────────────────────────────

if command -v snapper &>/dev/null; then
    # Enable timeline snapshots for root
    if snapper list-configs 2>/dev/null | grep -q "^root "; then
        sudo sed -i 's/TIMELINE_CREATE="no"/TIMELINE_CREATE="yes"/' /etc/snapper/configs/root
        sudo systemctl enable --now snapper-timeline.timer
        echo -e "${GREEN}✓${NC} Snapper timeline snapshots enabled for /"
    fi

    # Create snapper config for /home if it doesn't exist
    if snapper list-configs 2>/dev/null | grep -q "^home "; then
        echo -e "${GREEN}✓${NC} Snapper home config already exists"
    else
        echo -e "${YELLOW}→${NC} Creating snapper config for /home..."
        sudo snapper -c home create-config /home
        sudo sed -i 's/TIMELINE_CREATE="no"/TIMELINE_CREATE="yes"/' /etc/snapper/configs/home
        echo -e "${GREEN}✓${NC} Snapper config created for /home"
    fi

    sudo systemctl enable --now snapper-cleanup.timer
    echo -e "${GREEN}✓${NC} Snapper cleanup timer enabled"

    # Remind about dedicated snapshot drive
    if ! findmnt /.snapshots | grep -q "/dev/sd\|/dev/nvme" 2>/dev/null; then
        echo -e "${YELLOW}⚠${NC} Snapshots are stored on the root partition. Consider moving to a dedicated drive (see README)."
    fi
else
    echo -e "${YELLOW}⚠${NC} snapper not found, skipping snapshot setup"
fi

# ── Snapshot Backup to Unraid ─────────────────────────────────────
if [[ -f "$DOTFILES_DIR/smb/snapshot-backup.sh" ]] && command -v snapper &>/dev/null; then
    echo -e "${YELLOW}→${NC} Setting up snapshot backup to Unraid..."
    sudo cp "$DOTFILES_DIR/smb/snapshot-backup.sh" /usr/local/bin/snapshot-backup.sh
    sudo chmod +x /usr/local/bin/snapshot-backup.sh
    sudo cp "$DOTFILES_DIR/smb/snapshot-backup.service" /etc/systemd/system/snapshot-backup.service
    sudo cp "$DOTFILES_DIR/smb/snapshot-backup.timer" /etc/systemd/system/snapshot-backup.timer
    sudo systemctl daemon-reload
    sudo systemctl enable snapshot-backup.timer
    echo -e "${GREEN}✓${NC} Snapshot backup timer enabled (weekly)"
    if mountpoint -q /mnt/unraid/backups 2>/dev/null || ls /mnt/unraid/backups/ &>/dev/null; then
        echo -e "${GREEN}✓${NC} Backup share is accessible"
    else
        echo -e "${YELLOW}!${NC} /mnt/unraid/backups is not mounted — backup will run once the SMB share is available"
        echo -e "    Test with: sudo systemctl start snapshot-backup.service"
    fi
fi

# ── Web Apps ────────────────────────────────────────────────────────

WEBAPP_SCRIPT="$HOME/.config/sway/scripts/webapp"
if [[ -x "$WEBAPP_SCRIPT" ]]; then
    echo -e "${YELLOW}→${NC} Installing web apps..."
    "$WEBAPP_SCRIPT" install "Oak Hill Software" "https://oakhillsoftware.app"
    echo -e "${GREEN}✓${NC} Web apps installed"
fi

# ── Post-Install Validation ─────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}    Post-Install Validation${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

validation_ok=true

for svc in NetworkManager docker power-profiles-daemon; do
    if systemctl is-enabled "$svc" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $svc enabled"
    else
        echo -e "${RED}✗${NC} $svc not enabled"
        validation_ok=false
    fi
done

if systemctl is-enabled ly@tty1 &>/dev/null; then
    echo -e "${GREEN}✓${NC} ly display manager enabled"
else
    echo -e "${RED}✗${NC} ly display manager not enabled"
    validation_ok=false
fi

for svc in pipewire pipewire-pulse wireplumber; do
    if systemctl --user is-enabled "$svc" &>/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $svc (user) enabled"
    else
        echo -e "${YELLOW}⚠${NC} $svc (user) — will auto-start with desktop session"
    fi
done

for cmd in sway waybar ghostty tmux zsh stow kanshi; do
    if command -v "$cmd" &>/dev/null; then
        echo -e "${GREEN}✓${NC} $cmd available"
    else
        echo -e "${RED}✗${NC} $cmd not found in PATH"
        validation_ok=false
    fi
done

if [[ "$SHELL" == *"zsh"* ]]; then
    echo -e "${GREEN}✓${NC} Default shell is zsh"
else
    echo -e "${YELLOW}⚠${NC} Default shell is not zsh (will take effect after re-login)"
fi

if [[ "$validation_ok" == false ]]; then
    echo ""
    echo -e "${YELLOW}⚠${NC} Some checks failed — review the output above"
fi

# ── Summary ─────────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}    Bootstrap complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}Manual steps remaining:${NC}"
echo -e "  1. Log out and back in (docker group + shell change)"
echo -e "  2. Configure monitor profiles in ~/.config/kanshi/config"
echo -e "  3. Resolve any stow conflicts printed above"
echo -e "  4. In tmux: prefix + I (if tpm plugin install didn't run)"
echo -e "  5. Move snapshots to dedicated SSD (see README → Snapshots & Backup)"
echo ""
