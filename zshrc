# Set the default PATH
export PATH="/usr/local/bin:$HOME/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/Users/dennis/Library/Python/4.7/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Set Python executable
export PYTHON=/usr/local/opt/python/libexec/bin/python

# Set NVM initialization in one line
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

# Set Node.js global bin path
export NODE_PATH=$(npm root --global)

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
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set preferred Go development path
export GOPATH=$HOME/code/gocode

# Set PostgreSQL data directory
export PGDATA=/usr/local/var/postgres

# Set RBENV initialization
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# Set Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/dennish/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

# Load oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell" # You can change this theme if needed
plugins=(brew git bundler npm rails ruby gem nvm rbenv)
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

# Load FZF if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
export PATH="/usr/local/sbin:$PATH"
