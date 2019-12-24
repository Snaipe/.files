if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case "$(ps -o comm= -p $PPID)" in
    sshd|*/sshd|mosh-server|*/mosh-server) SESSION_TYPE=remote/ssh;;
  esac
fi

export SESSION_TYPE="${SESSION_TYPE:-local}"
