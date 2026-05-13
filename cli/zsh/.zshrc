# Pure theme and prompt
# @see: https://github.com/sindresorhus/pure
if [ -d "$HOME/.zsh/pure" ]; then
    fpath+=($HOME/.zsh/pure)
    autoload -U promptinit; promptinit
    prompt pure
    zstyle :prompt:pure:git:stash show yes
fi

# Homebrew configuration
# @see: https://docs.brew.sh/Installation
eval "$($(brew --prefix)/bin/brew shellenv)"

# Auto suggestions
# @see: https://github.com/zsh-users/zsh-autosuggestions
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Exports
export EDITOR='nano'

export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'

export HOMEBREW_NO_ANALYTICS=1

# History
# @see: https://martinheinz.dev/blog/110
# @see: https://stackoverflow.com/questions/38549251/histignore-not-working-in-zsh
# @see: https://zsh.sourceforge.io/Doc/Release/Options.html
# @see: https://unix.stackexchange.com/questions/599641/why-do-i-have-duplicates-in-my-zsh-history
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(mkv2mp4)"
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# Paths
# @see: https://twitter.com/paulredmond/status/1204557648026144768
# @see: https://thoughtbot.com/blog/cding-to-frequently-used-directories-in-zsh
# @see: https://jcode.me/cdpath-with-zsh/
setopt autocd
cdpath=($HOME/Projects $HOME/Herd)

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %B%d%b
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories path-directories named-directories'

export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"

# Aliases

# Navigation
alias ..="cd .."
alias ~="cd ~"
alias ls="ls -GpF"

# Shell
alias sudo='sudo '
alias badge="tput bel"
alias reloadshell="exec $SHELL -l"
alias editshell="$EDITOR ~/.zshrc"
alias edithosts="$EDITOR /etc/hosts"

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr \"\$(route get default | awk '/interface:/{print \$2}')\""

# Checksums
command -v hexdump > /dev/null || alias hd="hexdump -C"
command -v md5sum > /dev/null || alias md5sum="md5"
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Utilities
alias prettypath="echo \$PATH | tr ':' '\n'"
alias serve="php -S localhost:8000"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias lowered="tr '[:upper:]' '[:lower:]'"
alias uppered="tr '[:lower:]' '[:upper:]'"

# Functions
# @see: https://github.com/sindresorhus/pure/issues/664#issuecomment-2816794108
# @see: https://apple.stackexchange.com/a/478437
function shell_session_save() {
  if [ -n "$SHELL_SESSION_FILE" ]; then
    local save_lock_file="$SHELL_SESSION_DIR/_saving_lockfile"
    if /usr/bin/shlock -f "$save_lock_file" -p $$; then
      echo -ne '\nSaving session...' >&2
      (umask 077; echo 'echo Restored session: "$(/bin/date -r '$(/bin/date +%s)')"' >| "$SHELL_SESSION_FILE")

      whence shell_session_save_user_state >/dev/null && shell_session_save_user_state "$SHELL_SESSION_FILE"
      local f
      for f in $shell_session_save_user_state_functions; do
          $f "$SHELL_SESSION_FILE"
      done

      shell_session_history_allowed && shell_session_save_history
      echo 'completed.' >&2
      /bin/rm "$save_lock_file"
    fi
  fi
}
