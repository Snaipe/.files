for f in $(/bin/ls .githooks); do
	ln -s ../../.githooks/$f .git/hooks/$f
done
