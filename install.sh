#!/usr/bin/env bash

if ! which brew > /dev/null; then
    echo 'Installing Homebrew: '
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! brew info cask &>/dev/null; then
  echo 'Installing Cask: '
  brew tap caskroom/cask
fi

if ! which ansible > /dev/null; then
  echo 'Installing Ansible'
  brew install ansible
fi

echo 'Running Ansible Playbook'
ansible-playbook -i ansible/inventory --ask-sudo-pass ansible/playbook.yml

echo 'Done!'
