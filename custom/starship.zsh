## Set Tabname to Directory in Starship
function set_win_title() {
	title="${PWD:t2}"

	# if title is too long, show only current folder
	if [ ${#title} -gt 20 ]; then
		title="${PWD:t}"
	fi

	# get only upperase letter from $HOST variable
	HOST=$(echo $HOST | tr -dc '[:upper:]')

	echo -ne "\033]0; "$HOST \| $title" \007"
}

precmd_functions+=(set_win_title)
