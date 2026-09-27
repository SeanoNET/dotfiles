# Dotfiles

Personal layer on top of [**Omarchy**](https://omarchy.org/) (Arch + Hyprland), with **Ghostty** and **Tmux**. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Omarchy provides the compositor, shell (bar/notifications/menus), theming, login, screenshots and clipboard history. This repo layers on personal packages, a few Hyprland additions on top of Omarchy's default keybindings, and the usual terminal/editor/shell configs.

## Quick Start

Run `omarchy update` first — the bootstrap installs packages without a full
sync, so the system needs to be current.

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
| File Manager | Nautilus |
| Editor | Neovim (LazyVim) / Zed / VS Code |
| Git TUI | Lazygit |
| Audio | PipeWire + WirePlumber + Wiremix (TUI) |
| Bluetooth | Bluetuith (TUI) |
| Clipboard | Omarchy clipboard manager |
| Lock Screen | Omarchy (hyprlock) |
| Web Apps | `omarchy webapp install` |

---

## Keybindings

`Mod` = Super/Windows key.

Omarchy's default bindings are kept unchanged. The only additions live in
[`hypr/.config/hypr/bindings.lua`](hypr/.config/hypr/bindings.lua), all on
keys Omarchy leaves free.

Print the full live map (Omarchy defaults + these additions) with:

```bash
omarchy menu keybindings --print
```

### Added on top of Omarchy

| Key | Action |
|-----|--------|
| `Mod+q` | Close window (alongside Omarchy's `Mod+w`) |
| `Mod+Shift+h/j/k/l` | Swap window left/down/up/right |
| `Mod+r` | Resize mode (`hjkl`/arrows, `Esc`/`Return` to exit) |
| `Mod+e` | Editor (Zed, workspace 1) |
| `Mod+n` | File manager (workspace 3) |
| `Mod+d` | Apps menu (same as `Mod+Alt+Space`) |
| `Mod+F2` | Personal cheatsheet (modal TUI) |
| `Mod+Shift+r` | Reload Hyprland config |
| `Mod+Shift+s` | Screenshot region to clipboard (replaces Omarchy's Google Maps) |

---

## Modal TUIs

Omarchy tags a window `floating-window` to give it the standard modal
treatment — float, centre, 875x600 — from `default/hypr/apps/system.lua`.
Anything here opts into that rather than declaring its own float rules:

```bash
omarchy-launch-or-focus-tui --app-id=cheatsheet glow -p ~/dotfiles/CHEATSHEET.md
```

`omarchy-launch-or-focus-tui` focuses the window if it's already open, launches
it through `uwsm-app` + `xdg-terminal-exec` otherwise, and names it with the
given app-id. Tag that app-id in
[`hypr/.config/hypr/windows.lua`](hypr/.config/hypr/windows.lua) and override
only what differs:

```lua
o.window("^cheatsheet$", { tag = "+floating-window" })
o.window("^cheatsheet$", { size = { 1400, 900 } })
```

The cheatsheet is bound to `Mod+F2` and also appears in the Omarchy menu under
**Learn → Cheatsheet**, added by
[`omarchy/.config/omarchy/extensions/omarchy-menu.jsonc`](omarchy/.config/omarchy/extensions/omarchy-menu.jsonc).

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
| `bin` | Standalone utility scripts (`hermes-tunnel`, `install-appimage`, `shrink-video`) |
| `chromium` | Chromium Wayland flags (for web apps) |
| `ghostty` | Terminal config (opacity, font, shell) |
| `git` | Git config + delta pager |
| `hypr` | Hyprland overrides on top of Omarchy's defaults |
| `lazygit` | Git TUI config + keybindings |
| `mise` | Pinned toolchain (bun, claude, codex, gh, node, opencode) |
| `nvim` | Neovim (LazyVim) config |
| `omarchy` | Helper scripts (`launch-or-open`, `empty-workspace`) + menu extension |
| `starship` | Shell prompt config |
| `tmux` | Multiplexer config + Tokyo Night theme |
| `vscode` | VS Code settings |
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

Aliases: `vim` = helix, `ls/ll/la` = eza.

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

These are kept in the repo for reference only — they are not stowed. Omarchy
owns the wallpaper: set one with `omarchy theme` or drop files into
`~/.config/omarchy/themes/<theme>/backgrounds/`.

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

Snapshot creation and retention are **Omarchy's** — this repo doesn't configure
them. Omarchy installs its own snapper retention template for the root config,
enables `snapper-cleanup.timer`, and uses `limine-snapper-sync` for pre/post
pacman snapshots rather than `snapper-timeline.timer` (which it deliberately
leaves disabled).

```bash
snapper list-configs
snapper -c root list
sudo snapper -c root create -d "before risky change"
```

Boot into a previous snapshot from the Limine boot menu, or browse and restore
them graphically with `btrfs-assistant`.

### Offsite backup to Unraid

The one piece this repo does add: `smb/snapshot-backup.sh` rsyncs the latest
snapshot of each snapper config to `/mnt/unraid/backups/snapshots/<hostname>/`
on a weekly timer. It skips any config that doesn't exist and exits cleanly when
the SMB share is unreachable.

```bash
systemctl status snapshot-backup.timer
sudo systemctl start snapshot-backup.service   # run once, now
```

Needs credentials in `/etc/samba/credentials/unraid` (the bootstrap creates the
file with `CHANGEME` placeholders).

---

## Resources

- [The Linux Book](https://thelinuxbook.com) — general Linux reference

---

## License

MIT License. See [LICENSE](LICENSE).
