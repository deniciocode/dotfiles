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

command -v brew >/dev/null 2>&1 || error "Homebrew not found. Install from https://brew.sh first."

casks=(claude todoist)

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

choose_multi() {
  local label=$1
  shift
  info "$label"
  for entry in "$@"; do
    local display="${entry%%:*}"
    local cask="${entry#*:}"
    if ask_yn "install $display?"; then
      casks+=("$cask")
    fi
  done
}

choose_single() {
  local display=$1
  local cask=$2
  if ask_yn "install $display?"; then
    casks+=("$cask")
  fi
}

info "Selecting GUI apps to install"

choose_multi "Browsers" "brave:brave-browser" "firefox:firefox" "chrome:google-chrome"
choose_multi "Terminals" "iterm2:iterm2" "ghostty:ghostty" "alacritty:alacritty"
choose_multi "Password managers" "1password:1password" "bitwarden:bitwarden" "protonpass:proton-pass"
choose_multi "Communication" "zoom:zoom" "slack:slack"

info "Other apps"
choose_single "tableplus" "tableplus"
choose_single "obsidian" "obsidian"
choose_single "rectangle" "rectangle"
choose_single "postgres.app" "postgres-app"
choose_single "alfred" "alfred"

info "Installing ${#casks[@]} casks via brew bundle"

brewfile=$(mktemp)
trap 'rm -f "$brewfile"' EXIT
for c in "${casks[@]}"; do
  echo "cask \"$c\"" >>"$brewfile"
done

brew bundle --file="$brewfile"
success "Done"
