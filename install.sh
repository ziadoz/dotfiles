#!/usr/bin/env bash

# Ask for password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo 'Installing Homebrew: '
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade --all

echo 'Installing VCS: '
brew install git mercurial svn

echo 'Installing Ansible: '
brew install ansible

echo 'Installing Languages: '
brew ruby-build rbenv

echo 'Installing Shell Utilities: '
brew install wget --with-iri
brew install tree ncdu mosh archey screenfetch ack p7zip

echo 'Installing Utilities: '
brew install httpie sleepwatcher stow

echo 'Cleaning Up '
brew cleanup
brew prune

echo 'Done!'
