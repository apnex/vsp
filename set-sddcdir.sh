#!/bin/bash
echo "export SDDCDIR = [${PWD}/cfg]"
export SDDCDIR="${PWD}/cfg"

# copy bash completions to /etc/bash_completion.d/
# auto-generate completion.bash file?
for FILE in ${PWD}/*; do
	if [[ $FILE =~ ([^/]+completion[.]bash)$ ]]; then
		echo "install [${BASH_REMATCH[1]}] to [/etc/bash_completion.d/]"
		\cp -f "$FILE" /etc/bash_completion.d/
	fi
done
