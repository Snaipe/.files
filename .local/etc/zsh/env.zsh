# Source user environment

envgen=/usr/lib/systemd/user-environment-generators/29-systemd-environment-d-generator
set -a
if [ -x "$envgen" ]; then
    . <("$envgen")
else
    if [ -d "$XDG_CONFIG_HOME"/environment.d ] ; then
        for f in "$XDG_CONFIG_HOME"/environment.d/?*.conf ; do
            . "$f"
        done
        unset f
    fi
fi
if [ -d "$XDG_CONFIG_HOME"/environment.d ] ; then
    for f in "$XDG_CONFIG_HOME"/environment.d/?*.sh ; do
        if [ -x "$f" ]; then
            . "$f"
        fi
    done
    unset f
fi
set +a
