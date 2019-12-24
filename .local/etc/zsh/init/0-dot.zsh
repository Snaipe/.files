alias dot='PATH="$PATH:$XDG_CONFIG_HOME/dotgit/bin" git --git-dir="$XDG_CONFIG_HOME/dotgit/repo" --work-tree="$HOME"'

source() {
    what="$1"
    case "$what" in
        ./*|../*|~*|/*)
            ;;
        *)
            what="$(dot i-filept "$@" | head -n 1)";;
    esac
    builtin source "$what"
}

.() {
    source "$@"
}
