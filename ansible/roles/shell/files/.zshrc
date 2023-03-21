# Homebrew configuration
# https://docs.brew.sh/Installation
if [ "$(command -v brew)" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Pure theme and prompt
# https://github.com/sindresorhus/pure
if [ "$(command -v brew)" ]; then
    fpath+=("$(brew --prefix)/share/zsh/site-functions")
    autoload -U promptinit; promptinit
    prompt pure
    zstyle :prompt:pure:git:stash show yes
fi

# Auto suggestions
# https://github.com/zsh-users/zsh-autosuggestions
if [ -f "/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load custom dotfiles
for file in ~/.zsh_{paths,prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
