set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'

info() { echo -e "${BOLD}${1}${NC}"; }
success() { echo -e "${GREEN}✓ ${1}${NC}"; }
warn() { echo -e "${YELLOW}! ${1}${NC}"; }
error() {
  echo -e "${RED}✗ ${1}${NC}"
  exit 1
}

link_file() {
  local src=$1
  local dest=$2

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      success "$dest already linked"
      return
    fi

    warn "$dest already exists"
    local choice=""
    while true; do
      read -r -p "  [b]ackup, [o]verwrite, [s]kip? " choice
      case "$choice" in
      b | B)
        mv "$dest" "${dest}.backup"
        success "Backed up to ${dest}.backup"
        break
        ;;
      o | O)
        rm -rf "$dest"
        break
        ;;
      s | S)
        warn "Skipped $dest"
        return
        ;;
      *)
        echo "  Please answer b, o, or s."
        ;;
      esac
    done
  fi

  ln -s "$src" "$dest"
  success "Linked $dest"
}

clone_repo() {
  local url=$1
  local dest=$2

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ -d "$dest/.git" ] && [ "$(git -C "$dest" remote get-url origin 2>/dev/null)" = "$url" ]; then
      success "$dest already cloned"
      return
    fi

    warn "$dest already exists"
    local choice=""
    while true; do
      read -r -p "  [b]ackup, [o]verwrite, [s]kip? " choice
      case "$choice" in
      b | B)
        mv "$dest" "${dest}.backup"
        success "Backed up to ${dest}.backup"
        break
        ;;
      o | O)
        rm -rf "$dest"
        break
        ;;
      s | S)
        warn "Skipped $dest"
        return
        ;;
      *)
        echo "  Please answer b, o, or s."
        ;;
      esac
    done
  fi

  mkdir -p "$(dirname "$dest")"
  git clone "$url" "$dest"
  success "Cloned $dest"
}

DOTFILES=$(pwd)

info "Installing dotfiles from $DOTFILES"

if ! command -v brew >/dev/null 2>&1; then
  info "Homebrew not found — installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  success "Homebrew already installed"
fi

link_file "$DOTFILES/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/gitignore" "$HOME/.gitignore_global"
link_file "$DOTFILES/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/ghostty/themes"
link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES/ghostty/themes/everforest-light" "$HOME/.config/ghostty/themes/everforest-light"

clone_repo "https://github.com/deniciocode/neovim" "$HOME/.config/nvim"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Oh My Zsh not found — installing"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  success "Oh My Zsh already installed"
fi

ask_yn() {
  local prompt=$1
  local yn
  while true; do
    read -r -p "  $prompt [y/N] " yn
    case "$yn" in
    y | Y) return 0 ;;
    n | N | "") return 1 ;;
    *) echo "  Please answer y or n." ;;
    esac
  done
}

import_rectangle_config() {
  if ! command -v jq >/dev/null 2>&1; then
    warn "jq not found — skipping Rectangle config import (run brew.sh first)"
    return
  fi

  osascript -e 'quit app "Rectangle"' 2>/dev/null || true

  jq -r '.defaults | to_entries[] | .key as $k | .value | to_entries[0] | "\($k)\t\(.key)\t\(.value)"' \
    "$DOTFILES/rectangle_config.json" |
    while IFS=$'\t' read -r key type value; do
      case "$type" in
      bool) defaults write com.knollsoft.Rectangle "$key" -bool "$value" ;;
      int) defaults write com.knollsoft.Rectangle "$key" -int "$value" ;;
      float) defaults write com.knollsoft.Rectangle "$key" -float "$value" ;;
      string) defaults write com.knollsoft.Rectangle "$key" -string "$value" ;;
      data) defaults write com.knollsoft.Rectangle "$key" -data "$value" ;;
      *) warn "unknown type '$type' for key '$key'" ;;
      esac
    done

  killall cfprefsd 2>/dev/null || true
  success "Imported Rectangle config"
}

info "Optional config imports"
if ask_yn "import Rectangle config?"; then
  import_rectangle_config
fi
