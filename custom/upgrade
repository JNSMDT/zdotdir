function upgrade {
	upgrade_functions=()
	while [ $# -gt 0 ]; do
		arg="$1";
		shift

		if [[ "$arg" == "all" ]]; then
			__upgrade_all
			return 0
		fi

		upgrade_functions+=("__upgrade_$arg")
	done

	for func in "${upgrade_functions[@]}"; do
		$func
	done
}	

# Github get latest release
function __get_latest_release {
	curl --silent -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$1/releases/latest" | # Pluck JSON value
	grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

function __upgrade_packages {
	sudo -v
	echo "\n### Updating apt Packages ###\n"
	sudo nala update

	echo "\n### Upgrading apt Packages ###\n"
	sudo nala upgrade -y
}

# Upgrade stuff
function __upgrade_starship {
	vstring=$(starship --version | head -n 1)
	localv=v${vstring:9}

	latestv=$(__get_latest_release "starship/starship")

	if [ "$latestv" != "$localv" ]; then
		echo "\n### Upgrading Starship to Version $latestv ###\n"
		sh -c "$(curl --silent -fsSL https://starship.rs/install.sh)" -- -y
	fi
}

function __upgrade_volta {
	echo "\n### Upgrading Volta ###\n"
	curl --silent -s https://get.volta.sh | bash 
}

function __upgrade_volta_tools {
	echo "\n### Upgrading Volta Tools ###\n"
	volta install node@lts
	volta install pnpm@latest
	volta install npm@latest
	volta install miniflare@latest
	volta install wrangler@latest
}

function __upgrade_pyenv {
	localv=v$(pyenv --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
	latestv=$(__get_latest_release "pyenv/pyenv") 

	if [ "$latestv" != "$localv" ]; then
		echo "\n### Upgrading pyenv to Version $latestv ###"
		pushd $(pyenv root)
		git pull --quiet
		popd
	else
		echo "pyenv is up to date"
	fi
}

function __upgrade_rust {
	echo "\n### Upgrading Rust Toolchain ###\n"
	rustup update
}

function __upgrade_cargo_packages {
	echo "\n### Upgrading Cargo Packages ###\n"
	cargo install-update --all
}

function __upgrade_go {
	echo "\n### Upgrading Go ###\n"
	gobrew use latest
}

function __upgrade_all {
	__upgrade_packages
	__upgrade_starship
	__upgrade_volta
	__upgrade_volta_tools
	__upgrade_pyenv
	__upgrade_rust
	__upgrade_cargo_packages
	__upgrade_go
}
