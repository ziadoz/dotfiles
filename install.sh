#!/usr/bin/env bash

echo 'Installing Homebrew: '
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Installing VCS: '
brew install git mercurial svn

echo 'Installing Ruby: '
brew ruby-build rbenv

echo 'Installing Media Packages: '
brew install ffmpeg imagemagick

echo 'Installing Shell Utilities: '
brew install wget tree ncdu mosh archey

echo 'Installing HTTP Utilities: '
brew install httpie

echo 'Installing Ansible: '
brew install ansible

echo 'Installing PHP Tap: '
brew tap josegonzalez/php

echo 'Install Composer: '
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
