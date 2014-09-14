for f in $(/bin/ls .githooks); do
	ln -s ../../../../.xmonad/.githooks/$f ../.git/modules/.xmonad/hooks/$f
done
