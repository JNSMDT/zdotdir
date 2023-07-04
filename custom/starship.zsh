## Set Tabname to Directory in Starship
function set_win_title() {

	title="$PWD"

	if [ -z ${JNSMDT_SERVERNAME+x} ]; then
		title="$JNSMDT_SERVERNAME - $PWD"
	fi

	echo -ne "\033]0; $(expr "$title" : '.*/\([^/]*/[^/]*\)$') \007"
}

precmd_functions+=(set_win_title)
