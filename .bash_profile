# MySQL Path
# export PATH="/usr/local/mysql/bin:$PATH"

# PHP Liip Path
# export PATH="/usr/local/php5/bin:$PATH"

# Homebrew Path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Ruby Environment Path
export PATH="$HOME/.rbenv/bin:$PATH"

# Composer Paths
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="./vendor/bin:$PATH"

# Local Binary Path
export PATH="~/bin:$PATH"

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

# Bash Completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Aliases
alias editbash="subl ~/.bash_profile"
alias reloadbash="reload"
alias reloadhosts="flush"