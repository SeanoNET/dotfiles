# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME=qt6ct

# Add fzf to PATH
export PATH="$HOME/.fzf/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

export SUDO_EDITOR=$(which helix) 

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::azure
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias vim='helix'
alias c='clear'
alias ls='eza --icons --group-directories-first --color=always --tree'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias l='eza -la --icons --git'
alias sp='spotify_player'


#alias zed="zeditor"

# Shell integrations
if [[ -o interactive ]]; then
  eval "$(fzf --zsh)"
  eval "$(zoxide init zsh)"              # no need to also do --cmd cd
  # OR if you specifically want cd overridden:
  # eval "$(zoxide init --cmd cd zsh)"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git starship  azure docker docker-compose history zsh-interactive-cd ssh-agent)

source $ZSH/oh-my-zsh.sh
source ~/git-flow-completion.zsh

# Shell integrations (loaded after Oh My Zsh to preserve keybindings)
if [[ $- == *i* ]]; then
  eval "$(fzf --zsh)"
  eval "$(zoxide init --cmd cd zsh)"
fi
# Custom functions
# Google search in Zen browser
google-search() {
  local query="$*"
  if [[ -z "$query" ]]; then
    echo "Usage: ? <search query>"
    return 1
  fi
  # URL encode the query
  local encoded=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$query'''))")
  local url="https://www.google.com/search?q=${encoded}"

  # Try Zen browser first, fall back to default browser
  if command -v zen-browser &> /dev/null; then
    zen-browser "$url" &> /dev/null &
  elif [[ -f "/mnt/c/Program Files/Zen Browser/zen.exe" ]]; then
    "/mnt/c/Program Files/Zen Browser/zen.exe" "$url" &> /dev/null &
  else
    xdg-open "$url" &> /dev/null &
  fi
}

# Claude Code query
claude-query() {
  local attach=false

  # Check for -a flag
  if [[ "$1" == "-a" ]]; then
    attach=true
    shift
  fi

  local query="$*"
  if [[ -z "$query" ]]; then
    echo "Usage: ?? [-a] <claude code query>"
    echo "  -a    Open interactive Claude Code session"
    return 1
  fi

  if [[ "$attach" == true ]]; then
    # Interactive mode
    claude "$query"
  else
    # Print mode (streaming output)
    claude -p "$query"
  fi
}

# Cheat sheet viewer
cheat() {
  local cheat_file="$HOME/dotfiles/CHEATSHEET.md"

  if [[ ! -f "$cheat_file" ]]; then
    echo "Cheat sheet not found at $cheat_file"
    return 1
  fi

  # Check for search flag
  if [[ "$1" == "-s" ]]; then
    shift
    local search_term="$*"
    if [[ -z "$search_term" ]]; then
      # Interactive search with fzf
      if command -v bat &> /dev/null; then
        grep -n "." "$cheat_file" | fzf --delimiter=: --preview 'bat --color=always --style=plain --highlight-line {1} '"$cheat_file" --preview-window=+{1}-10
      else
        grep -n "." "$cheat_file" | fzf --delimiter=: --preview 'sed -n {1}p '"$cheat_file"
      fi
    else
      # Search for specific term
      grep -i "$search_term" "$cheat_file" --color=always
    fi
  elif [[ "$1" == "-p" ]] || [[ -n "$TMUX" && "$1" != "-f" ]]; then
    # Show in tmux popup (if in tmux) or with -p flag
    if [[ -n "$TMUX" ]]; then
      if command -v glow &> /dev/null; then
        tmux popup -E -w 85% -h 85% "glow -p '$cheat_file'"
      elif command -v bat &> /dev/null; then
        tmux popup -E -w 85% -h 85% "bat --style=full --paging=always '$cheat_file'"
      else
        tmux popup -E -w 85% -h 85% "less '$cheat_file'"
      fi
    else
      # Not in tmux, fall back to regular view
      if command -v glow &> /dev/null; then
        glow -p "$cheat_file"
      elif command -v bat &> /dev/null; then
        bat --style=full "$cheat_file"
      else
        less "$cheat_file"
      fi
    fi
  else
    # Regular view with glow, bat or less
    if command -v glow &> /dev/null; then
      glow -p "$cheat_file"
    elif command -v bat &> /dev/null; then
      bat --style=full "$cheat_file"
    else
      less "$cheat_file"
    fi
  fi
}

# Aliases with noglob to prevent glob expansion
alias '?'='noglob google-search'
alias '??'='noglob claude-query'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Welcome message (only in interactive shells)
if [[ $- == *i* ]]; then
  # Add a small delay to let terminal initialize
  sleep 0.1
  echo "💡 Tip: Type 'cheat' to view terminal shortcuts (or Ctrl+Space+? in tmux)"
fi

export PATH="/home/seano/.npm-global/bin:$PATH"

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Added by tally installer
export PATH="$HOME/.tally/bin:$PATH"
