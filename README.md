# Dotfiles

Personal layer on top of [**Omarchy**](https://omarchy.org/) (Arch + Hyprland), with **Ghostty** and **Tmux**. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Omarchy provides the compositor, shell (bar/notifications/menus), theming, login, screenshots and clipboard history. This repo layers on personal packages, Hyprland overrides that restore the sway keymap from the `wayland` branch, and the usual terminal/editor/shell configs.

## Quick Start

### One-liner (fresh Omarchy machine)

```bash
bash <(curl -s https://raw.githubusercontent.com/SeanoNET/dotfiles/omarchy/bootstrap-packages.sh)
```

Installs the packages Omarchy doesn't ship (official, AUR, flatpak), fonts, CLI tools, shell setup, stow symlinks, and post-install config in one shot.

### Manual setup

```bash
git clone -b omarchy https://github.com/SeanoNET/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap-packages.sh
```

---

## Stack

| Layer | Tool |
|-------|------|
| Base | Omarchy (Arch Linux) |
| Window Manager | Hyprland |
| Status Bar / Notifications / Menus | Omarchy shell (Quickshell) |
| Terminal | Ghostty |
| Multiplexer | Tmux (Tokyo Night theme, prefix: `Ctrl+Space`) |
| Shell | Zsh + Oh My Zsh + Zinit |
| Prompt | Starship |
| App Launcher | Omarchy menu (`Super+Space`) |
| Browser | Zen Browser |
| File Manager | Nautilus / Yazi (TUI) |
| Editor | Neovim (LazyVim) / Zed / VS Code |
| Git TUI | Lazygit |
| Audio | PipeWire + WirePlumber + Wiremix (TUI) |
| Bluetooth | Bluetuith (TUI) |
| Music | spotify-player (TUI) |
| Clipboard | Omarchy clipboard manager |
| Lock Screen | Omarchy (hyprlock) |
| Web Apps | `omarchy webapp install` |

---

## Keybindings

`Mod` = Super/Windows key.

Omarchy's defaults stay in place except where they collided with the sway
keymap this config came from. Every override lives in
[`hypr/.config/hypr/bindings.lua`](hypr/.config/hypr/bindings.lua), each one
annotated with what Omarchy had on that key and where it moved to.

Print the full live map (Omarchy defaults + these overrides) with:

```bash
omarchy menu keybindings --print
```

### Overridden from Omarchy defaults

| Key | Action | Omarchy default (moved to) |
|-----|--------|----------------------------|
| `Mod+q` | Close window | was `Mod+w` |
| `Mod+w` | Browser (zen, workspace 2) | Close window (→ `Mod+q`) |
| `Mod+h/j/k/l` | Focus left/down/up/right | `j` split, `k` keybindings (→ `Mod+F1`), `l` layout (→ `Mod+Alt+l`) |
| `Mod+Shift+h/j/k/l` | Swap window left/down/up/right | — |
| `Mod+Return` | Terminal + tmux, pinned to workspace 1 | Terminal |
| `Mod+e` | Editor (Zed, workspace 1) | — (Omarchy's editor was `Mod+Shift+n`) |
| `Mod+n` | File manager (workspace 3) | — |
| `Mod+m` | Music TUI popup | — |
| `Mod+d` | Apps menu | — |
| `Mod+t` | Focus tablet (scrcpy) | Toggle floating (→ `Mod+Shift+Space`) |
| `Mod+r` | Resize mode (`hjkl`/arrows, `Esc`/`Return` to exit) | — |
| `Mod+v` | Clipboard manager | Universal paste (dropped) |
| `Mod+\` | Toggle window split | was `Mod+j` |
| `Mod+Tab` | Former workspace | Next workspace (→ `Mod+Ctrl+Tab`) |
| `Mod+Ctrl+Tab` | Next workspace | Former workspace (→ `Mod+Tab`) |
| `Mod+F1` | Keybindings cheatsheet | was `Mod+k` |
| `Mod+Shift+Space` | Toggle floating/tiling | Toggle top bar (→ `Mod+Shift+Alt+Space`) |
| `Mod+Shift+n` | Open next empty workspace | Editor (→ `Mod+e`) |
| `Mod+Shift+s` | Screenshot region to clipboard | Google Maps (dropped) |
| `Mod+Shift+x` | Lock screen | X webapp (dropped) |
| `Mod+Shift+p` | Power menu | Google Photos (dropped) |
| `Mod+Shift+r` | Reload Hyprland config | — |

### Kept from Omarchy

These already matched the sway map, or were close enough to keep:

| Key | Action |
|-----|--------|
| `Mod+f` | Fullscreen |
| `Mod+s` | Toggle scratchpad |
| `Mod+g` | Toggle window grouping (sway's tabbed layout) |
| `Mod+Space` | Omarchy menu |
| `Mod+1-0` | Switch to workspace 1-10 |
| `Mod+Shift+1-0` | Move window to workspace 1-10 |
| `Mod+Shift+Tab` | Previous workspace |
| `Mod+arrows` | Focus left/down/up/right |
| `Mod+Shift+arrows` | Swap window |
| `Print` | Screenshot |
| `XF86Audio*` / `XF86MonBrightness*` | Volume, media and brightness |

### Not carried over

`Mod+a` (focus parent) and `Mod+s` (stacking layout) have no Hyprland
equivalent. Grouping (`Mod+g`) covers the tabbed case.

---

## Popup TUIs

`popup-tui` opens a TUI in a centered floating Ghostty window, or focuses the
existing one if it's already open:

```bash
popup-tui wiremix                    # default size (900x600)
popup-tui --size 1400x800 spotify_player
```

It launches Ghostty with a `com.popup.<name>` class, which the window rules in
[`hypr/.config/hypr/windows.lua`](hypr/.config/hypr/windows.lua) match to float,
centre and size the window. Bound to `Mod+m` for the music TUI.

Omarchy's own bar panels cover the rest of what the waybar modules did:
`Mod+Ctrl+a` audio, `Mod+Ctrl+b` bluetooth, `Mod+Ctrl+w` network,
`Mod+Ctrl+t` activity (btop).

### launch-or-open

`launch-or-open <class-regex> <workspace> <command...>` puts the first instance
of an app on a dedicated workspace and opens later instances on the current one.
Used by the `Mod+Return`, `Mod+e`, `Mod+w` and `Mod+n` bindings.

---

## Web Apps

Web apps run as frameless browser windows that feel like native desktop apps,
and show up in the Omarchy apps menu (`Mod+d`).

```bash
omarchy webapp install "App Name" "https://example.com"
omarchy webapp remove "App Name"
omarchy launch webapp "https://example.com"
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
| `hypr` | Hyprland overrides on top of Omarchy's defaults |
| `lazygit` | Git TUI config + keybindings |
| `nvim` | Neovim (LazyVim) config |
| `omarchy` | Helper scripts (`launch-or-open`, `popup-tui`, `empty-workspace`) |
| `starship` | Shell prompt config |
| `tmux` | Multiplexer config + Tokyo Night theme |
| `vscode` | VS Code settings |
| `yazi` | Terminal file manager config |
| `zed` | Code editor config |
| `zsh` | Shell config (zinit, aliases, integrations) |

### Symlink / Unsymlink

```bash
cd ~/dotfiles
stow hypr          # symlink Hyprland overrides
stow -D hypr       # remove symlinks
stow --restow hypr # re-symlink (useful after changes)
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

Plugins: Dracula theme, tmux-resurrect, tmux-tilish, tmux-command-palette, tmux-fzf, tmux-menus.

---

## Zsh

Aliases: `vim` = helix, `sp` = spotify_player, `ls/ll/la` = eza.

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
## [Wallpapers](background/.config/backdrops/)

<div align="center"><em>Digital scans of artwork by Albert Bierstadt</em></div>

<table>
  <tr>
    <td colspan="2" align="center">
      <img src="background/.config/backdrops//Buffalo Trail-The Impending Storm.jpg" alt="Buffalo Trail-The Impending Storm"><br>
      <em>Buffalo Trail-The Impending Storm</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="background/.config/backdrops/Estes Park Colorado Whyte's Lake.jpg" alt="Estes Park Colorado Whyte's Lake"><br>
      <em>Estes Park Colorado Whyte's Lake</em>
    </td>
    <td align="center">
      <img src="background/.config/backdrops//The coming storm.jpg" alt="The coming storm"><br>
      <em>The coming storm</em>
    </td>
  </tr>
</table>
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
