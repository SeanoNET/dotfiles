# My Desktop & Terminal Cheat Sheet

## Omarchy / Hyprland

`Mod` = Super. `Mod+F1` prints the full live map (Omarchy defaults + overrides).
`Mod+F2` reopens this cheatsheet; it's also in the Omarchy menu under Learn.

### Windows
- `Mod+q` - Close window
- `Mod+h/j/k/l` - Focus left/down/up/right (arrows also work)
- `Mod+Shift+h/j/k/l` - Swap window left/down/up/right
- `Mod+f` - Fullscreen
- `Mod+t` / `Mod+Shift+Space` - Toggle floating/tiling
- `Mod+\` - Toggle window split
- `Mod+g` - Toggle window grouping (tabbed)
- `Mod+r` - Resize mode (`hjkl`/arrows, `Esc` or `Return` to exit)

### Workspaces
- `Mod+1-0` - Switch to workspace 1-10
- `Mod+Shift+1-0` - Move window to workspace 1-10
- `Mod+Tab` - Former workspace
- `Mod+Ctrl+Tab` / `Mod+Shift+Tab` - Next / previous workspace
- `Mod+Shift+n` - Open next empty workspace
- `Mod+s` - Toggle scratchpad
- `Mod+Alt+s` - Move window to scratchpad
- `Mod+Alt+l` - Toggle workspace layout

### Apps
- `Mod+Return` - Terminal + tmux (workspace 1)
- `Mod+e` - Editor / Zed (workspace 1)
- `Mod+w` - Browser / Zen (workspace 2)
- `Mod+n` - File manager (workspace 3)
- `Mod+d` / `Mod+Space` - Apps menu / Omarchy menu

### System
- `Mod+v` - Clipboard history
- `Print` - Screenshot
- `Mod+Shift+s` - Screenshot region to clipboard
- `Mod+Shift+x` - Lock screen
- `Mod+Shift+p` - Power menu
- `Mod+Shift+r` - Reload Hyprland config
- `Mod+Shift+Alt+Space` - Toggle top bar

## Custom Commands

### Search & AI
- `?` - Google search in Zen browser
  - Example: `? how to use tmux`
- `??` - Claude Code query (streaming output)
  - Example: `?? explain this code`
- `?? -a` - Claude Code interactive session
  - Example: `?? -a help me refactor`

## Tmux Keybindings

### Prefix Key
- `Ctrl+Space` - Prefix key (instead of default Ctrl+b)

### Special Popups
- `Ctrl+Space + g` - Lazygit popup (90% window)
- `Ctrl+Space + ?` - This cheat sheet popup (85% window)

### Menus & Tools
- `Ctrl+Space + \` - Tmux-menus main menu (navigate all tmux features)
  - Also accessible via right-click on panes, windows, status bar
- `Ctrl+Space + Ctrl+f` - Tmux-fzf menu (fuzzy search sessions, windows, commands)
- `Ctrl+Space + Backspace` - Command palette (shows all available keybindings)
- `Ctrl+Space + Alt+m` - Command list palette (shows tmux commands)

### Session Management
- `Ctrl+Space + d` - Detach from session
- `Ctrl+Space + Ctrl+Space` - Switch to last client
- `Ctrl+Space + Space` - Switch to last window

### Window Management
- `Ctrl+Space + c` - New window (in current path)
- `Ctrl+Space + ,` - Rename window
- `Ctrl+Space + <` - Move window left
- `Ctrl+Space + >` - Move window right
- `Ctrl+Space + w` - List windows

### Pane Management
- `Ctrl+Space + |` - Split horizontally
- `Ctrl+Space + -` - Split vertically
- `Ctrl+Space + \` - Full height split horizontal
- `Ctrl+Space + _` - Full width split vertical

### Pane Navigation (Vim-style)
- `Ctrl+Space + h` - Move to left pane
- `Ctrl+Space + j` - Move to down pane
- `Ctrl+Space + k` - Move to up pane
- `Ctrl+Space + l` - Move to right pane

### Pane Resizing
- `Ctrl+Space + Ctrl+h` - Resize pane left
- `Ctrl+Space + Ctrl+j` - Resize pane down
- `Ctrl+Space + Ctrl+k` - Resize pane up
- `Ctrl+Space + Ctrl+l` - Resize pane right

### Pane Actions
- `Ctrl+Space + j` - Join pane from another window
- `Ctrl+Space + z` - Zoom/unzoom pane
- `Ctrl+Space + x` - Kill pane

### Configuration
- `Ctrl+Space + r` - Reload tmux config

## Zsh Keybindings

### History Search
- `Ctrl+r` - FZF history search (fuzzy search all commands)
- `Ctrl+p` - Previous command in history (matching current input)
- `Ctrl+n` - Next command in history (matching current input)

### FZF Integrations
- `Ctrl+t` - Search files/directories (paste to command line)
- `Alt+c` - Change directory with fzf
- `**<TAB>` - Fuzzy completion for files

### Navigation
- `cd <dir>` - Change directory (zoxide enhanced)
- `cd -` - Go to previous directory

## Shell Aliases

### File Listing (eza)
- `ls` - Tree view with icons
- `ll` - Long list with icons
- `la` - Long list with hidden files
- `l` - Long list with git status

### Utilities
- `vim` - Opens Helix
- `nvim` - Opens Neovim (LazyVim)
- `c` - Clear screen

## Tmux Plugins

### Installed Plugins
- `tpm` - Tmux Plugin Manager
- `tmux-sensible` - Sensible default settings
- `tokyo-night-tmux` - Tokyo Night theme
- `tmux-resurrect` - Save/restore sessions
- `tmux-command-palette` - Command palette
- `tmux-tilish` - Tiling window manager keybindings
- `tmux-menus` - Context menus
- `tmux-fzf` - FZF integration

### Plugin Management
- `Ctrl+Space + Shift+I` - Install plugins
- `Ctrl+Space + Shift+U` - Update plugins
- `Ctrl+Space + Alt+u` - Uninstall plugins

## Git (via Oh My Zsh)

### Common Aliases
- `gst` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gl` - git pull
- `gco` - git checkout
- `gcb` - git checkout -b (new branch)
- `glog` - git log with graph

## Tips & Tricks

### Cheat Sheet
- `cheat` - View this cheat sheet
- `cheat -s <term>` - Search cheat sheet for term

### Terminal Multiplexing
- Run `tmux` to start a new session
- Run `tmux attach` or `tmux a` to attach to existing session
- Sessions persist even after closing terminal

### FZF Power User
- Use `Ctrl+r` for fuzzy command history
- Use `**<TAB>` after any command for fuzzy file completion
- Example: `vim **<TAB>` then type part of filename

### Dotfiles Location
All configs are stowed from `~/dotfiles` — the paths below are symlinks into it.
- Zsh: `~/.zshrc` (source: `~/dotfiles/zsh/.zshrc`)
- Tmux: `~/.config/tmux/tmux.conf`
- Lazygit: `~/.config/lazygit/config.yml`
- Hyprland overrides: `~/.config/hypr/` (source: `~/dotfiles/hypr/.config/hypr/`)
- Helper scripts: `~/.local/bin/` (sources: `~/dotfiles/omarchy/`, `~/dotfiles/bin/`)
