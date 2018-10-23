#/bin/bash

# completion function
_vsp_completions() {
	## lock completion to first arg only
	if [ "${#COMP_WORDS[@]}" != "2" ]; then
		return
	fi

	## temporarily set WIDTH to 0
	local WIDTH=$(bind -v | sed -n 's/^set completion-display-width //p')
	if [[ $WIDTH -ne 0 ]]; then
		bind "set completion-display-width 0"
		PROMPT_COMMAND="PROMPT_COMMAND=$(printf %q "$PROMPT_COMMAND")"
		PROMPT_COMMAND+="; bind 'set completion-display-width $WIDTH'"
	fi

	## build command array
	local SUGGESTIONS=($(compgen -W "$(vsp list)" -- "${COMP_WORDS[1]}"))

	## return commands
	COMPREPLY=("${SUGGESTIONS[@]}")
}

complete -F _vsp_completions vsp
