# Fallback to vim/vi/ed if editor is broken
editors=("$EDITOR" vim vi ed)
unset EDITOR
for e in $editors; do
    if command -v "$e" >/dev/null 2>&1; then
        EDITOR="$e"
        break
    fi
done
unset e
