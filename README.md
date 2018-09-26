# Dotfiles
My custom development dotfiles for macOS.

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

Run the playbook in dry-run mode:
```
ansible-playbook -i ansible/inventory --ask-sudo-pass ansible/playbook.yml --check --diff
```

Run the playbook with verbose output:
```
ansible-playbook -i ansible/inventory --ask-sudo-pass ansible/playbook.yml -v
```

## Todos
* Copy over VS Code settings JSON file and install extensions and colour scheme if possible.
* Download static `ffmpeg` binaries and drop them in `~/.bin`.
* Look at improving Git aliases by using full/better word choices (e.g. [Git Legit](http://www.git-legit.org/), [Stop Aiasing Core Commands](https://jason.pureconcepts.net/2017/03/stop-aliasing-core-git-commands/)), [Git Aliases](https://dev.to/nickytonline/my-git-aliases-5dea).
* Rewrite all `mode` options in `u=rw,g=r,o=r` style.

## Colour Scheme
[Oceanic Next](https://github.com/voronianski/oceanic-next-color-scheme)

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
- https://github.com/phpbrew/phpbrew
- https://gist.github.com/trovster/7c5f3ef82ad7f1539e7866f5d1958485
- https://gist.github.com/trovster/5f83a742ace0539da4047900ed617833
- https://www.jeffgeerling.com/blog/2018/use-ansibles-yaml-callback-plugin-better-cli-experience
