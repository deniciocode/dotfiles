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

DOTFILES=$(pwd)

info "Installing dotfiles from $DOTFILES"

link_file "$DOTFILES/gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/gitignore" "$HOME/.gitignore_global"
link_file "$DOTFILES/zshrc" "$HOME/.zshrc"
