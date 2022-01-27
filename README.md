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
* Rewrite all `mode` options in `u=rw,g=r,o=r` style.
* Look at using [prompts](https://docs.ansible.com/ansible/latest/user_guide/playbooks_prompts.html) for certain steps.
* Add an [EditorConfig](https://editorconfig.org/) with [PHP settings](https://www.johnmackenzie.co.uk/post/my-modern-php-development-setup/).
* Start storing Windows configurations (e.g. Terminal `settings.json`).
* Look as using a [Brewfile](https://thoughtbot.com/blog/brewfile-a-gemfile-but-for-homebrew).

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
- https://github.com/voronianski/oceanic-next-color-scheme
