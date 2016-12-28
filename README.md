# Dotfiles
These are my dotfiles to for development on Mac OS X. The `.aliases` and `.exports` files are taken and stripped down versions of [Mathias Bynens's Dotfiles](https://github.com/mathiasbynens/dotfiles).

## Usage
First, create a `vars.yml` file in `ansible/vars` using the sample file as a starting point:
```
cp ansible/vars/vars.yml.sample ansible/vars/vars.yml
```

Run the install script and when prompted, enter your user account password:
```
./install.sh
```

## Todos
* Add `.macos` script from [Mathias Bynens's Dotfiles](https://github.com/mathiasbynens/dotfiles).
* Implement parts of [Sensible Bash](http://mrzool.cc/writing/sensible-bash/).

## Links
- https://github.com/ansible/ansible/issues/11695
- http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types
- http://ansible.pickle.io/post/86598332429/running-ansible-playbook-in-localhost
- http://superuser.com/questions/974714/previous-commands-wrapped-with-square-brackets-in-os-x-terminal
