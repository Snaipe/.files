#!/bin/zsh

# Source xdg fixes
if [ -d "$XDG_CONFIG_HOME"/xdg-fixes ] ; then
 for f in "$XDG_CONFIG_HOME"/xdg-fixes/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
