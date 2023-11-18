# Set the default PATH
export PATH="/usr/local/bin:$HOME/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/Users/dennis/Library/Python/4.7/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# Set Python executable
export PYTHON=/usr/local/opt/python/libexec/bin/python

# Set environment variables for NVM
export NVM_DIR="$HOME/.nvm" && [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

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
export EDITOR='vim'

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

# Set NVM initialization in one line
export NVM_DIR="$HOME/.nvm" && [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Set RBENV initialization
eval "$(rbenv init - zsh)"

# Set Heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/dennish/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

# Load oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell" # You can change this theme if needed
plugins=(git bundler npm rails ruby gem brew nvm rbenv)
source $ZSH/oh-my-zsh.sh

# Custom aliases
alias cat="ccat"
alias gitconfig='vim ~/.gitconfig'
alias ohmyzsh="vim ~/.oh-my-zsh"
alias python2=python
alias reloadshell='source ~/.zshrc'
alias vi=nvim
alias vim=nvim
alias vimconfig="vim ~/vimfiles/init.vim"
alias vimmappings="vim ~/vimfiles/lua/mappings.lua"
alias vimdir="cd ~/vimfiles"
alias zshconfig="vim ~/.zshrc"
alias codedir="cd ~/code"
alias devrebase="git checkout develop && git pull --rebase && git checkout - && git rebase develop"
alias cat=ccat

# Load FZF if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
