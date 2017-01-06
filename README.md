# Dotfiles
A set of basic development dotfiles for macOS.

## Usage
First, create a `vars.yml` file in `ansible/vars` using the sample file as a starting point:
```
cp ansible/vars/vars.yml.sample ansible/vars/vars.yml
```

Run the install script and when prompted, enter your user account password:
```
./install.sh
```

## Useful Commands
Run a specific set of commands again by tag name: `ansible-playbook -i ansible/inventory --ask-sudo-pass --tags="tag" ansible/playbook.yml`

## Todos
* Add tags to each task so re-running specific things is easier.
* Look at keeping SleepWatcher logs in `~/Library/Logs/SleepWatcher` so they can be viewed in the Console app.
* Implement parts of [Sensible Bash](http://mrzool.cc/writing/sensible-bash/).

## Links
- https://github.com/mathiasbynens/dotfiles
- https://github.com/ansible/ansible/issues/11695
- http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types
- http://ansible.pickle.io/post/86598332429/running-ansible-playbook-in-localhost
- http://superuser.com/questions/974714/previous-commands-wrapped-with-square-brackets-in-os-x-terminal
- http://fredkelly.net/articles/2014/10/19/developing_on_yosemite.html
- https://gist.github.com/g3d/2709563
- https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
