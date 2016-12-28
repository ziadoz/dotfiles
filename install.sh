#!/usr/bin/env bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo 'Installing Homebrew: '
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'Installing Ansible'
brew install ansible

echo 'Running Ansible Playbook'
ansible-playbook -i ansible/inventory --ask-sudo-pass ansible/playbook.yml

echo 'Done!'
