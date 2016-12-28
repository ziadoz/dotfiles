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
* Implement parts of [Sensible Bash](http://mrzool.cc/writing/sensible-bash/).
* Look into using Homebrew Cask to install apps (see [Developing on Yosemite](http://fredkelly.net/articles/2014/10/19/developing_on_yosemite.html)).
* Add `.macos` script from [Mathias Bynens's Dotfiles](https://github.com/mathiasbynens/dotfiles).
* Add ignore lines to host files.

## Links
- https://github.com/ansible/ansible/issues/11695
- http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types
- http://ansible.pickle.io/post/86598332429/running-ansible-playbook-in-localhost
