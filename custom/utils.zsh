function isWSL {
	if [[ "$(uname -r)" == *"microsoft"* ]]; then
		echo "WSL detected"
		return 1
	fi

	return 0
}
