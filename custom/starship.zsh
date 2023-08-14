## Set Tabname to Directory in Starship
function set_win_title() {
	title="${PWD:t2}"

	# if title is too long, show only current folder
	if [ ${#title} -gt 20 ]; then
		title="${PWD:t}"
	fi

	Icon="🖥️"
	# if $WINICON is set overwrite icon variable
	if [ -n "$WINICON" ]; then
		Icon="$WINICON"
	fi

	echo -ne "\033]0; "$WINICON \| $title" \007"
}

precmd_functions+=(set_win_title)
