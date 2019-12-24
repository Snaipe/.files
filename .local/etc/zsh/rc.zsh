if [ -d "$ZDOTDIR"/init ]; then
  for f in "$ZDOTDIR"/init/?*.zsh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
