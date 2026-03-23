# Dotfiles

Arch Linux (CachyOS) desktop environment built on **Sway** (Wayland), **Ghostty**, **Tmux** (Dracula theme), and **Waybar**. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

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
| Status Bar | Waybar (Dracula theme, pill modules) |
| Terminal | Ghostty |
| Multiplexer | Tmux (Dracula theme, prefix: `Ctrl+Space`) |
| Shell | Zsh + Oh My Zsh + Zinit |
| Prompt | Starship |
| App Launcher | Vicinae |
| Browser | Zen Browser |
| File Manager | Nautilus / Yazi (TUI) |
| Editor | Helix / Zed / VS Code |
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
| `helix` | Modal text editor config |
| `lazygit` | Git TUI config + keybindings |
| `rofi` | Launcher/menu themes (powermenu, power-profiles) |
| `starship` | Shell prompt config |
| `sway` | Window manager config + scripts |
| `swaylock` | Lock screen config |
| `tmux` | Multiplexer config + Dracula theme |
| `vscode` | VS Code settings |
| `waybar` | Status bar config + Dracula style |
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

## License

MIT License. See [LICENSE](LICENSE).
