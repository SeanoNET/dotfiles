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
---

## Installation

### Prerequisites
1. Install GNU Stow:
   ```bash
   sudo apt install stow  # For Debian/Ubuntu
   sudo pacman -S stow    # For Arch-based distros
   ```
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
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
   git clone https://github.com/yourusername/dotfiles.git $HOME\.dotfiles
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
- **Configuration**: Located in `i3/.config/i3/`.
- **Key Features**:
  - Custom keybindings.
  - Integration with Polybar.
  - Scripts for power management, volume control, and more.

### Polybar
- **Description**: A status bar for window managers.
- **Configuration**: Located in `polybar/.config/polybar/`.
- **Key Features**:
  - Modules for Spotify, CPU usage, memory, and more.
  - Custom scripts for dynamic updates.

### Alacritty
- **Description**: A GPU-accelerated terminal emulator.
- **Configuration**: Located in `alacritty/.config/alacritty/`.
- **Key Features**:
  - JetBrains Mono font.
  - Transparent background.

### Rofi
- **Description**: An application launcher and window switcher.
- **Configuration**: Located in `rofi/.config/rofi/`.
- **Key Features**:
  - Custom themes for power menu and keybinding hints.

### Starship
- **Description**: A minimal, blazing-fast shell prompt.
- **Configuration**: Located in `starship/.config/starship.toml`.
- **Key Features**:
  - Git status integration.
  - Docker context display.

### Picom
- **Description**: A compositor for X11.
- **Configuration**: Located in `picom/.config/picom/`.
- **Key Features**:
  - GLX backend for smooth animations.
  - VSync enabled.

### Zsh
- **Description**: A powerful shell with Oh My Zsh.
- **Configuration**: Located in `zsh/.zshrc`.
- **Key Features**:
  - Syntax highlighting.
  - Auto-suggestions.
  - FZF integration.

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

### Git-Delta
- **Description**: A syntax-highlighting pager for git.
- **Configuration**: Can be configured in `.gitconfig`.
- **Key Features**:
  - Syntax highlighting for diffs.
  - Improved readability for git output.

### Windows-Specific Notes
- **Alacritty**: Configuration located in `alacritty/.config/alacritty/`.
- **Starship**: Configuration located in `starship/.config/starship.toml`.
- **Zsh**: Configuration located in `zsh/.zshrc` (requires WSL or Cygwin).

---

## Contributing

Feel free to fork this repository and submit pull requests for improvements or additional configurations.

---

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
