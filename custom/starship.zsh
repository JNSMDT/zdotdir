## Set Tabname to Directory in Starship
function set_win_title() {
	title="$HOST - ${PWD:t2}"
	echo -ne "\033]0; "$title" \007"
}

precmd_functions+=(set_win_title)
