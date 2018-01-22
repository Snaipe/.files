HISTFILE="$XDG_CACHE_HOME"/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000

mkdir -p "$(dirname "$HISTFILE")"
touch "$HISTFILE"

autoload -U compinit promptinit colors
compinit
promptinit
colors

zstyle ':completion:*' completer _complete _ignored _files

setopt HIST_IGNORE_DUPS

setopt BANG_HIST
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

set mouse=a
