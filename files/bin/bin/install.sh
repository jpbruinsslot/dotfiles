#!/bin/bash

# Source: http://www.davidpashley.com/articles/writing-robust-shell-scripts/
# set -o nounset
set -o errexit
set -o pipefail

# Colors
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'

# Font weight
B=$(tput bold)
N=$(tput sgr0)

# Functions
function print_green {
    printf "${GREEN}${B}$1${N}${NC}\n"
}

function print_yellow {
    printf "${YELLOW}${B}$1${N}${NC}\n"
}

function print_red {
    printf "${RED}${B}$1${N}${NC}\n"
}

function print_cyan {
    printf "${CYAN}${B}$1${N}${NC}\n"
}

function print_blue {
    printf "${BLUE}${B}$1${N}${NC}\n"
}



# Make necessary directories
function dir() {
    print_cyan "... Creating directories"
    mkdir -p \
        $HOME/Projects \
        $HOME/Downloads
}

# Copy ssh-keys 
function ssh() {
    print_red ">>> Setting up ssh"

    print_cyan "... Create ssh directory"
    mkdir -p $HOME/.ssh

    print_cyan "... Retrieving SSH keys from remote host"
    read -p "--> Copy SSH keys from remote host? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "--> Please enter user@host: " HOST
        scp $HOST:~/.ssh/id_rsa* ~/.ssh/
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
    fi
}

# Add additional repositories
function sources() {
    print_red ">>> Adding additional repositories"
    sudo add-apt-repository -y ppa:numix/ppa
    sudo add-apt-repository -y ppa:neovim-ppa/stable
}

function base() {
    print_red ">>> Installing base packages"

    # Synchronize package index files
    print_cyan "... Synchronizing package index files"
    sudo apt-get update

    # Install new versions of all packages
    print_cyan "... Installing new versions of all packages"
    sudo apt-get -y dist-upgrade

    # Install packages
    print_cyan "... Installing system packages"
    sudo apt-get install -y \
        acpi \
        apt-transport-https \
        autoconf \
        automake \
        build-essential \
        ca-certificates \
        compton \
        curl \
        dconf-tools \
        feh \
        git-core \
        gnome-do \
        htop \
        libevent-dev \
        libncurses5-dev \
        libncursesw5-dev \
        linux-image-extra-$(uname -r) \
        linux-image-extra-virtual \
        neovim \
        numix-icon-theme-circle \
        openssh-server \
        pkg-config \
        python-dev \
        python-pip \
        python3-dev \
        python3-pip \
        software-properties-common \
        sysstat \
        tar \
        tree \
        unzip \
        vim \
        virtualbox \
        wget \
        xclip \
		xcompmgr \
        zsh

    print_cyan "... Cleaning up"
    sudo apt-get autoremove
    sudo apt-get autoclean
    sudo apt-get clean
}

# Install: graphics drivers
function graphics() {
	local system=$1

	if [[ -z "$system" ]]; then
		echo "You need to specify if you're installing on a laptop or desktop"
		exit 1
	fi

	local pkgs=( nvidia-kernel-dkms bumblebee-nvidia primus )

	if [[ $system == "laptop" ]]; then
		pkgs=( xorg xserver-xorg xserver-xorg-video-intel )
	fi

    print_red ">>> Installing graphics drivers"
	apt-get install -y "${pkgs[@]}" --no-install-recommends
}

function python() {
    # Install: Python3 packages
    print_red ">>> Installing Python packages"

    sudo -H pip3 install --upgrade pip
    sudo -H pip2 install --upgrade pip

    sudo -H pip3 install --upgrade pip
    sudo -H pip3 install --no-cache-dir --upgrade --force-reinstall \
        httpie \
        neovim \
        glances \
        docker-compose \
        psutil \
        tmuxp \
        flake8 \
        lolcat

    # Install: Python2 packages
    # Needed for gsutil
    sudo -H pip2 install --no-cache-dir --upgrade --force-reinstall \
        crcmod
}

# Install: Golang
function golang() {
    print_red ">>> Installing Golang"

    GO_VERSION=1.8

	if [[ ! -z "$1" ]]; then
		export GO_VERSION=$1
	fi

    # read -p "--> Please enter the version of Go you want to install: " GO_VERSION

    GOLANG=go$GO_VERSION.linux-amd64

    # Removing prior version of Go
    sudo rm -rf /usr/local/go

    # Download
    cd /tmp
    wget -O $GOLANG.tar.gz https://storage.googleapis.com/golang/$GOLANG.tar.gz 
    sudo tar -C /usr/local -xzf $GOLANG.tar.gz
    export PATH=$PATH:/usr/local/go/bin
    export PATH=$PATH:$HOME/go/bin

    cd "$HOME"

    # Install: Go packages
    print_cyan "... Installing Golang packages"
    go get -u \
        github.com/erroneousboat/slack-term \
        github.com/erroneousboat/dot \
        github.com/jingweno/ccat \
        github.com/golang/dep/... \
        github.com/kardianos/govendor
}

# Install: Docker
function docker() {
    print_red ">>> Installing docker"

    # Download
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    # Install
    sudo apt-get update
    sudo apt-get install -y docker-ce

    # Configure
    sudo usermod -a -G docker $USER
    sudo service docker restart
}


# Install: Chrome
#   - https://askubuntu.com/a/79289
function chrome() {
    print_red ">>> Installing chrome"

    # Add the Google Chrome distribution URI as a package source
	echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/google-chrome.list

	# Import the Google Chrome public key
    cd /tmp
	curl https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

    # Install
    sudo apt-get update
    sudo apt-get install google-chrome-stable

    cd "$HOME"
}

# Install: Tmux
function tmux() {
    print_red ">>> Installing tmux"

    if [[ -d /tmp/tmux ]]; then
        rm -rf /tmp/tmux
    fi

    git clone https://github.com/tmux/tmux.git /tmp/tmux

    cd /tmp/tmux
    sh autogen.sh
    ./configure && make
    sudo make install

    cd "$HOME"
}


# Install: GCloud
function gcloud() {
    print_cyan "... Installing gcloud"

    # Check for version argument
	if [[ ! -z "$1" ]]; then
		export GCLOUD_VERSION=$1
	fi

    GCLOUD_VERSION=146.0.0

    # Download
    cd /tmp
    wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
    tar -xzf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz

    # Install
    ./google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-java app-engine-python kubectl alpha beta gcd-emulator pubsub-emulator

    cd "$HOME"
}


# Install: Minikube
function minikube() {
    print_cyan ">>> Install minikube"

    # Check for version argument
	if [[ ! -z "$1" ]]; then
		export MINIKUBE_VERSION=$1
	fi

    MINIKUBE_VERSION=v0.17.1

    # Download
    cd /tmp
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/$MINIKUBE_VERSION/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

    cd "$HOME"
}

# Install: kubernetes config
function kubeconfig() {
    print_red ">>> Install kubernetes configuration"
    read -p "--> Copy kubernetes config from remote host? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "--> Please enter user@host: " HOST
        scp -r $HOST:~/.kube/ ~
    fi
}

# Install: Dotfiles
function dotfiles() {
    print_red ">>> Install dotfiles"

    if [[ ! -d "$HOME"/dotfiles ]]; then
        print_cyan "... Cloning dotfiles"
        git clone https://github.com/erroneousboat/dotfiles.git "${HOME}/dotfiles"
    else
        cd "$HOME/dotfiles"
        git pull origin master
    fi

    print_cyan "... Syncing dotfiles"
    if [[ ! -f $HOME/.dotconfig ]]; then
        cp $HOME/dotfiles/files/dotconfig/.dotconfig $HOME
    fi

    yes All | dot sync

    # Setup gnome terminal profile
    ./bin/gnome-term-profile.sh

    cd "$HOME"
}


# Install: Nerd Fonts
# (https://github.com/ryanoasis/nerd-fonts)
function fonts() {
    print_cyan "... Installing fonts"

    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts

    curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

    curl -fLo "Ubuntu Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Original/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf

    cd "$HOME"
}

# Install: i3
function i3(){
    print_red ">>> Installing i3"
    echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get --allow-unauthenticated install sur5r-keyring
    sudo apt-get update
    sudo apt-get install -y i3
}

# Install: i3-apps
function i3apps() {
    print_red ">>> Installing i3-apps"

    if [[ -d /tmp/i3blocks ]]; then
        rm -rf /tmp/i3blocks
    fi

    # Download: i3blocks
    git clone "https://github.com/vivien/i3blocks.git" /tmp/i3blocks

    # Install: i3blocks
    cd /tmp/i3blocks
    make clean all
    sudo make install

    # Install additional apps
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends \
        alsa-utils \
        feh \
        i3lock \
        i3status \
        pulseaudio \
        rofi \
        xbacklight

    cd "$HOME"
}

function i3setup() {
    # TODO screen-backlight
    # TODO keyboard-backlight
    # TODO wifi
    # TODO sound + keyboard shortcut for sound
    # TODO external monitor
    cd "$HOME"
}


# Install: Bash 4.4
# (https://www.gnu.org/software/bash/)
function bash() {
    print_red ">>> Installing bash"

    # Check for version argument
	if [[ ! -z "$1" ]]; then
		export BASH_VERSION=$1
	fi

    BASH_VERSION=4.4

    # Download
    cd /tmp
    wget -q http://ftp.gnu.org/gnu/bash/bash-${BASH_VERSION}.tar.gz
    tar -xzf bash-${BASH_VERSION}.tar.gz

    # Install
    cd bash-${BASH_VERSION}
    ./configure && make && sudo make install

    # TODO replace with system bash /bin/bash

    cd "$HOME"
}

function misc() {
    # Place installation of miscellaneous programs here

    # TODO c (valgrind)

    # TODO dockerconfig

    # TODO Terminfo etc.

    # TODO slack-term config

    # Install: asciinema
    curl -sSL https://asciinema.org/install | sh

    cd "$HOME"
}

wifi() {
	local system=$1

	if [[ -z "$system" ]]; then
		echo "You need to specify whether it's broadcom or intel"
		exit 1
	fi

	if [[ $system == "broadcom" ]]; then
		local pkg="broadcom-sta-dkms"

		apt-get install -y "$pkg" --no-install-recommends
	else
		update-iwlwifi
	fi
}


check_is_sudo() {
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root."
		exit
	fi
}

usage() {
    echo "install.sh"
    echo
    echo "This script can install and setup the following on an ubuntu based system:"
    echo
	echo "Usage:"
    echo "  all                         - setup all below"
    echo "  dir                         - setup all necessary directories"
    echo "  wifi {broadcom, intel}      - setup all necessary directories"
	echo "  ssh                         - setup ssh & get keys"
	echo "  sources                     - setup sources & install base pkgs"
	echo "  graphics {laptop,desktop}   - setup graphics drivers"
    echo "  bash [version]              - setup bash"
	echo "  python                      - setup python packages"
	echo "  golang [version]            - setup golang language and packages"
	echo "  docker                      - setup docker"
	echo "  i3                          - setup i3"
	echo "  fonts                       - setup fonts"
	echo "  dotfiles                    - setup dotfiles"
	echo "  gcloud                      - setup gcloud"
	echo "  chrome                      - setup chrome"
	echo "  tmux                        - setup tmux"
}

all() {
    dir
    sources
    base
    ssh
    graphics
    bash
    python
    golang
    docker
    i3
    fonts
    chrome
    tmux
    dotfiles
    # TODO complete?
} 

main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

    if [[ $cmd == "all" ]]; then
        all
    elif [[ $cmd == "dir" ]]; then
        dir
    elif [[ $cmd == "sources" ]]; then
		check_is_sudo
		sources
		base
    elif [[ $cmd == "wifi" ]]; then
        wifi "$2"
    elif [[ $cmd == "ssh" ]]; then
        ssh
    elif [[ $cmd == "graphics" ]]; then
        graphics
    elif [[ $cmd == "bash" ]]; then
        bash "$2"
    elif [[ $cmd == "python" ]]; then
        python
    elif [[ $cmd == "golang" ]]; then
        golang "$2"
    elif [[ $cmd == "docker" ]]; then
        docker
    elif [[ $cmd == "i3" ]]; then
        i3
        i3apps
        i3setup
    elif [[ $cmd == "fonts" ]]; then
        fonts
    elif [[ $cmd == "chrome" ]]; then
        chrome
    elif [[ $cmd == "tmux" ]]; then
        tmux
    elif [[ $cmd == "dotfiles" ]]; then
        dotfiles
    else
        usage
    fi
}

main "$@"
