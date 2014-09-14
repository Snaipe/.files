#!/bin/sh
SCRIPT=$(readlink -f "$0")
DIR=$(dirname "$SCRIPT")

link() {
	local file="$1"; shift
	local dest="$1"; shift
	rm -f $dest > /dev/null
	ln -s $file $dest
}

for c in `cat .links`; do
	file=$(eval echo "${c%:*}")
	link=$(eval echo "${c##*:}")
	echo "link $link -> $DIR/$file"
	link "$DIR/$file" "$link"
done
