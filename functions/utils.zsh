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

function check-cert {
	openssl s_client -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -text
}

function install_from_github {
	# github path
	gh_path=$1
	# output file

	# binary name is the last part of the path
	binary_name=$(basename $gh_path)
	echo "Installing $binary_name from $gh_path"
	output_dir=$2
	output_file_path="$output_dir/$binary_name"
	# get the download url
	# get the latest release
	latest_version=$(gh api "repos/$gh_path/releases/latest" | jq -r '.tag_name')
	echo "Latest version: $latest_version"
	# search in assets for correct architecture
	download_url=$(gh api "repos/$gh_path/releases/latest" | jq -r '.assets[] | select(.name | test("linux-amd64")) | .browser_download_url')
	echo $download_url
	# check if download url is empty
	if [[ -z $download_url ]]; then
		echo "No download url found for $gh_path"
		return 1
	fi

	# download the file
	curl -L -o $output_file_path $download_url
	echo "Downloaded $output_file_path from $download_url"
}