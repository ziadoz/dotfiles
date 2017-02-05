# Dotfiles
A set of basic development dotfiles for macOS.

## Usage
First, create a `vars.yml` file in `ansible/vars` using the sample file as a starting point:
```
cp ansible/vars/vars.yml.sample ansible/vars/vars.yml
```

Run the install script and when prompted, enter your user account password:
```
./install
```

## Useful Commands
Run a specific set of commands again by tag name:
```
ansible-playbook -i ansible/inventory --ask-sudo-pass --tags="tag" ansible/playbook.yml
```

## Todos
* Implement parts of [Sensible Bash](http://mrzool.cc/writing/sensible-bash/).
* Look at adding `httrack` to HomeBrew packages.
* Work out which existings apps on laptop can be installed via Cask and add them to the playbook.
* Use `apm` command to install Atom packages and themes. Need to get Atom and other apps installed too.

## Links
- https://github.com/mathiasbynens/dotfiles
- https://github.com/ansible/ansible/issues/11695
- http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types
- http://ansible.pickle.io/post/86598332429/running-ansible-playbook-in-localhost
- http://superuser.com/questions/974714/previous-commands-wrapped-with-square-brackets-in-os-x-terminal
- http://fredkelly.net/articles/2014/10/19/developing_on_yosemite.html
- https://gist.github.com/g3d/2709563
- https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
- https://johndjameson.com/blog/updating-your-shell-with-homebrew/
