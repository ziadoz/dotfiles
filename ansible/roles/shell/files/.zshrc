# Pure theme and prompt
# https://github.com/sindresorhus/pure
# fpath+=$HOME/.zsh/pure
# autoload -U promptinit; promptinit
# prompt pure

# Powerlevel10k theme and prompt
# https://github.com/romkatv/powerlevel10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Auto suggestions
# https://github.com/zsh-users/zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load custom dotfiles
for file in ~/.zsh_{paths,prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
