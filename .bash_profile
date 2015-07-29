# Homebrew Path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Ruby Environment Path
export PATH="$HOME/.rbenv/bin:$PATH"

# Composer Paths
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="./vendor/bin:$PATH"

# Local Binary Path
export PATH="~/.bin:$PATH"

# Load Dot Files
# See: https://github.com/mathiasbynens/dotfiles
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Editor
export EDITOR='subl -w'

# Ruby Environment
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
fi

# Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
# shopt -s histappend;

# Autocorrect typos in path names when using `cd`
# shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# for option in autocd globstar; do
#     shopt -s "$option" 2> /dev/null;
# done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
# complete -W "NSGlobalDomain" defaults;

# Aliases
alias editbash="${EDITOR} ~/.bash_profile"
alias reloadbash="reload"
alias reloadhosts="flush"
alias edithosts="${EDITOR} /etc/hosts"
