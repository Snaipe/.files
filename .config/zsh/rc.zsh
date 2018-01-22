if [ -d "$XDG_CONFIG_HOME"/zsh/init ]; then
  for f in "$XDG_CONFIG_HOME"/zsh/init/?*.zsh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
