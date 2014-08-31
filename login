if [ -z "$SSH_AGENT_PID" ]; then
{
	eval $(ssh-agent)
	trap "kill $SSH_AGENT_PID" 0
} >/dev/null
fi
