# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Load theme
ZSH_THEME="erroneousboat"

# Disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Command execution time stamp in the history command output.
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    git
    git-extras
    docker
    vagrant
    tmuxinator
    vi-mode
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# dircolors
if [ -f /usr/bin/dircolors ]; then
    eval `dircolors ~/.dircolors`
fi

# source dotfiles
source $HOME/.env
source $HOME/.path
source $HOME/.alias
source $HOME/.functions
source $HOME/.dockerfunc
