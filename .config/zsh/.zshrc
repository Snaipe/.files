if [ -d "$XDG_CONFIG_HOME"/zsh ]; then
  for f in "$XDG_CONFIG_HOME"/zsh/?*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
