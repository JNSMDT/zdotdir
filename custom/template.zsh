function template {
	template_name=$1
	destination=$2

	template_path="$HOME/dev/templates/$1/"

	rsync -av $template_path $2 \
		--exclude .git \
		--exclude .gitignore \
		--exclude .DS_Store \
		--exclude node_modules \
		--exclude .github \
		--exclude .svelte-kit \
}
