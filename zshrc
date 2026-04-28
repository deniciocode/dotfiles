# Set preferred Go development path
export GOPATH=$HOME/code/gocode

# Set PATH — last prepended = highest priority
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/Users/dennis/Library/Python/4.7/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

# Set Python executable
export PYTHON=/usr/local/opt/python/libexec/bin/python

# Set NVM initialization
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" --no-use  # Lazy-load nvm

# Set color preferences for ls
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Set the default text editor
export VISUAL=nvim

# Disable fork safety for Neovim
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Set the preferred editor
export EDITOR='nvim'

# Set the language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set up FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set PostgreSQL data directory
export PGDATA=/usr/local/var/postgres

# Set RBENV initialization
eval "$(rbenv init - zsh --no-rehash)"

# Set Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/dennish/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

# Load oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell" # You can change this theme if needed
plugins=(git rails)
source $ZSH/oh-my-zsh.sh

# Custom aliases
alias bcl="brew cleanup"
alias bup="brew update && brew upgrade"
alias cat=ccat
alias codedir="cd ~/code"
alias devrebase="git checkout develop && git pull --rebase && git checkout - && git rebase develop"
alias gitconfig='nvim ~/.gitconfig'
alias lgit=lazygit
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias python2=python
alias rlsh='source ~/.zshrc'
alias vim='nvim'
alias zshconfig="nvim ~/.zshrc"

# Load FZF
eval "$(fzf --zsh)"
export PATH="$HOME/.local/bin:$PATH"
