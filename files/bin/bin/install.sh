#!/bin/bash

# http://www.davidpashley.com/articles/writing-robust-shell-scripts/
set -o errexit
set -o pipefail

# Make necessary directories
function dir() {
    echo ">>> Creating directories"
    mkdir -p \
	    $HOME/Projects \
        $HOME/Downloads
}

# Copy ssh-keys 
function ssh() {
    echo ">>> Setting up ssh"

    echo "... Create ssh directory"
    mkdir -p $HOME/.ssh

    echo "... Retrieving SSH keys from remote host"
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
	echo ">>> Adding additional repositories"
	apt update || true
	apt install -y \
		apt-transport-https \
		ca-certificates \
		curl \
		dirmngr \
		gnupg2 \
		lsb-release \
		--no-install-recommends

	cat <<-EOF > /etc/apt/sources.list
	deb http://httpredir.debian.org/debian stretch main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch main contrib non-free

	deb http://httpredir.debian.org/debian/ stretch-updates main contrib non-free
	deb-src http://httpredir.debian.org/debian/ stretch-updates main contrib non-free

	deb http://security.debian.org/ stretch/updates main contrib non-free
	deb-src http://security.debian.org/ stretch/updates main contrib non-free
	EOF

	# deb http://httpredir.debian.org/debian experimental main contrib non-free
	# deb-src http://httpredir.debian.org/debian experimental main contrib non-free

    # Neovim
	cat <<-EOF > /etc/apt/sources.list.d/neovim.list
	deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main
	deb-src http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu xenial main
	EOF

    # TLP: advanced linux power management
	echo "deb http://repo.linrunner.de/debian stretch-backports main" > /etc/apt/sources.list.d/tlp.list

    # Google Chrome
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

    # Add the neovim ppa gpg key
	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

    # Add the tlp apt-repo gpg key
	apt-key adv --keyserver pool.sks-keyservers.net --recv-keys CD4E8809

    # Add the google chrome public key
    curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
}

function base() {
    echo ">>> Installing base packages"

    echo "... Synchronizing package index files"
    apt update || true

    echo "... Installing new versions of all packages"
    apt -y dist-upgrade

    echo "... Installing system packages"
    # Graveyard:
    #   autoconf \
    #   acpi \
    #   automake \
    #   build-essential \
    #   dconf-tools \
    #   libevent-dev \
    #   libncurses5-dev \
    #   libncursesw5-dev \
    #   linux-image-extra-$(uname -r) \
    #   linux-image-extra-virtual \
    #   sysstat \
    #   virtualbox \

    apt install -y \
        bash-completion \
        bc \
        ca-certificates \
        coreutils \
        curl \
        dnsutils \
		font-hack-ttf \
        git-core \
        gnupg \
        gnupg2 \
        google-chrome-stable \
        htop \
        indent \
        jq \
        neovim \
        openssh-server \
        pkg-config \
        python-dev \
        python-pip \
        python3-dev \
        python3-pip \
        python3-setuptools \
        rofi \
        rxvt-unicode-256color \
        silversearcher-ag \
        strace \
        tar \
        tlp \
        tree \
        unzip \
        urlview \
        vim \
        wget \
        xclip \
        --no-install-recommends

    echo "... Cleaning up"
    apt autoremove
    apt autoclean
    apt clean
}

# Install: graphics drivers
function graphics() {
    echo ">>> Installing graphics drivers"
	local system=$1

	if [[ -z "$system" ]]; then
		echo "You need to specify it's intel, geforce or optimus"
		exit 1
	fi

    local pkgs=( xorg xserver-xorg xserver-xorg-input-libinput xserver-xorg-input-synaptics )

	case $system in
		"intel")
			pkgs+=( xserver-xorg-video-intel )
			;;
		"geforce")
			pkgs+=( nvidia-driver )
			;;
		"optimus")
			pkgs+=( nvidia-kernel-dkms bumblebee-nvidia primus )
			;;
		*)
			echo "You need to specify whether it's intel, geforce or optimus"
			exit 1
			;;
	esac

    # Update grub to solve login loop
    #
    # Source:
    #   - https://askubuntu.com/a/867647
    # sed -i 's/splash//g' /etc/default/grub
    # update-grub2

    apt update || true
    apt -y dist-upgrade
	apt install -y "${pkgs[@]}" --no-install-recommends
}

function python() {
    # Install: Python3 packages
    echo ">>> Installing Python packages"

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
    # crcmod: needed for gsutil
    # neovim: needed for deoplete
    sudo -H pip2 install --upgrade pip
    sudo -H pip2 install --no-cache-dir --upgrade --force-reinstall \
        crcmod \
        neovim
}

# Install: Golang
function golang() {
    echo ">>> Installing Golang"

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
    echo "... Installing Golang packages"
    go get -u \
        github.com/erroneousboat/slack-term \
        github.com/erroneousboat/dot \
        github.com/jingweno/ccat \
        github.com/golang/dep/... \
        github.com/kardianos/govendor \
        github.com/derekparker/delve/cmd/dlv
}

# Install: Docker
function docker() {
    echo ">>> Installing docker"

    echo "... Installing prerequisites"
    sudo apt update || true
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        gnupg2 \
        software-properties-common \
        usermod \
        --no-install-recommends

    # Download
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

    # Add key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    # Install
    sudo apt update || true
    sudo apt install -y docker-ce

    # Configure
    sudo usermod -a -G docker $USER
    sudo service docker restart
}

# Install: Tmux
function tmux() {
    echo ">>> Installing tmux"

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
    echo ">>> Installing gcloud"

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
    echo ">>> Install minikube"

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
    echo ">>> Install kubernetes configuration"

    read -p "--> Copy kubernetes config from remote host? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "--> Please enter user@host: " HOST
        scp -r $HOST:~/.kube/ ~
    fi
}

# Install: Dotfiles
function dotfiles() {
    echo ">>> Install dotfiles"

    if [[ ! -d "$HOME"/dotfiles ]]; then
        echo "... Cloning dotfiles"
        git clone git@github.com:erroneousboat/dotfiles.git "${HOME}/dotfiles"
    else
        cd "$HOME/dotfiles"
        git pull origin master
    fi

    echo "... Syncing dotfiles"
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
    echo ">>> Installing i3"
    echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" | sudo tee -a /etc/apt/sources.list
    sudo apt-get update
    sudo apt-get --allow-unauthenticated install sur5r-keyring
    sudo apt-get update
    sudo apt-get install -y i3
}

# Install: i3-apps
function i3apps() {
    echo ">>> Installing i3-apps"

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
    echo ">>> Installing bash"

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
    echo ">>> Monokai for gnome-terminal"

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

	# Install: numix icons
	rm -rf /tmp/numix-icon-theme-circle
	git clone https://github.com/numixproject/numix-icon-theme-circle.git
	cp -r /tmp/numix-icon-theme-circle/Numix-Circle ~/.local/share/icons

	# Pretty fonts
	# https://wiki.archlinux.org/index.php/font_configuration
	cat <<-EOF > /etc/fonts/local.conf
	<?xml version='1.0'?>
	<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
	<fontconfig>
    	<!-- pixel allignment, it needs to know what monitor type you're using -->
    	<match target="font">
        	<edit mode="assign" name="rgba">
            	<const>rgb</const>
        	</edit>
    	</match>
    	<!-- adjust the display of an outline font so that it lines up with a rasterized grid -->
    	<match target="font">
        	<edit mode="assign" name="hinting">
        		<bool>true</bool>
        	</edit>
    	</match>
    	<!-- amount of font reshaping done to line up to the grid -->
    	<match target="font">
        	<edit mode="assign" name="hintstyle">
            	<const>hintslight</const>
        	</edit>
    	</match>
    	<!-- remove jagged edges due to font rasterization -->
    	<match target="font">
        	<edit mode="assign" name="antialias">
            	<bool>true</bool>
        	</edit>
    	</match>
    	<!-- reduce colour fringing -->
    	<match target="font">
        	<edit mode="assign" name="lcdfilter">
            	<const>lcddefault</const>
        	</edit>
    	</match>
	</fontconfig>
	EOF

	echo "Fonts file setup successfully now run:"
	echo "  (sudo) dpkg-reconfigure fontconfig-config"
	echo "with settings: "
	echo "  Autohinter, Automatic, No."
	echo "Run: "
	echo "  (sudo) dpkg-reconfigure fontconfig"

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
    echo "This script can install and setup the following on a debian based system:"
    echo
    echo "Usage:"
    echo "  sources                             - setup sources"
    echo "  base                                - install base pkgs"
    echo "  dir                                 - setup all necessary directories"
    echo "  ssh                                 - setup ssh & get keys"
    echo "  dotfiles                            - setup dotfiles"
    echo "  wifi {broadcom, intel}              - setup wifi drivers"
    echo "  graphics {intel, geforce, optimus}  - setup graphics drivers"
    echo "  bash [version]                      - setup bash"
    echo "  gnome-molokai                       - setup molokai colors for gnome"
    echo "  python                              - setup python packages"
    echo "  golang [version]                    - setup golang language and packages"
    echo "  docker                              - setup docker"
    echo "  gcloud [version]                    - setup gcloud"
    echo "  chrome                              - setup chrome"
    echo "  tmux                                - setup tmux"
    echo "  k8s                                 - setup kubernetes"
    echo "  misc                                - setup miscellaneous programs"
    echo "  i3                                  - setup i3"
}

main() {
    local cmd=$1

    if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

    if [[ $cmd == "dir" ]]; then
        dir
    elif [[ $cmd == "sources" ]]; then
		check_is_sudo
		sources
    elif [[ $cmd == "base" ]]; then
		check_is_sudo
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
        check_is_sudo
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
