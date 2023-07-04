## Set Tabname to Directory in Starship
function set_win_title() {

	title="${PWD:t2}"

	if [ -z ${JNSMDT_SERVERNAME+x} ]; then
		title="$JNSMDT_SERVERNAME - ${PWD:t2}"
	fi

	echo -ne "\033]0; "$title" \007"
}

precmd_functions+=(set_win_title)
