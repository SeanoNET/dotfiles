# Dotfiles

This repository contains my personal configuration files (dotfiles) for various applications and tools. It is managed using [GNU Stow](https://www.gnu.org/software/stow/), which makes it easy to symlink the configuration files to their appropriate locations.

## Table of Contents
- [Applications](#applications)
- [Installation](#installation)
- [Usage](#usage)
- [Applications Overview](#applications-overview)

---

## Applications

The following applications have configuration files in this repository:

1. **i3** - Tiling window manager.
2. **Polybar** - Status bar for window managers.
3. **Alacritty** - GPU-accelerated terminal emulator.
4. **Rofi** - Application launcher and window switcher.
5. **Starship** - Minimal, blazing-fast shell prompt.
6. **Picom** - Compositor for X11.
7. **Zsh** - Shell configuration with Oh My Zsh.
8. **Zoxide** - A smarter `cd` command.
9. **FZF** - A command-line fuzzy finder.
10. **Bat** - A cat clone with syntax highlighting.
11. **Eza** - A modern replacement for `ls`.
12. **Git-Delta** - A syntax-highlighting pager for git.
13. **glow** - A markdown viewer in the terminal.
14. **thunar** - File Manager GUI
15. **OnePassword CLI** - Password manager
16. **[git flow](https://github.com/nvie/gitflow)** - CLI tool to assist with gitflow
17. **[GH CLI](https://cli.github.com/)
18. **Lazygit** - A terminal UI for git commands.
19. **Tmux** - A terminal multiplexer.
---

## Installation

### One-liner (fresh Arch/EndeavourOS machine)

```bash
bash <(curl -s https://raw.githubusercontent.com/SeanoNET/dotfiles/main/bootstrap-packages.sh)
```

This installs all packages, AUR helpers, fonts, CLI tools, shell setup, stow symlinks, and post-install config in one shot.

### Manual setup
1. Clone this repository:
   ```bash
   git clone https://github.com/SeanoNET/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```
2. Run the bootstrap script:
   ```bash
   ./bootstrap-packages.sh
   ```
### Windows Prerequisites
1. Install [Scoop](https://scoop.sh/):
   ```powershell
   iwr -useb get.scoop.sh | iex
   ```
2. Install GNU Stow via Scoop:
   ```powershell
   scoop install stow
   ```
3. Clone this repository:
   ```powershell
   git clone https://github.com/SeanoNET/dotfiles.git $HOME\.dotfiles
   cd $HOME\.dotfiles
   ```

### Install Applications
Ensure the following applications are installed on your system:

- **i3**: Install via your package manager (e.g., `sudo apt install i3` or `sudo pacman -S i3`).
- **Polybar**: Install via your package manager (e.g., `sudo apt install polybar` or `sudo pacman -S polybar`).
- **Alacritty**: Install via your package manager (e.g., `sudo apt install alacritty` or `sudo pacman -S alacritty`).
- **Rofi**: Install via your package manager (e.g., `sudo apt install rofi` or `sudo pacman -S rofi`).
- **Starship**: Install via [Starship's installation guide](https://starship.rs/).
- **Picom**: Install via your package manager (e.g., `sudo apt install picom` or `sudo pacman -S picom`).
- **Zsh**: Install via your package manager (e.g., `sudo apt install zsh` or `sudo pacman -S zsh`).
  - Install [Oh My Zsh](https://ohmyz.sh/).

For Windows:
- **Alacritty**: Install via Scoop (`scoop install alacritty`).
- **Starship**: Install via Scoop (`scoop install starship`).
- **Zsh**: Install via Scoop (`scoop install zsh`).
  - Install [Oh My Zsh](https://ohmyz.sh/) (requires WSL or Cygwin).

For additional tools:
- **Zoxide**:
  - Linux: Install via your package manager (e.g., `sudo apt install zoxide` or `sudo pacman -S zoxide`).
  - Windows: Install via Scoop (`scoop install zoxide`).
- **FZF**:
  - Linux: Install via your package manager (e.g., `sudo apt install fzf` or `sudo pacman -S fzf`).
  - Windows: Install via Scoop (`scoop install fzf`).
- **Bat**:
  - Linux: Install via your package manager (e.g., `sudo apt install bat` or `sudo pacman -S bat`).
  - Windows: Install via Scoop (`scoop install bat`).
- **Eza**:
  - Linux: Install via your package manager (e.g., `sudo apt install exa` or `sudo pacman -S exa`).
  - Windows: Install via Scoop (`scoop install eza`).
- **Git-Delta**:
  - Linux: Install via your package manager (e.g., `sudo apt install delta` or `sudo pacman -S git-delta`).
  - Windows: Install via Scoop (`scoop install delta`).
- **Glow**:
  - Linux: Install via your package manager (e.g., `sudo apt install glow` or `sudo pacman -S glow`).
  - Windows: Install via Scoop (`scoop install glow`).

---

## Usage

### Symlink Configurations
To symlink the configuration files for a specific application, use GNU Stow. For example:

```bash
stow i3
stow polybar
stow alacritty
stow rofi
stow starship
stow picom
stow zsh
```

For Windows:
Use GNU Stow in PowerShell or Command Prompt:
```powershell
stow alacritty
stow starship
stow zsh
```

### Unlink Configurations
To remove the symlinks created by Stow, use the `-D` flag:

```bash
stow -D i3
stow -D polybar
stow -D alacritty
stow -D rofi
stow -D starship
stow -D picom
stow -D zsh
```

For Windows:
```powershell
stow -D alacritty
stow -D starship
stow -D zsh
```

---

## Applications Overview

### i3
- **Description**: A tiling window manager.
- **Configuration**: Located in `i3/.config/i3/config` and `i3/.config/i3/keybindings`.
- **Key Features**:
  - **Mod Key**: Set to `Mod4` (Windows key).
  - **Terminal/Browser/Files**: Configured to use `alacritty`, `zen-browser`, and `thunar` respectively.
  - **Font**: `JetBrains Mono 10` for window titles.
  - **Startup Applications**: Automatically launches `picom`, `Discord`, `Steam`, `Spotify`, `dunst` (for notifications), and sets up monitors via `monitor.sh`.
  - **Polybar Integration**: Launches Polybar on startup.
  - **Workspace Layout**: Default tiling mode with custom inner (6px) and outer (3px) gaps.
  - **Scratchpad**: Configured for `alacritty` with `Mod+space` to show/hide.
  - **Workspace Management**:
    - `Mod+Tab`/`Mod+Shift+Tab`: Navigate next/previous workspace.
    - `Mod+1-5`: Switch to specific workspaces.
    - `Mod+Shift+1-5`: Move focused container to specific workspaces.
    - `Mod+Shift+n`: Open new empty workspace.
  - **Window Management**:
    - `Mod+q`: Kill focused window.
    - `Mod+e`: Toggle window layout (split horizontal/vertical, tabbed, stacking).
    - `Mod+f`: Toggle fullscreen.
    - `Mod+Shift+space`: Toggle floating mode.
    - `Mod+a`: Focus parent container.
  - **Navigation**: Uses `h/j/k/l` for focus and `Mod+Shift+h/j/k/l` to move focused windows.
  - **Splitting**: `Mod+\` for horizontal split, `Mod+-` for vertical split.
  - **System Control**:
    - `Mod+b`: Lock screen with a blur effect.
    - `Mod+Shift+c`: Reload i3 configuration.
    - `Mod+Shift+r`: Restart i3 in place.
  - **Multimedia Keys**: Configured for volume control (`XF86AudioRaise/LowerVolume`, `XF86AudioMute`), microphone mute (`XF86AudioMicMute`), and media playback (`XF86AudioPlay/Next/Prev`).
  - **Application Shortcuts**:
    - `Mod+Return`: Launch terminal (with tmux session management).
    - `Mod+w`: Launch browser.
    - `Mod+n`: Launch file manager.
    - `Print`: Take screenshot.
    - `Mod+Shift+s`: Launch `flameshot` for screen capture.
    - `Mod+Shift+p`: Launch Power Profiles menu via Rofi.
  - **Rofi Integration**:
    - `Mod+d`: Application launcher.
    - `Mod+t`: Window switcher.
  - **Workspace Assignments**: Specific applications (Alacritty, Zen-browser, Thunar, Thunderbird, VS Code, JetBrains Rider, Zed, Discord, Spotify, Steam) are assigned to dedicated workspaces.
  - **Autostart**: Includes `polkit-gnome-authentication-agent-1`, `dex`, `feh` for wallpaper, `xset` for display power savings, `dunst` for notifications, and `autotiling.py`.
  - **Floating Rules**: Defines rules for applications that should open as floating windows (e.g., `Yad`, `Pavucontrol`).
  - **Color Settings**: Custom color definitions for window borders and backgrounds.
- **Key Features**:
  - Custom keybindings.
  - Integration with Polybar.
  - Scripts for power management, volume control, and more.

### Polybar
- **Description**: A status bar for window managers.
- **Configuration**: Located in `polybar/.config/polybar/config.ini` and `polybar/.config/polybar/launch_polybar.sh`.
- **Key Features**:
  - **Appearance**: Custom background and foreground colors, `JetBrainsMono Nerd Font Mono`.
  - **Modules**: Displays information on:
    - **Workspaces**: `xworkspaces` with custom icons for different workspaces (code, term, files, mail, web).
    - **Window Title**: `xwindow` to show the title of the active window.
    - **System Updates**: `pacman-updates` to show pending Arch Linux updates.
    - **Temperature**: `temperature` module.
    - **i3 Layout**: Custom script `i3layout.sh` to display the current i3 layout.
    - **Keybindings Hint**: Custom script `keyhint` to show keybinding hints.
    - **Filesystem**: `filesystem` module showing free space for the root partition.
    - **Spotify**: Custom scripts for displaying current song, and controls for previous, play/pause, and next track.
    - **Pulseaudio**: Volume control with a visual bar.
    - **Memory**: Displays used memory.
    - **CPU**: Displays CPU usage.
    - **Battery**: Shows battery status with charging animation and capacity ramp.
    - **Network**: `wlan` module for wireless network status.
    - **MPD**: Music Player Daemon controls.
    - **Powermenu**: Custom menu for reboot and power off options.
    - **Date/Time**: Displays current date and time.
  - **IPC Enabled**: Allows for inter-process communication.
  - **Launch Script**: `launch_polybar.sh` ensures proper launch and reloads.

### Alacritty
- **Description**: A GPU-accelerated terminal emulator.
- **Configuration**: Located in `alacritty/.config/alacritty/alacritty.toml`.
- **Key Features**:
  - **Font**: `JetBrains Mono` at size `14.0`.
  - **Window Opacity**: `0.9` for a transparent background effect.
  - **Selection**: Automatically saves selected text to the clipboard.

### Background
- **Description**: Custom background image.
- **Configuration**: Located in `background/.config/background.jpeg`.
- **Key Features**:
  - A visually appealing background image for your desktop environment.

### Rofi
- **Description**: An application launcher and window switcher.
- **Configuration**: Located in `rofi/.config/rofi/` with `config.rasi` as the main configuration, and additional themes like `power-profiles.rasi`, `powermenu.rasi`, `rofidmenu.rasi`, and `rofikeyhint.rasi`.
- **Key Features**:
  - **Theme**: Uses `spotlight-dark.rasi`.
  - **Modi**: Configured for `run`, `window`, and `combi` modes.
  - **Icons**: Displays icons using the `Oranchelo` icon theme.
  - **Terminal**: Uses `alacritty` for launching applications.
  - **Display Formats**: Custom display formats for `combi`, `run`, and `window` modes.
  - **Font**: Uses `JetBrains Mono`.
  - **Sidebar Mode**: Enabled for better navigation.

### Starship
- **Description**: A minimal, blazing-fast shell prompt.
- **Configuration**: Located in `starship/.config/starship.toml`.
- **Key Features**:
  - **Custom Format**: Displays directory, git branch, git status, Docker context, command duration, and time.
  - **New Line**: Adds a new line after the prompt.
  - **Color Palette**: Uses the `nord` color palette.
  - **Directory Module**: Styled with bold dark blue, truncates path to 3 characters, and truncates to the repository root.
  - **Time Module**: Enabled, displays time in `HH:MM` format, with a UTC offset of -5 hours, and only shows between 10:00:00 and 14:00:00.
  - **Git Branch Module**: Displays the current git branch with a green color and a branch symbol.
  - **Git Status Module**: Shows all git status changes and ahead/behind status.
  - **Docker Context Module**: Displays the Docker context with a Docker symbol, detecting `docker-compose.yml`, `docker-compose.yaml`, and `Dockerfile`.
  - **Command Duration Module**: Shows the duration of commands that take longer than 500ms.
  - **Custom Palettes**: Includes definitions for `nord` and `onedark` color palettes.

### Picom
- **Description**: A compositor for X11.
- **Configuration**: Located in `picom/.config/picom/picom.conf`.
- **Key Features**:
  - **Backend**: Uses `glx` for rendering.
  - **VSync**: Enabled for tear-free rendering.
  - **Rendering Optimizations**: Includes `glx-use-copysubbuffer-mesa`, `glx-copy-from-front`, `glx-swap-method = 2`, `xrender-sync`, and `xrender-sync-fence` for improved performance and visual quality.

### Zsh
- **Description**: A powerful shell with Oh My Zsh.
- **Configuration**: Located in `zsh/.zshrc`.
- **Key Features**:
  - **Environment Variables**: Sets `QT_QPA_PLATFORMTHEME` for Qt applications.
  - **Zinit**: Used as a plugin manager for:
    - **Plugins**:
      - `zsh-syntax-highlighting`: Provides syntax highlighting for commands.
      - `zsh-completions`: Enhanced completion for Zsh.
      - `zsh-autosuggestions`: Suggests commands as you type based on history.
      - `fzf-tab`: Adds fzf-powered tab completion.
    - **Snippets**:
      - `git.zsh`, `git`, `sudo`, `archlinux`, `azure`, `kubectl`, `kubectx`, `command-not-found`.
  - **Completions**: Configures completion styling, including `fzf-tab` previews for `cd` and `zoxide`.
  - **Keybindings**:
    - `Ctrl+p`: History search backward.
    - `Ctrl+n`: History search forward.
  - **Aliases**:
    - `vim`: Aliased to `helix`.
    - `c`: Aliased to `clear`.
    - `ls`, `ll`, `la`, `l`: Aliased to `eza` with various options for enhanced directory listings.
    - `sp`: Aliased to `spotify_player`.
  - **Shell Integrations**:
    - `fzf`: Integrated for fuzzy finding.
    - `zoxide`: Integrated for smart directory navigation.
  - **Oh My Zsh Plugins**: Includes `git`, `starship`, `azure`, `docker`, `docker-compose`, `history`, `zsh-interactive-cd`, `ssh-agent`.
  - **Git Flow Completion**: Sources `git-flow-completion.zsh`.
  - **NVM**: Configures Node Version Manager.

### Zoxide
- **Description**: A smarter `cd` command for navigating directories.
- **Configuration**: No specific configuration required.
- **Key Features**:
  - Tracks directory usage and provides fast navigation.

### FZF
- **Description**: A command-line fuzzy finder.
- **Configuration**: Can be integrated with shell scripts and commands.
- **Key Features**:
  - Interactive search for files, directories, and more.

### Bat
- **Description**: A `cat` clone with syntax highlighting and Git integration.
- **Configuration**: No specific configuration required.
- **Key Features**:
  - Syntax highlighting for code.
  - Git diff integration.

### Eza
- **Description**: A modern replacement for `ls`.
- **Configuration**: No specific configuration required.
- **Key Features**:
  - Improved formatting and colorized output.
  - Git-aware file listings.

### Git
- **Description**: Git version control system configuration.
- **Configuration**: Located in `git/.gitconfig`.
- **Key Features**:
  - **User Information**: Configures your Git user name and email.
  - **Delta Integration**: Uses `git-delta` for enhanced diff viewing.
    - `delta` is set as the default pager for `git diff`.
    - `delta` is used for interactive diff filtering.
    - Navigation within `delta` is enabled (`n` and `N` to move between diff sections).
    - `delta` is configured with a dark theme.
  - **Merge Conflict Style**: `zdiff3` is used for displaying merge conflicts, providing a more detailed view.

### Lazygit
- **Description**: A terminal UI for git commands.
- **Configuration**: Located in `lazygit/.config/lazygit/config.yml`.
- **Key Features**:
  - Custom keybindings for enhanced productivity.
  - **`v` (in local branches view):** Checks out a GitHub pull request by letting you select from a list of open PRs.
  - **`ctrl+r` (global):** Opens a browser to create a GitHub pull request.
  - **`ctrl+v` (global):** Prompts for input to create a conventional commit.

### Tmux
- **Description**: A terminal multiplexer.
- **Configuration**: Located in `tmux/.config/tmux/tmux.conf`.
- **Key Features**:
  - **Prefix**: `Ctrl+Space`.
  - **Reload Config**: `prefix + r`.
  - **Window/Pane Splitting**:
    - `prefix + |`: Split pane horizontally.
    - `prefix + -`: Split pane vertically.
  - **Pane Navigation**: `prefix + h/j/k/l` (vi-style).
  - **Pane Resizing**: `prefix + Ctrl + h/j/k/l`.
  - **Lazygit Integration**: `prefix + g` opens Lazygit in a popup.
  - **Plugins**: Managed with `tpm`, includes `dracula` theme, `tmux-resurrect` for session saving, `tmux-command-palette`, and `tmux-tilish` - see https://github.com/jabirali/tmux-tilish?tab=readme-ov-file#keybindings.
  

### Helix
- **Description**: A post-modern modal text editor.
- **Configuration**: Located in `helix/.config/helix/config.toml`.
- **Key Features**:
  - **Theme**: `jetbrains_dark`.
  - **Editor Settings**: Relative line numbers, mouse support, and true color enabled.
  - **Cursor Shapes**: Customized for insert (`bar`), normal (`block`), and select (`underline`) modes.
  - **File Picker**: Shows hidden files.
  - **Status Line**: Custom status line displaying mode, file name, version control, diagnostics, selections, position, encoding, line ending, and file type.
  - **Keybindings**: `jk` mapped to exit insert mode.

### Zed
- **Description**: A high-performance, collaborative code editor.
- **Configuration**: Located in `zed/.config/zed/settings.json` and `zed/.config/zed/keymap.json`.
- **Key Features**:
  - **Languages**: Rust language settings disable edit predictions.
  - **Assistant**: Uses `gpt-4o-mini` as the default AI model.
  - **Font Sizes**: UI font size set to `16` and buffer font size to `17.0`.
  - **Theme**: Uses the `One Dark` theme in dark mode.
  - **Keymap**: Base keymap set to `VSCode`.
  - **Cursor**: Cursor shape set to `block`.
  - **Line Numbers**: Relative line numbers are enabled and toggled in Vim mode.
  - **Keybindings**:
    - `ctrl-d`: Duplicates the current line down.

## Windows Configuration

### Xprofile
- **Description**: Script executed by the display manager at the start of the X user session.
- **Configuration**: Located in `xprofile/.xprofile`.
- **Key Features**:
  - **Gnome Keyring**: Starts the `gnome-keyring-daemon` to manage passwords and SSH keys.
  - **SSH Agent**: Exports `SSH_AUTH_SOCK` to enable SSH agent forwarding.

### PowerShell Profile
- **Description**: Customizations for the PowerShell console.
- **Configuration**: Located in `Windows/dotfiles/PowerShell/Microsoft.PowerShell_profile.ps1`.
- **Key Features**:
  - **Module Imports**: Imports `posh-git`, `oh-my-posh`, `DockerCompletion`, and `Terminal-Icons`.
  - **Admin Prompt**: Customizes the prompt to indicate if running as an administrator.
  - **Oh My Posh Theme**: Loads the `seanonetdev.omp.json` theme for a rich, informative prompt.
  - **PSReadLine Key Handlers**: Enhances command-line editing with:
    - History search (`UpArrow`, `DownArrow`).
    - Smart insertion of quotes, parentheses, and braces.
    - Clipboard pasting as here-string (`Ctrl+V`).
    - Word movement and selection (`Alt+d`, `Alt+Backspace`, `Alt+b`, `Alt+f`, `Alt+B`, `Alt+F`).
    - Saving current line to history without execution (`Alt+w`).
    - Toggling quotes on arguments (`Alt+'`).
    - Expanding aliases (`Alt+%`).
    - Command help (`F1`).
    - Directory marking and jumping (`Ctrl+J`, `Ctrl+j`, `Alt+j`).
    - Auto-correction for `git cmt` to `git commit`.
    - Accepting next suggestion word (`RightArrow`).
    - Cycling through command arguments (`Alt+a`).
  - **Custom Commands**: `Ctrl+Shift+b` for `dotnet build` and `Ctrl+Shift+t` for `dotnet test`.
  - **Zoxide Integration**: Initializes Zoxide for smart directory navigation.
  - **Aliases**: Custom aliases for `tail`, `df`, `uptime`, `Get-PubIP`, `la`, `ll`, and `ep` (edit profile).

### Oh My Posh Theme
- **Description**: Custom theme for Oh My Posh, defining the appearance of the PowerShell prompt.
- **Configuration**: Located in `Windows/dotfiles/PowerShell/seanonetdev.omp.json`.
- **Key Features**:
  - **Segments**: Displays information such as OS, current path, Git status (branch, changes, ahead/behind, stash count), Go version, Julia version, Python version, Ruby version, Azure Functions version, AWS profile/region, and root status.
  - **Styling**: Uses powerline symbols and custom background/foreground colors for different segments.
  - **Icons**: Incorporates various Unicode icons for visual cues.
  - **Console Title**: Sets the console title to the current folder name.

### Yazi
- **Description**: A terminal file manager.
- **Configuration**: Located in `yazi/.config/yazi/yazi.toml`.
- **Key Features**:
  - **Show Hidden Files**: Configured to display hidden files in the file manager.
  - **Editor Integration**: Uses `helix` as the default editor for opening files, blocking the terminal until `helix` exits.

---

## Dual Monitor + KVM Setup (Top-Down View)

For my reference: 

```
                        MONITOR SETUP (TOP-DOWN VIEW)

   ┌────────────────────┐           ┌────────────────────────────┐
   │  Alienware 34"     │           │   Dell Monitor w/ KVM      │
   │  (DP1 IN / HDMI2)  │           │   (HDMI1 IN / DP2 IN / USB)│
   └────────┬───────────┘           └────────────┬───────────────┘
            │                                     │
     DP from Desktop                    HDMI from Desktop
     HDMI from Laptop Dock             DP from Laptop Dock
                                        USB from Desktop → KVM
            │                                     │
            └────────┐                  ┌─────────┘
                     │                  │
        ┌────────────▼──────────────────▼────────────┐
        │                KVM USB HUB (in Dell)       │
        └────────────────┬──────────────┬────────────┘
                         │              │
         USB from Desktop PC     USB from Laptop Dock

                         ▼              ▼

                 ┌────────────┐   ┌──────────────┐
                 │ Desktop PC │   │ Laptop + Dock│
                 └────────────┘   └──────────────┘
```

## Key Flow Summary

- **Alienware 34" Monitor**
  - DisplayPort ← from Desktop PC (for 240Hz)
  - HDMI ← from Laptop Dock

- **Dell Monitor with KVM**
  - HDMI ← from Desktop PC
  - DisplayPort ← from Laptop Dock
  - USB (KVM input) ← from both Desktop & Dock

- **KVM Switching** allows keyboard/mouse to follow whichever device is selected.

---
## Contributing

Feel free to fork this repository and submit pull requests for improvements or additional configurations.

---
## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
