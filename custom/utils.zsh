function isWSL {
	if [[ "$(uname -r)" == *"microsoft"* ]]; then
		echo "WSL detected"
		return 1
	fi

	return 0
}

function package {
	declare pm="pnpm"
	if [ -f "package-lock.json" ]; then
		pm="npm"
	elif [ -f "yarn.lock" ]; then
		pm="yarn"
	elif [ -f "bun.lockb" ]; then
		pm="bun"
	fi
	echo "Using package manager: $pm"
	"$pm" "$@"
}

alias p="package"