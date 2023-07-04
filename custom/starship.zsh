## Set Tabname to Directory in Starship
function set_win_title() {

	title="${PWD:t2}"
	if [[ -$parameters[JSERVERNAME]- = *-export-* ]]; then
		title="${JSERVERNAME} - ${PWD:t2}"
	fi

	echo -ne "\033]0; "$title" \007"
}

precmd_functions+=(set_win_title)
