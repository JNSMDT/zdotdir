#!/bin/zsh
#
# .zprofile - Zsh file loaded on login.
#

#
# Editors
#

export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)
