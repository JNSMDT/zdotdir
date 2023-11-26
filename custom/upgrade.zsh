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
	# check if pnpm is installed at all
	if ! command -v pnpm &>/dev/null; then
		echo "PNPM is not installed. Installing..."
		curl -fsSL https://get.pnpm.io/install.sh | sh
		return 0
	fi

	# get latest pnpm version from github
	latest_pnpm_version=$(curl -s https://api.github.com/repos/pnpm/pnpm/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')

	# check if pnpm is up to date
	if [[ "v$(pnpm --version)" == "$latest_pnpm_version" ]]; then
		echo "PNPM is up to date."
		return 0
	fi

	# update pnpm
	echo "Updating PNPM to $latest_pnpm_version"
	archive_url="https://github.com/pnpm/pnpm/releases/download/${latest_pnpm_version}/pnpm-linux-x64"

	tmp_dir="$(mktemp -d)"
	trap 'rm -rf "$tmp_dir"' EXIT INT TERM HUP

	curl -fsSL "$archive_url" >"$tmp_dir/pnpm"
	chmod +x "$tmp_dir/pnpm"

	mv "$tmp_dir/pnpm" "/home/jan/.local/share/pnpm/"

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
	__upgrade_pnpm
	__upgrade_pyenv
	__upgrade_go
}
