{
typeset -T LD_LIBRARY_PATH ldpath :

export JAVA_HOME="/usr/lib/jvm/default"
export _JAVA_OPTIONS='
    -Dawt.useSystemAAFontSettings=on
    -Dswing.aatext=true
    -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
    -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export GTK_DISABLE_CSD=1

path=(~/.local/bin $path /usr/local/bin)
ldpath=(~/.local/lib $ldpath /usr/local/lib)

export PAGER=less
export READNULLCMD=$PAGER
export LESS=-FRSX
export EDITOR=vim

# XDG Stuff

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

xdg_vars=($(sed -E                  \
    -e '/^XDG_/!d'                  \
    -e 's/XDG_([^_]+)_DIR=.*/\1/'   \
    .config/user-dirs.dirs))

for v in $xdg_vars; do
  export XDG_${v}_DIR="$(xdg-user-dir $v)"
done

} >/dev/null 2>&1
