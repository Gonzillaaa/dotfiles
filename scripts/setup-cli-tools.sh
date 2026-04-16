#!/bin/bash
# ============================================================
# Mac CLI Tools Setup Script
# ============================================================
# Installs modern CLI tools and configures zsh/vim.
# Based on gonzalo's current setup.
#
# Usage:
#   ./setup-cli-tools.sh          # Full install
#   ./setup-cli-tools.sh --dry-run # Show what would be done
# ============================================================

set -e

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "=== DRY RUN MODE ==="
    echo ""
fi

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        echo ">>> $*"
        eval "$*"
    fi
}

section() {
    echo ""
    echo "============================================================"
    echo "$1"
    echo "============================================================"
}

# ---------------------------------------------------------
section "Checking Prerequisites"
# ---------------------------------------------------------

if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Install it first:"
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi
echo "✓ Homebrew found"

# ---------------------------------------------------------
section "Installing CLI Tools"
# ---------------------------------------------------------

TOOLS=(
    eza           # ls replacement
    bat           # cat replacement
    fd            # find replacement
    ripgrep       # grep replacement
    zoxide        # smarter cd
    fzf           # fuzzy finder
    tealdeer      # tldr pages
    fastfetch     # system info
    btop          # system monitor
    lazygit       # git TUI
)

for tool in "${TOOLS[@]}"; do
    if brew list "$tool" &>/dev/null; then
        echo "✓ $tool already installed"
    else
        run "brew install $tool"
    fi
done

# ---------------------------------------------------------
section "Installing Zsh Plugins"
# ---------------------------------------------------------

ZSH_PLUGINS=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

for plugin in "${ZSH_PLUGINS[@]}"; do
    if brew list "$plugin" &>/dev/null; then
        echo "✓ $plugin already installed"
    else
        run "brew install $plugin"
    fi
done

# ---------------------------------------------------------
section "Installing fzf Keybindings"
# ---------------------------------------------------------

if [[ -f ~/.fzf.zsh ]]; then
    echo "✓ fzf keybindings already installed"
else
    run "$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc"
fi

# ---------------------------------------------------------
section "Updating tldr Cache"
# ---------------------------------------------------------

if command -v tldr &> /dev/null; then
    run "tldr --update"
fi

# ---------------------------------------------------------
section "Setting Up Vim"
# ---------------------------------------------------------

run "mkdir -p ~/.vim/colors"

if [[ -f ~/.vim/colors/solarized.vim ]]; then
    echo "✓ Solarized colorscheme already installed"
else
    run "curl -o ~/.vim/colors/solarized.vim https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim"
fi

# ---------------------------------------------------------
section "Creating ~/.vimrc"
# ---------------------------------------------------------

VIMRC_CONTENT='syntax on
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
colorscheme solarized'

if [[ -f ~/.vimrc ]]; then
    echo "~/.vimrc already exists. Backing up to ~/.vimrc.bak"
    run "cp ~/.vimrc ~/.vimrc.bak"
fi

if $DRY_RUN; then
    echo "[dry-run] Would write ~/.vimrc"
else
    echo "$VIMRC_CONTENT" > ~/.vimrc
    echo "✓ Created ~/.vimrc"
fi

# ---------------------------------------------------------
section "Zsh Configuration"
# ---------------------------------------------------------

# Check what's missing from current .zshrc
ZSHRC="$HOME/.zshrc"

echo "Checking your ~/.zshrc for missing configurations..."
echo ""

MISSING=()

if ! grep -q 'alias lg=' "$ZSHRC" 2>/dev/null; then
    MISSING+=('alias lg="lazygit"')
fi

if ! grep -q 'alias ls="eza' "$ZSHRC" 2>/dev/null; then
    MISSING+=('alias ls="eza --icons --group-directories-first"')
fi

if ! grep -q 'alias cat="bat' "$ZSHRC" 2>/dev/null; then
    MISSING+=('alias cat="bat --paging=never"')
fi

if ! grep -q 'FZF_DEFAULT_COMMAND' "$ZSHRC" 2>/dev/null; then
    MISSING+=('# fzf with fd')
    MISSING+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
    MISSING+=("export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'")
    MISSING+=('export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"')
    MISSING+=("export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'")
    MISSING+=("export FZF_CTRL_T_OPTS=\"--preview 'bat --color=always --line-range :50 {}'\"")
fi

if [[ ${#MISSING[@]} -eq 0 ]]; then
    echo "✓ All recommended configurations already present"
else
    echo "Add these to your ~/.zshrc:"
    echo ""
    echo "-------- COPY BELOW THIS LINE --------"
    for line in "${MISSING[@]}"; do
        echo "$line"
    done
    echo "-------- COPY ABOVE THIS LINE --------"
    echo ""
fi

# ---------------------------------------------------------
section "Fix Conflicting Aliases"
# ---------------------------------------------------------

if grep -q 'alias ll="ls -la"' "$ZSHRC" 2>/dev/null; then
    echo "⚠️  Found: alias ll=\"ls -la\""
    echo "   This uses plain ls instead of eza."
    echo "   Consider changing to: alias ll=\"eza -la --icons --git --group-directories-first\""
    echo ""
fi

# ---------------------------------------------------------
section "iTerm2 Configuration"
# ---------------------------------------------------------

echo "Manual step required for vim colors to work correctly:"
echo "  1. Open iTerm2 Preferences (Cmd + ,)"
echo "  2. Go to Profiles → Colors"
echo "  3. Click 'Color Presets...' dropdown"
echo "  4. Select 'Solarized Dark'"
echo ""

# ---------------------------------------------------------
section "Setup Complete!"
# ---------------------------------------------------------

echo ""
echo "Installed tools:"
for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &>/dev/null || brew list "$tool" &>/dev/null; then
        echo "  ✓ $tool"
    fi
done
echo ""
echo "Next steps:"
echo "  1. Add any missing zsh config shown above to ~/.zshrc"
echo "  2. Fix the ll alias if flagged"
echo "  3. Set iTerm2 colors to Solarized Dark"
echo "  4. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "Verify with:"
echo "  eza --version"
echo "  bat --version"
echo "  rg --version"
echo "  fd --version"
echo "  fzf --version"
echo "  lazygit --version"
echo ""
