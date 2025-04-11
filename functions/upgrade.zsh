function getLatestVersion() {
	latest_version=$(curl -s "https://api.github.com/repos/$1/releases/latest" | jq -r '.tag_name')
	echo $latest_version
}

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

	current_version="v$(starship --version | grep -oP 'starship \K.*')"
	latest_version=$(getLatestVersion "starship/starship")

	echo "Current version: $current_version"
	echo "Latest version: $latest_version"

	if [[ $current_version == $latest_version ]]; then
		echo "Starship is up to date."
		return 0
	fi

	echo "Updating Starship to $latest_version"

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
	latest_version=$(getLatestVersion "pnpm/pnpm")
	current_version="v$(pnpm --version)"

	echo "Current version: $current_version"
	echo "Latest version: $latest_version"

	# check if pnpm is up to date
	if [[ $current_version == "$latest_version" ]]; then
		echo "PNPM is up to date."
		return 0
	fi

	# update pnpm
	echo "Updating PNPM to $latest_version"
	archive_url="https://github.com/pnpm/pnpm/releases/download/${latest_version}/pnpm-linux-x64"

	tmp_dir="$(mktemp -d)"
	trap 'rm -rf "$tmp_dir"' EXIT INT TERM HUP

	curl -fsSL "$archive_url" >"$tmp_dir/pnpm"
	chmod +x "$tmp_dir/pnpm"

	mv "$tmp_dir/pnpm" "$HOME/.local/share/pnpm/"

}

function __upgrade_uv {
	uv self update
}

function __upgrade_node {
	echo "\n### Upgrading Node ###\n"
	# check if node is installed at all
	if ! command -v node &>/dev/null; then
		echo "Node is not installed. Installing..."
		fnm install --lts
		return 0
	fi

	# get latest node version from github
	latest_version=$(fnm ls-remote --lts | tail -n 1 | grep -oP 'v\d+\.\d+\.\d+')
	current_version="$(node --version)"

	echo "Current LTS version: $current_version"
	echo "Latest LTS version: $latest_version"

	# check if node is up to date
	if [[ $current_version == "$latest_version" ]]; then
		echo "Node is up to date."
		return 0
	fi

	# update node
	echo "Updating Node to $latest_version"
	fnm install $latest_version
	fnm use $latest_version
}

# function __upgrade_pyenv {
# 	echo "\n ### Upgrading Pyenv"
# 	pushd $(pyenv root)
# 	git pull --quiet
# 	popd
# }

function __upgrade_go {
	echo "\n### Upgrading Go ###\n"
	gobrew self-update
	gobrew use latest
}

function __upgrade_all {
	__upgrade_system
	__upgrade_starship
	__upgrade_pnpm
	__upgrade_node
	__upgrade_uv
	__upgrade_go
}
