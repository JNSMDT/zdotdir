## Set Tabname to Directory in Starship
function set_win_title() {

	title="${PWD:t2}"

	# if title is too long, show only current folder
	if [ ${#title} -gt 20 ]; then
		title="${PWD:t}"
	fi

	# if i'm not in wsl add hostname to title
	if [ ! -f /proc/sys/kernel/osrelease ]; then
		title="$title @ $(hostname)"
	fi

	echo -ne "\033]0; "$title" \007"
}

precmd_functions+=(set_win_title)
