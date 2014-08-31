for f in $(/bin/ls .githooks); do
	ln -s ../../../../.zsh/.githooks/$f ../.git/modules/.zsh/hooks/$f
done
