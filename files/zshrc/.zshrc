# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Load theme
ZSH_THEME="gentoo"

# Disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"


# Command execution time stamp in the history command output.
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras docker vagrant sublime tmuxinator vi-mode)

# A shortcut for tmuxinator
alias mux=tmuxinator

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/home/erroneousboat/.rvm/gems/ruby-2.0.0-p247/bin:/home/erroneousboat/.rvm/gems/ruby-2.0.0-p247@global/bin:/home/erroneousboat/.rvm/rubies/ruby-2.0.0-p247/bin:/home/erroneousboat/.rvm/bin:/home/erroneousboat/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/erroneousboat/Projects/scribdev/scribdev:/usr/local/go/bin"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Go Setup
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# dircolors
if [ -f /usr/bin/dircolors ]; then
    eval `dircolors ~/.dircolors`
fi
