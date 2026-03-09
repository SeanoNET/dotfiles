# Dotfiles

Arch Linux (CachyOS) desktop environment built on **Sway** (Wayland), **Ghostty**, **Tmux** (Tokyo Night theme), and **Waybar**. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

### One-liner (fresh Arch/EndeavourOS machine)

```bash
bash <(curl -s https://raw.githubusercontent.com/SeanoNET/dotfiles/wayland/bootstrap-packages.sh)
```

Installs all packages (official, AUR, flatpak), fonts, CLI tools, shell setup, stow symlinks, and post-install config in one shot.

### Manual setup

```bash
git clone -b wayland https://github.com/SeanoNET/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap-packages.sh
```

---

## Stack

| Layer | Tool |
|-------|------|
| Window Manager | Sway |
| Status Bar | Waybar (Tokyo Night theme, pill modules) |
| Terminal | Ghostty |
| Multiplexer | Tmux (Tokyo Night theme, prefix: `Ctrl+Space`) |
| Shell | Zsh + Oh My Zsh + Zinit |
| Prompt | Starship |
| App Launcher | Vicinae |
| Browser | Zen Browser |
| File Manager | Nautilus / Yazi (TUI) |
| Editor | Vim / Zed / VS Code |
| Git TUI | Lazygit |
| Audio | PipeWire + WirePlumber + Wiremix (TUI) |
| Bluetooth | Bluetuith (TUI) |
| Music | spotify-player (TUI) |
| Clipboard | cliphist (wl-clipboard) |
| Lock Screen | swaylock |
| Web Apps | Chromium --app mode |

---

## Sway Keybindings

`Mod` = Super/Windows key

### Essentials

| Key | Action |
|-----|--------|
| `Mod+Return` | Terminal (ghostty + tmux) |
| `Mod+d` | App launcher (vicinae) |
| `Mod+w` | Browser (zen-browser) |
| `Mod+n` | File manager (nautilus) |
| `Mod+q` | Kill focused window |
| `Mod+Shift+r` | Reload sway config |
| `Mod+Shift+x` | Lock screen |
| `Mod+F1` | Keybinding cheatsheet |

### Navigation

| Key | Action |
|-----|--------|
| `Mod+h/j/k/l` | Focus left/down/up/right |
| `Mod+Shift+h/j/k/l` | Move window left/down/up/right |
| `Mod+1-0` | Switch to workspace 1-10 |
| `Mod+Shift+1-0` | Move window to workspace 1-10 |
| `Mod+Tab` | Toggle last workspace |
| `Mod+Shift+n` | Open new empty workspace |

### Layout

| Key | Action |
|-----|--------|
| `Mod+e` | Cycle layout (split h/v, tabbed, stacking) |
| `Mod+f` | Toggle fullscreen |
| `Mod+\` | Split horizontal |
| `Mod+-` | Split vertical |
| `Mod+Shift+Space` | Toggle floating |
| `Mod+r` | Resize mode (h/j/k/l to resize, Esc to exit) |
| `Mod+Space` | Toggle scratchpad terminal |

### Media / Screenshots

| Key | Action |
|-----|--------|
| `XF86Audio*` | Volume up/down/mute |
| `XF86AudioPlay/Next/Prev` | Media controls (playerctl) |
| `Print` | Screenshot (full screen, saved to ~/Pictures/) |
| `Mod+Shift+s` | Screenshot (region to clipboard) |
| `Mod+Shift+p` | Power profiles menu (rofi) |
| `Mod+v` | Clipboard history (cliphist + rofi) |

---

## Waybar Popup TUIs

Click modules in the status bar to open TUI tools in centered floating popups:

| Module | Left Click | Right Click |
|--------|-----------|-------------|
| Audio (pulseaudio) | Wiremix (audio mixer) | Toggle mute |
| Bluetooth | Bluetuith | - |
| Wifi / Ethernet | nmtui | - |
| CPU | btop | - |
| Memory | btop | - |
| Spotify | Play/pause | spotify_player TUI |

Scroll on Spotify module for next/prev track.

The popup system uses `sway/.config/sway/scripts/popup-tui.sh` which launches Ghostty with a custom `app_id` (`com.popup.<name>`) matched by sway floating rules.

---

## Web Apps

Web apps run as frameless Chromium windows (no tabs, no address bar) that feel like native desktop apps. They appear in Vicinae like regular applications.

### Install a web app

```bash
~/.config/sway/scripts/webapp install "App Name" "https://example.com"
```

This fetches a favicon and creates a `.desktop` file in `~/.local/share/applications/`.

### Launch a web app

```bash
~/.config/sway/scripts/webapp launch "https://example.com"
```

Focuses the existing window if already open, or launches a new one.

### List / Remove

```bash
~/.config/sway/scripts/webapp list
~/.config/sway/scripts/webapp remove "App Name"
```

### Examples

```bash
webapp install "YouTube" "https://youtube.com"
webapp install "GitHub" "https://github.com"
webapp install "ChatGPT" "https://chatgpt.com"
webapp install "Outlook" "https://outlook.office.com"
```

---

## Stow Packages

Each directory is a stow package that maps to `$HOME`:

| Package | Description |
|---------|-------------|
| `background` | Desktop wallpapers (~/.config/backdrops/) |
| `chromium` | Chromium Wayland flags (for web apps) |
| `ghostty` | Terminal config (opacity, font, shell) |
| `git` | Git config + delta pager |
| `kanshi` | Monitor profile switching |
| `vim` | Vim config (Tokyo Night theme) |
| `lazygit` | Git TUI config + keybindings |
| `rofi` | Launcher/menu themes (powermenu, power-profiles) |
| `starship` | Shell prompt config |
| `sway` | Window manager config + scripts |
| `swaylock` | Lock screen config |
| `tmux` | Multiplexer config + Tokyo Night theme |
| `vscode` | VS Code settings |
| `waybar` | Status bar config + Tokyo Night style |
| `yazi` | Terminal file manager config |
| `zed` | Code editor config |
| `zsh` | Shell config (zinit, aliases, integrations) |

### Symlink / Unsymlink

```bash
cd ~/dotfiles
stow sway          # symlink sway config
stow -D sway       # remove symlinks
stow --restow sway # re-symlink (useful after changes)
```

---

## Tmux

Prefix: `Ctrl+Space`

| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontal |
| `prefix + -` | Split vertical |
| `prefix + h/j/k/l` | Navigate panes |
| `prefix + Ctrl+h/j/k/l` | Resize panes |
| `prefix + g` | Lazygit popup |
| `prefix + r` | Reload config |
| `prefix + I` | Install plugins (tpm) |

Plugins: Tokyo Night theme, tmux-resurrect, tmux-tilish, tmux-command-palette, tmux-fzf, tmux-menus.

---

## Zsh

Aliases: `vi` = vim, `sp` = spotify_player, `ls/ll/la` = eza.

Plugins (via zinit): syntax-highlighting, autosuggestions, completions, fzf-tab.

Integrations: fzf, zoxide, nvm, starship prompt.

---

## Hardware Reference

```
                    MONITOR SETUP (TOP-DOWN VIEW)

   +--------------------+           +----------------------------+
   |  Alienware 34"     |           |   Dell Monitor w/ KVM      |
   |  (DP1 IN / HDMI2)  |           |   (HDMI1 IN / DP2 IN / USB)|
   +--------+-----------+           +------------+---------------+
            |                                     |
     DP from Desktop                    HDMI from Desktop
     HDMI from Laptop Dock             DP from Laptop Dock
                                        USB from Desktop -> KVM
            |                                     |
            +--------+                  +---------+
                     |                  |
        +------------v------------------v------------+
        |                KVM USB HUB (in Dell)       |
        +----------------+--------------+------------+
                         |              |
         USB from Desktop PC     USB from Laptop Dock

                 +------------+   +--------------+
                 | Desktop PC |   | Laptop + Dock|
                 +------------+   +--------------+
```

---

## Snapshots & Backup

Btrfs snapshots are managed with **Snapper** and **snap-pac**. The filesystem uses separate subvolumes (`@`, `@home`, `@root`, `@srv`, `@cache`, `@tmp`, `@log`) so each can be snapshotted and restored independently.

### What's automated

- **snap-pac** — automatically creates pre/post snapshots on every `pacman` transaction
- **snapper-timeline.timer** — creates hourly snapshots with automatic cleanup (5 hourly, 7 daily)
- **snapper-cleanup.timer** — prunes old snapshots based on retention limits

### Setup

```bash
# Enable timeline snapshots for / (root)
sudo sed -i 's/TIMELINE_CREATE="no"/TIMELINE_CREATE="yes"/' /etc/snapper/configs/root
sudo systemctl enable --now snapper-timeline.timer

# Add snapper config for /home
sudo snapper -c home create-config /home
sudo sed -i 's/TIMELINE_CREATE="no"/TIMELINE_CREATE="yes"/' /etc/snapper/configs/home
```

### Common commands

```bash
# List snapshots
snapper -c root list
snapper -c home list

# Create a manual snapshot
sudo snapper -c root create -d "before risky change"
sudo snapper -c home create -d "before risky change"

# Compare two snapshots (see what changed)
snapper -c root diff 1..2

# View file changes between snapshots
snapper -c root status 1..2
```

### Restoring a snapshot

**Restore a single file from a snapshot:**

```bash
# Find the snapshot number
snapper -c root list

# Snapshots live at /.snapshots/<number>/snapshot/
# Copy the file back from the snapshot
sudo cp /.snapshots/5/snapshot/etc/some-config /etc/some-config
```

**Restore home directory files:**

```bash
# Home snapshots live at /home/.snapshots/<number>/snapshot/
sudo cp /home/.snapshots/3/snapshot/username/somefile ~/somefile
```

**Undo changes between two snapshots (surgical rollback):**

```bash
# Undo all changes that happened between snapshot 1 and 2
sudo snapper -c root undochange 1..2

# Undo changes to specific files only
sudo snapper -c root undochange 1..2 /etc/some-config
```

**Full system rollback (boot into a previous snapshot):**

> This is for when the system won't boot or a major upgrade broke things.

```bash
# 1. Boot from a live USB or recovery
# 2. Mount the btrfs partition
sudo mount /dev/vda3 /mnt

# 3. The current broken root is at /mnt/@
#    Snapshots are at /mnt/@/.snapshots/<number>/snapshot

# 4. Move the broken subvolume out of the way
sudo mv /mnt/@ /mnt/@.broken

# 5. Snapshot the good snapshot as the new root
sudo btrfs subvolume snapshot /mnt/@.snapshots/<number>/snapshot /mnt/@

# 6. Unmount and reboot
sudo umount /mnt
reboot

# 7. After confirming everything works, delete the broken one
sudo btrfs subvolume delete /mnt/@.broken
```

### Dedicated snapshot drive (recommended)

Storing snapshots on a separate drive prevents them from consuming root partition space and protects against drive failure. This can be done at any time after install — snapper doesn't care where `/.snapshots` is mounted, existing snapshots on the old subvolume will be lost.

```bash
# 1. Identify the SSD (e.g. /dev/sdX)
lsblk

# 2. Format as btrfs
sudo mkfs.btrfs -L snapshots /dev/sdX

# 3. Create subvolumes for root and home snapshots
sudo mount /dev/sdX /mnt
sudo btrfs subvolume create /mnt/@snapshots-root
sudo btrfs subvolume create /mnt/@snapshots-home
sudo umount /mnt

# 4. Remove the default .snapshots subvolumes and create mount points
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo btrfs subvolume delete /home/.snapshots
sudo mkdir /home/.snapshots

# 5. Get the UUID of the snapshot SSD
sudo blkid /dev/sdX

# 6. Add to /etc/fstab
echo 'UUID=<ssd-uuid>  /.snapshots       btrfs  subvol=/@snapshots-root,defaults,noatime,compress=zstd  0 0' | sudo tee -a /etc/fstab
echo 'UUID=<ssd-uuid>  /home/.snapshots  btrfs  subvol=/@snapshots-home,defaults,noatime,compress=zstd  0 0' | sudo tee -a /etc/fstab

# 7. Mount and verify
sudo mount -a
findmnt /.snapshots
findmnt /home/.snapshots
```

### GUI

**btrfs-assistant** provides a graphical interface for browsing and restoring snapshots:

```bash
btrfs-assistant
```

---

## Resources

- [The Linux Book](https://thelinuxbook.com) — general Linux reference

---

## License

MIT License. See [LICENSE](LICENSE).
