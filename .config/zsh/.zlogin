if [ -z "$SSH_AGENT_PID" ]; then
{
	eval $(ssh-agent)
} >/dev/null 2>/dev/null
fi
