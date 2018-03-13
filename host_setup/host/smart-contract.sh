#!/bin/bash

# Setup a host/VM for smart contract auditing.
#
# Can be called multiple times, but you will get multiple entries in your Readline and Bash init
# files since we append to them.

function print_status() {
    echo "[+] $1"
}

function prompt_yes_or_no() {
    while true; do
        read -p "$1 [y|n] "
        [ "${REPLY,,}" == "y" ] && return 0
        [ "${REPLY,,}" == "n" ] && return 1
    done
}

function prompt_default_reply() {
    read -p "$1 [$2]: "
    echo ${REPLY:-$2}
}

print_status "Installing packages."
sudo apt-get install -y \
    build-essential \
    python-pip \
    virtualenvwrapper \
    keepass2 \
    xdotool \
    git \
    git-cola \
    gitk \
    redshift-gtk \
    geany \
    geany-plugin-addons \
    geany-plugin-gproject \
    meld \
    tree \
    silversearcher-ag \
    p7zip-full \
    emacs \
    jq \
    python-doc \
    docker.io \
    curl \
    solc \
    spice-vdagent \
    libgconf-2-4

# allow user to talk to Docker daemon
sudo adduser $(id -nu) docker

print_status "Editing Bash init file to add case insensitive completion."
echo set completion-ignore-case on >> ~/.inputrc

print_status "Editing Bash init file to add git prompt."
cat >>~/.bashrc <<EOF
# added by $(basename $0) at $(date). For git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
EOF

print_status "Cloning Open Zeppelin repo."
pushd . &>/dev/null
mkdir -p ~/src/github/ && cd ~/src/github
git clone https://github.com/OpenZeppelin/zeppelin-solidity.git zeppelin-solidity.git
popd &>/dev/null

print_status "Installing Node and useful packages."
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
npm install -g solium
npm install -g solhint

print_status "Downloading Oyente analysis tool container."
docker pull luongnguyen/oyente

echo
echo 'Manual Stuff'
echo '* Typora (https://typora.io/)'
echo '* Configure Emacs'
echo '* Remix IDE. https://github.com/ethereum/remix-ide/'
echo '* Add Node bin path to PATH: export PATH=~/.npm-global/bin:$PATH'
echo '* Add git to PS1 prompt'
echo 'Read end of script for miscellaneous things'

exit

# Miscellaneous


