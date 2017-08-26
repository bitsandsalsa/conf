#!/bin/bash

# Setup a host/VM for webapp development.

function print_status() {
	echo "[+] $1"
}

print_status "Installing packages."
sudo apt-get install -y \
	 git \
	 git-cola \
	 gitk \
	 tree \
	 silversearcher-ag \
	 jq \
	 meld

echo
echo 'Manual Stuff'
echo '* Typora (https://typora.io/)'
echo '* React Dev Tools Firefox extension'
echo '* Node.js from web because package repo is old'
echo '  * https://docs.npmjs.com/getting-started/fixing-npm-permissions'
echo '* docs: JavaScript, React, CSS'
echo '* openssh-server for file transfer between host and VM'
echo '* Brackets (https://brackets.io/)'
echo '* node install create-react-app'
