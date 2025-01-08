#! python3

from pathlib import Path
import shutil

# Create a backup of the gitconfig file
home = Path.home()
git_config = home / '.config' / 'git' / 'gitconfig'
backup_config = git_config.with_suffix('.bak')
shutil.copy2(git_config, backup_config)

# Get the path where the script was executed from
script_path = Path.cwd()

# Append the new configuration to the gitconfig file
with git_config.open('a') as f:
    f.write(f"\n[includeIf \"gitdir:{script_path}/\"]\npath = ~/.config/git/gitconfig-jessica\n")
