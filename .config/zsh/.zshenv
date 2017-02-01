{
alias map=typeset -A
alias bind=typeset -T
alias var=typeset

typeset -T LD_LIBRARY_PATH ldpath
typeset -U path ldpath

export JAVA_HOME="/usr/lib/jvm/default"
export ANDROID_HOME="/opt/android-sdk"

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export XDG_DESKTOP_DIR="$HOME"
export GTK_DISABLE_CSD=1

path=(~/bin /usr/bin $ANDROID_HOME/tools $ANDROID_HOME/platform-tools ~/.gem/ruby/2.2.0/bin /opt/gnuarmeclipse/qemu/bin/ $path)
ldpath=(/usr/local/lib /lib /usr/lib $ldpath)

export PAGER=less
export READNULLCMD=$PAGER
export LESS=-FRSX
export EDITOR=vim

# XDG Stuff
xdg_vars=($(sed -E                  \
    -e '/^XDG_/!d'                  \
    -e 's/XDG_([^_]+)_DIR=.*/\1/'   \
    .config/user-dirs.dirs))

for v in $xdg_vars; do
  export XDG_${v}_DIR="$(xdg-user-dir $v)"
done

} >/dev/null 2>&1
