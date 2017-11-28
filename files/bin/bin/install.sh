#!/bin/bash

# Source: http://www.davidpashley.com/articles/writing-robust-shell-scripts/
# set -o nounset
set -o errexit
set -o pipefail

# Colours
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'

# Font weight
B=$(tput bold)
N=$(tput sgr0)

# Text color
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
    sudo add-apt-repository -y ppa:graphics-drivers/ppa
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
        rofi \
        silversearcher-ag \
        sysstat \
        tar \
        tree \
        unzip \
        urlview \
        vim \
        virtualbox \
        wget \
        xclip \
		xcompmgr \
        zsh

    print_cyan "... Cleaning up"
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
    sudo apt-get -y clean
}

# Install: graphics drivers
function graphics() {
    print_red ">>> Installing graphics drivers"
	local system=$1

	if [[ -z "$system" ]]; then
		echo "You need to specify if you're installing on a laptop or desktop"
		exit 1
	fi

	local pkgs=( nvidia-kernel-dkms bumblebee-nvidia primus )

	if [[ $system == "laptop" ]]; then
		pkgs=( xorg xserver-xorg xserver-xorg-video-intel )
	elif [[ $system == "desktop" ]]; then

        # Install nvidia drivers, find latest version at ppa.
        # ppa:graphics-drivers/ppa
        #
        # Source:
        #   - https://askubuntu.com/a/760935
		pkgs=( nvidia-384 )

        # Update grub to solve login loop
        #
        # Source:
        #   - https://askubuntu.com/a/867647
        sed -i 's/splash//g' /etc/default/grub

        update-grub2
	fi

	apt-get install -y "${pkgs[@]}" --no-install-recommends
}

function python() {
    # Install: Python3 packages
    print_red ">>> Installing Python packages"

    sudo -H pip3 install --upgrade pip
    sudo -H pip2 install --upgrade pip

    sudo -H pip3 install --upgrade pip
    sudo -H pip3 install --no-cache-dir --upgrade --force-reinstall \
        asciinema \
        docker-compose \
        flake8 \
        glances \
        httpie \
        lolcat \
        neovim \
        psutil \
        tmuxp

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
		GO_VERSION=$1
	fi

    # read -p "--> Please enter the version of Go you want to install: " GO_VERSION

    GOLANG=go$GO_VERSION.linux-amd64

    # Removing prior version of Go
    GO_SRC=/usr/local/go
    if [[ -d "$GO_SRC" ]]; then
        sudo rm -rf "$GO_SRC"
        sudo rm -rf "$GOPATH"
    fi

    # Download
    cd /tmp
    wget -O $GOLANG.tar.gz https://storage.googleapis.com/golang/$GOLANG.tar.gz 
    sudo tar -C /usr/local -xzf $GOLANG.tar.gz
    cd "$HOME"

    # Add binaries to path
    export PATH=$PATH:/usr/local/go/bin

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
# - https://askubuntu.com/a/79289
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
    print_cyan ">>> Installing gcloud"

    cd "$HOME"

    # Check for version argument
	if [[ ! -z "$1" ]]; then
		export GCLOUD_VERSION=$1
	fi

    GCLOUD_VERSION=146.0.0

    # Download
    wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
    tar -xzf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz

    # Install
    ./google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-java app-engine-python kubectl alpha beta gcd-emulator pubsub-emulator


    # Update components
    glcoud components update

    # Reset owner of folder
    chown -r $user:$user $HOME/google-cloud-sdk
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
function kubeconf() {
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

    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
    yes All | dot sync

    # For extra setup based on dotfiles, add below:

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


# Install: Bash
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

    # Replace old version with new one
    sudo cp /bin/bash /bin/bash.old
    sudo cp -f /usr/local/bin/bash /bin/bash

    cd "$HOME"
}

function gnome_molokai() {
    print_red ">>> Monokai for gnome-terminal"

    profile="b1dcc9dd-5262-4d8d-a863-c897e6d979b9"
    palette="#1B1B1D1D1E1E:#F9F926267272:#8282B4B41414:#FDFD97971F1F:#5656C2C2D6D6:#8C8C5454FEFE:#464654545757:#CCCCCCCCC6C6:#505053535454:#FFFF59599595:#B6B6E3E35454:#FEFEEDED6C6C:#8C8CEDEDFFFF:#9E9E6F6FFEFE:#89899C9CA1A1:#F8F8F8F8F2F2"
    bd_color="#F8F8F8F8F2F2"
    fg_color="#F8F8F8F8F2F2"
    bg_color="#262626262626"

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ background-color $bg_color
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ foreground-color $fg_color
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ bold-color $bd_color
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ palette "['#1B1B1D1D1E1E','#F9F926267272','#8282B4B41414','#FDFD97971F1F','#5656C2C2D6D6','#8C8C5454FEFE','#464654545757','#CCCCCCCCC6C6','#505053535454','#FFFF59599595','#B6B6E3E35454','#FEFEEDED6C6C','#8C8CEDEDFFFF','#9E9E6F6FFEFE','#89899C9CA1A1','#F8F8F8F8F2F2']"

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ use-theme-colors false
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ bold-color-same-as-fg false

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/ font "Hack 11.5"
}

function misc() {
    cd /tmp

    # Place installation of miscellaneous programs here

    # TODO c (valgrind)

    # TODO dockerconfig

    # TODO Terminfo etc.

    # TODO slack-term config

    # Install: icdiff
	curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/icdiff > /usr/local/bin/icdiff
	curl -sSL https://raw.githubusercontent.com/jeffkaufman/icdiff/master/git-icdiff > /usr/local/bin/git-icdiff
	chmod +x /usr/local/bin/icdiff
	chmod +x /usr/local/bin/git-icdiff

    cd "$HOME"
}

function wifi() {
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
    echo "  wifi {broadcom, intel}      - setup wifi drivers"
    echo "  graphics {laptop,desktop}   - setup graphics drivers"
    echo "  ssh                         - setup ssh & get keys"
    echo "  sources                     - setup sources & install base pkgs"
    echo "  bash [version]              - setup bash"
    echo "  gnome-molokai               - setup molokai colors for gnome"
    echo "  python                      - setup python packages"
    echo "  golang [version]            - setup golang language and packages"
    echo "  docker                      - setup docker"
    echo "  i3                          - setup i3"
    echo "  dotfiles                    - setup dotfiles"
    echo "  gcloud [version]            - setup gcloud"
    echo "  chrome                      - setup chrome"
    echo "  tmux                        - setup tmux"
    echo "  k8s                         - setup kubernetes"
    echo "  misc                        - setup miscellaneous programs"
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
    gcloud
    chrome
    tmux
    dotfiles
    k8s
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
    elif [[ $cmd == "gnome-molokai" ]]; then
        gnome_molokai
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
    elif [[ $cmd == "gcloud" ]]; then
		check_is_sudo
        gcloud "$2"
    elif [[ $cmd == "chrome" ]]; then
        chrome
    elif [[ $cmd == "tmux" ]]; then
        tmux
    elif [[ $cmd == "dotfiles" ]]; then
        dotfiles
    elif [[ $cmd == "k8s" ]]; then
        kubeconf
        minikube
    elif [[ $cmd == "misc" ]]; then
		check_is_sudo
        misc
    else
        usage
    fi
}

main "$@"
