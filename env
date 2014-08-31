{
alias map=typeset -A
alias bind=typeset -T
alias var=typeset

bind LD_LIBRARY_PATH ldpath
bind EDITOR editor
bind PAGER pager
bind READNULLCMD nullpager
bind LESS less
typeset -U path ldpath

export JAVA_HOME="/usr/lib/jvm/java-7-openjdk/"
export ANDROID_HOME="/home/snaipe/ides/adt-bundle-linux-x86_64-20140321/sdk"

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

path=(~/bin $ANDROID_HOME/tools $ANDROID_HOME/platform-tools ~/.gem/ruby/2.1.0/bin $path)
ldpath=(/usr/local/lib $ldpath)
editor=vim
pager=less
nullpager=$pager
less=-FX

} >/dev/null 2>&1
