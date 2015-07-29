#!/usr/bin/env bash

# Ask for password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo 'Installing Homebrew: '
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all

echo 'Installing Bash '
brew install bash bash-completion
echo 'Add /usr/local/bin/bash to /etc/shells '
echo 'Then run chsh -s /usr/local/bin/bash '

echo 'Installing VCS: '
brew install git mercurial svn

echo 'Installing Languages: '
brew ruby-build rbenv lua

echo 'Installing Media Packages: '
brew install ffmpeg 
brew install imagemagick --with-webp

echo 'Installing Shell Utilities: '
brew install wget --with-iri 
brew install tree ncdu mosh archey ack p7zip 

echo 'Installing HTTP Utilities: '
brew install httpie lynx

echo 'Installing Ansible: '
brew install ansible

echo 'Installing PHP Tap: '
brew tap josegonzalez/php

echo 'Install Composer: '
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo 'Cleaning Up '
brew cleanup
