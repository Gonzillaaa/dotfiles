# Mac CLI Setup Guide

A comprehensive guide to setting up a modern CLI environment on macOS.

## Prerequisites

- macOS with Homebrew installed
- iTerm2 (recommended terminal) with Solarized Dark color preset
- Oh-My-Zsh with Powerlevel10k

---

## CLI Tools

### Core Replacements

| Tool | Replaces | Description |
|------|----------|-------------|
| `eza` | `ls` | Modern ls with icons, git status, tree view |
| `bat` | `cat` | Syntax highlighting, line numbers, git integration |
| `fd` | `find` | Faster, simpler syntax, respects .gitignore |
| `ripgrep` | `grep` | Blazingly fast, respects .gitignore |
| `zoxide` | `cd` | Smarter cd that learns your habits |
| `fzf` | - | Fuzzy finder for files, history, etc. |
| `tealdeer` | `man` | Practical command examples (tldr pages) |

### System & Git

| Tool | Description |
|------|-------------|
| `fastfetch` | System info display (neofetch alternative) |
| `btop` | Beautiful system monitor |
| `lazygit` | Terminal UI for git |

---

## Installation

### Install All Tools

```bash
brew install eza bat fd ripgrep zoxide fzf tealdeer fastfetch btop lazygit
brew install zsh-autosuggestions zsh-syntax-highlighting
```

### Install fzf Keybindings

```bash
$(brew --prefix)/opt/fzf/install
```

This enables:
- `ctrl+r` - Fuzzy search command history
- `ctrl+t` - Fuzzy find file, insert path
- `alt+c` - Fuzzy find directory, cd into it

### Update tldr Cache

```bash
tldr --update
```

---

## Shell Configuration

### ~/.zshrc

Full configuration based on current setup:

```bash
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  history
  z
  git
  docker
  docker-compose
  brew
  npm
  node
  python
  pip
  zsh-autosuggestions
  zsh-syntax-highlighting
  battery
)

source $ZSH/oh-my-zsh.sh

# ---------------------------------------------------------
# Powerlevel10k
# ---------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ---------------------------------------------------------
# Zoxide (smarter cd)
# ---------------------------------------------------------
eval "$(zoxide init zsh)"

# ---------------------------------------------------------
# fzf Configuration
# ---------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd for fzf (faster, respects .gitignore)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# ---------------------------------------------------------
# Environment
# ---------------------------------------------------------
export EDITOR="cursor"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Python
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
alias python-brew="/opt/homebrew/bin/python3.11"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/gonzalo/.bun/_bun" ] && source "/Users/gonzalo/.bun/_bun"

# Local bin paths
export PATH="/Users/gonzalo/.local/bin:$PATH"
export PATH="/Users/gonzalo/.antigravity/antigravity/bin:$PATH"

# Ollama Performance
export OLLAMA_FLASH_ATTENTION=1
export OLLAMA_KV_CACHE_TYPE=q8_0
export OLLAMA_KEEP_ALIVE=30m
export OLLAMA_MAX_LOADED_MODELS=2

# ---------------------------------------------------------
# Aliases - eza (ls replacement)
# ---------------------------------------------------------
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --git --group-directories-first"
alias la="eza -A --icons --group-directories-first"
alias l="eza -la --git --icons"
alias lt="eza --tree --level=3"
alias lm="eza -la --sort=modified"

# ---------------------------------------------------------
# Aliases - bat (cat replacement)
# ---------------------------------------------------------
alias bat="bat --style=full"
alias batd="bat --diff"
alias cat="bat --paging=never"

# ---------------------------------------------------------
# Aliases - Git & lazygit
# ---------------------------------------------------------
alias lg="lazygit"

# ---------------------------------------------------------
# Aliases - Docker
# ---------------------------------------------------------
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dlog="docker logs -f"
alias dex="docker exec -it"
alias dprune="docker system prune -a"

# ---------------------------------------------------------
# Aliases - tmux
# ---------------------------------------------------------
tm() {
    tmux attach -t main 2>/dev/null || tmux new -s main
}
alias tmn="tmux new -s"
alias tmls="tmux ls"
alias tma="tmux attach -t"

# ---------------------------------------------------------
# Aliases - Navigation
# ---------------------------------------------------------
alias docs="cd ~/docs"
alias scripts="cd ~/scripts"
alias code="cd ~/code"

# ---------------------------------------------------------
# Aliases - Quick edits
# ---------------------------------------------------------
alias zshrc="vim ~/.zshrc"
alias reload="source ~/.zshrc"
alias clr="clear"

# ---------------------------------------------------------
# Aliases - Safety nets
# ---------------------------------------------------------
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# ---------------------------------------------------------
# Aliases - SSH
# ---------------------------------------------------------
alias ai-box="ssh perate@100.92.176.32"

# ---------------------------------------------------------
# Aliases - Tools
# ---------------------------------------------------------
alias claude="~/.local/bin/claude"

# ---------------------------------------------------------
# Completions
# ---------------------------------------------------------
source ~/.gmail-toolkit-complete.zsh

# ---------------------------------------------------------
# Startup
# ---------------------------------------------------------
fastfetch
```

---

## Vim Configuration

### Install Solarized Colorscheme

```bash
mkdir -p ~/.vim/colors
curl -o ~/.vim/colors/solarized.vim https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim
```

### ~/.vimrc

```vim
syntax on
set number              " Line numbers
set relativenumber      " Relative line numbers
set tabstop=4           " Tab width
set shiftwidth=4        " Indent width
set expandtab           " Spaces instead of tabs
set autoindent          " Auto-indent new lines
set showmatch           " Highlight matching brackets
set incsearch           " Search as you type
set hlsearch            " Highlight search results
set background=dark
colorscheme solarized
```

**Important:** Do NOT use `set termguicolors` or `let g:solarized_termcolors=256` when iTerm2 is using the Solarized Dark color preset.

---

## iTerm2 Configuration

### Solarized Dark Colors

1. Open iTerm2 Preferences (`Cmd + ,`)
2. Go to Profiles → Colors
3. Click "Color Presets..." dropdown
4. Select "Solarized Dark"

---

## Command Reference

### eza (ls replacement)

```bash
ls                            # List with icons (alias)
ll                            # Long format with git status (alias)
l                             # Same as ll (alias)
lt                            # Tree view 3 levels (alias)
lm                            # Sorted by modified (alias)
eza --tree --level=2          # Custom tree depth
eza -la --sort=size           # Sort by size
```

Git status indicators: `--` clean, `-M` modified, `-N` new, `-I` ignored

### bat (cat replacement)

```bash
bat file.py                   # Full style (alias default)
batd file.py                  # Show git diff (alias)
cat file.py                   # No paging (alias)
bat --style=plain file.py     # No decorations
bat --line-range=10:20 file   # Lines 10-20 only
bat --list-themes             # See available themes
```

### fd (find replacement)

```bash
fd                            # List all files
fd pattern                    # Find matching files
fd -e py                      # Find by extension
fd -t f                       # Files only
fd -t d                       # Directories only
fd -d 2                       # Max depth 2
fd -H                         # Include hidden
fd -x cmd {}                  # Execute on each result
```

### ripgrep (grep replacement)

```bash
rg "pattern"                  # Search recursively
rg -i "error"                 # Case insensitive
rg -w "log"                   # Whole word
rg -l "TODO"                  # Filenames only
rg -C 3 "error"               # 3 lines context
rg -t py "import"             # Only Python files
rg -g "*.yaml" "host"         # Glob pattern
rg --hidden "secret"          # Include hidden files
```

### zoxide (cd replacement)

```bash
z foo                         # Jump to directory matching "foo"
zi foo                        # Interactive selection (with fzf)
z -                           # Previous directory
zoxide query -ls              # See learned directories
```

### fzf (fuzzy finder)

```bash
fzf                           # Browse files
vim $(fzf)                    # Open selected in vim
ctrl+r                        # Fuzzy history search (keybinding)
ctrl+t                        # Fuzzy file insert (keybinding)
alt+c                         # Fuzzy cd (keybinding)
```

### lazygit

```bash
lg                            # Launch (alias)
```

Key bindings: `space` stage, `c` commit, `p` push, `P` pull, `?` help, `q` quit

### btop

```bash
btop                          # Launch system monitor
```

Key bindings: `h` help, `q` quit, `f` filter, `k` kill, `←` `→` layouts

### tealdeer (tldr)

```bash
tldr tar                      # Show examples
tldr git commit               # Git subcommands work
tldr --update                 # Update cache
```

### Docker (aliases)

```bash
dps                           # docker ps
dpsa                          # docker ps -a
dlog <container>              # docker logs -f
dex <container> <cmd>         # docker exec -it
dprune                        # docker system prune -a
```

### tmux (aliases)

```bash
tm                            # Attach to main or create it
tmn <name>                    # New session with name
tmls                          # List sessions
tma <name>                    # Attach to session
```

---

## Quick Reference Aliases

| Alias | Command |
|-------|---------|
| `ls` | `eza --icons --group-directories-first` |
| `ll` | `eza -la --icons --git --group-directories-first` |
| `l` | `eza -la --git --icons` |
| `lt` | `eza --tree --level=3` |
| `lm` | `eza -la --sort=modified` |
| `cat` | `bat --paging=never` |
| `bat` | `bat --style=full` |
| `batd` | `bat --diff` |
| `lg` | `lazygit` |
| `z` | zoxide jump |
| `zi` | zoxide interactive |
| `dps` | `docker ps` |
| `dpsa` | `docker ps -a` |
| `dlog` | `docker logs -f` |
| `dex` | `docker exec -it` |
| `tm` | attach/create tmux main |
| `reload` | `source ~/.zshrc` |
| `clr` | `clear` |
