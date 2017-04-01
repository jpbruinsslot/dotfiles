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

print_green "==> Bootstrapping system"

# Make necessary directories
print_cyan "... Creating directories"
mkdir -p \
    $HOME/Projects \
    $HOME/.ssh

# Copy ssh-keys 
print_cyan "... Retrieving SSH keys from remote host"
read -p "--> Copy SSH keys from remote host? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "--> Please enter user@host: " HOST
    scp $HOST:~/.ssh/id_rsa* ~/.ssh/
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
fi

# Add additional repositories
print_cyan "... Adding additional repositories"
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:neovim-ppa/stable

# Synchronize package index files
print_cyan "... Synchronizing package index files"
sudo apt-get update

# Install new versions of all packages
print_cyan "... Installing new versions of all packages"
sudo apt-get -y dist-upgrade

# Install packages
print_cyan "... Installing system packages"
sudo apt-get install -y \
    vim \
    neovim \
    zsh \
    wget \
    curl \
    tree \
    git-core \
    openssh-server \
    build-essential \
    automake \
    libevent-dev \
    autoconf \
    pkg-config \
    libncurses5-dev \
    libncursesw5-dev \
    virtualbox \
    gnome-do \
    dconf-tools \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    numix-icon-theme-circle \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    htop \
    pulseaudio \
    xbacklight \
    sysstat \
    && sudo rm -rf /var/lib/apt/lists/*

# Install: Python packages
print_cyan "... Installing Python packages"
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --no-cache-dir --upgrade --force-reinstall \
    httpie \
    neovim \
    glances \
    docker-compose \
    psutil \
    tmuxp

# Needed for gsutil
sudo -H pip2 install --no-cache-dir --upgrade --force-reinstall \
    crcmod

# Install: Golang
print_cyan "... Installing Go programming language"
read -p "--> Please enter the version of Go you want to install: " GOVERSION
GOLANG=go$GOVERSION.linux-amd64

sudo rm -rf /usr/local/go

wget -O $GOLANG.tar.gz https://storage.googleapis.com/golang/$GOLANG.tar.gz 
sudo tar -C /usr/local -xzf $GOLANG.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install: Go packages
print_cyan "... Installing Go packages"
go get -u \
    github.com/erroneousboat/slack-term \
    github.com/erroneousboat/dot \
    github.com/jingweno/ccat \
    github.com/golang/dep/... \
    github.com/kardianos/govendor

# Install: oh-my-zsh
print_cyan "... Installing oh-my-zsh"
rm -rf ~/.oh-my-zsh
git clone --bare git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Install: Chrome (http://askubuntu.com/a/79284)
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# dpkg -i google-chrome*.deb
# apt-get install -f

# Install: Tmux
print_cyan "... Installing tmux"
rm -rf ~/tmux
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
cd

# Install: Docker
print_cyan "... Installing docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce

sudo usermod -a -G docker $USER
sudo service docker restart

# Install: GCloud
print_cyan "... Installing gcloud"
GCLOUD_VERSION=146.0.0
wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
tar -xzf google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-java app-engine-python kubectl alpha beta gcd-emulator pubsub-emulator
rm google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz

# Install: Minikube
print_cyan "... Installing minikube"
MINIKUBE_VERSION=v0.17.1
curl -Lo minikube https://storage.googleapis.com/minikube/releases/$MINIKUBE_VERSION/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

# Copy kubernetes config
print_cyan "... Retrieving kubernetes config from remote host"
read -p "--> Copy kubernetes config from remote host? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "--> Please enter user@host: " HOST
    scp -r $HOST:~/.kube/ ~
fi

# Install: Dotfiles
print_cyan "... Cloning dotfiles"
rm -rf ~/dotfiles
mkdir ~/dotfiles
cd ~/dotfiles
git clone git@github.com:erroneousboat/dotfiles.git
cd

# TODO Sync dotfiles

# TODO c (valgrind)

# TODO dockerconfig ?

# TODO Terminfo etc.

# TODO urvxt

# TODO slack-term config

# Install: Nerd Fonts
# (https://github.com/ryanoasis/nerd-fonts)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && \
    curl -fLo "Knack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Knack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf && \
    curl -fLo "Ubuntu Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Original/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf
cd

# Install: i3
print_cyan "... Installing i3"
echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get --allow-unauthenticated install sur5r-keyring
sudo apt-get update
sudo apt-get install i3

# Install: i3-blocks
print_cyan "... Installing i3-blocks"
rm -rf ~/i3-blocks
git clone git://github.com/vivien/i3blocks
cd i3blocks
make clean all
sudo make install
cd
rm -rf ~/i3blocks

# TODO Install: Bash 4
