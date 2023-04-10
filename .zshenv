#!/bin/zsh
##? .zshenv - Zsh environment file, loaded always.

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Use .zprofile for remaining environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

#
# Editors
#

export EDITOR="${EDITOR:-code}"
export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"

# 
# GOLANG
#

GOLANG_PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin:$PATH"
export GOROOT="$HOME/.gobrew/current/go"
export GO111MODULE="on"

#
# PYTHON
#

PYENV_PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"

#
# TEXLIVE
#

TEXLIVE_PATH="/usr/local/texlive/2023/bin/x86_64-linux"

#
# GIT (HOST)
#

export HOST_GITLAB_SSH="ssh://git@gitlab.hochschule-stralsund.de:2224"
export HOST_GITLAB_HTTPS="https://gitlab.hochschule-stralsund.de"

#
# VOLTA
#

export VOLTA_HOME="$HOME/.volta"

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
  $HOME/.local/bin
  $HOME/.cargo/bin
  $VOLTA_HOME/bin
  $GOLANG_PATH
  $PYENV_PATH
  $TEXLIVE_PATH
  $path
)