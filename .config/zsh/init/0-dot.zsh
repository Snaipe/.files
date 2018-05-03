alias dot='PATH="$PATH:$HOME/.config/dotgit/bin" git --git-dir="$HOME/.config/dotgit/repo" --work-tree="$HOME"'

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
