# vim:syntax=zsh
# prompt

setopt PROMPT_PERCENT

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

case "$SESSION_TYPE" in
      remote/*) primary_color=green;;
             *) primary_color=magenta;;
esac

prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print $4 -n $3
}

prompt_context() {
	prompt_segment "$primary_color" black '%{%F{black}%}%n%{%F{magenta}%}@'"$(hostname | cut -d. -f1)"
}

prompt_status() {
	prompt_segment "$primary_color" black "%(?,,%{%F{red}%}✘ )%(!,%{%F{yellow}%}⚡ ,)%(1j,%{%F{blue}%}%j ⚙ ,)"
}

prompt_dir() {
	prompt_segment "$primary_color" black '%2%~' -P
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

build_prompt() {
	[[ "$SESSION_TYPE" == "remote/*" ]] && prompt_context
	prompt_status
	prompt_dir
	echo -n " >"
	prompt_end
}

PROMPT=$'\n'"$(build_prompt) "
RPROMPT='(tty: %l) [%*]'
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
