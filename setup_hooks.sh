for f in $(/bin/ls .githooks); do
	ln -s ../../../../.X/.githooks/$f ../.git/modules/.X/hooks/$f
done
