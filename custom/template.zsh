function template {
	template_name=$1
	destination=$2

	# check if tempalte_name comes with template prefix
	if [[ ! $template_name =~ "template" ]]; then
		template_name="template-$template_name"
	fi

	template_path="$HOME/dev/templates/$template_name/"

	# check if template_path exists
	if [ ! -d "$template_path" ]; then
		echo "Template $template_name not found"
		return 1
	fi

	rsync -av $template_path $2 \
		--exclude .git \
		--exclude .gitignore \
		--exclude .DS_Store \
		--exclude node_modules \
		--exclude .github \
		--exclude .svelte-kit \
}
