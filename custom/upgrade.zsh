function upgrade {
	upgrade_functions=()
	while [ $# -gt 0 ]; do
		arg="$1"
		shift

		if [[ "$arg" == "--all" ]]; then
			__upgrade_all
			return 0
		fi

		upgrade_functions+=("__upgrade_$arg")
	done

	for func in "${upgrade_functions[@]}"; do
		$func
	done
}

function __upgrade_system {
	sudo -v
	echo "\n### Updating apt Packages ###\n"
	sudo sudo apt update

	echo "\n### Upgrading apt Packages ###\n"
	sudo sudo apt upgrade -y
}

# Upgrade stuff
function __upgrade_starship {
	echo "\n### Upgrading Starship ###\n"
	curl -sS https://starship.rs/install.sh | sh -s -- -f >/dev/null
}

function __upgrade_pnpm {
	echo "\n### Upgrading PNPM ###\n"
	curl -fsSL https://get.pnpm.io/install.sh | sh - >/dev/null
}

function __upgrade_pyenv {
	echo "\n ### Upgrading Pyenv"
	pushd $(pyenv root)
	git pull --quiet
	popd
}

function __upgrade_go {
	echo "\n### Upgrading Go ###\n"
	gobrew self-update
	gobrew use latest
}

function __upgrade_all {
	__upgrade_system
	__upgrade_starship
	__upgrade_pyenv
	__upgrade_go
}
