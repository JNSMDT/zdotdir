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

GOLANG_PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin"
export GOROOT="$HOME/.gobrew/current/go"
export GO111MODULE="on"

#
# PYTHON
#

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
# Keybindings
#

### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

### ctrl+delete
bindkey "\e[3;5~" kill-word
# urxvt
bindkey "\e[3^" kill-word

### ctrl+backspace
bindkey '^H' backward-kill-word

#
# Paths
#
export WIN_ROOT="/mnt/c"
export WIN_HOME="$(wslpath "$(wslvar USERPROFILE)")"

WINDOWS_PATHS=(
  "$WIN_HOME/AppData/Local/Microsoft/WindowsApps"
	"$WIN_HOME/AppData/Local/Programs/Microsoft VS Code/bin"
	"$WIN_ROOT/Program Files/Docker/Docker/resources/bin"
	"$WIN_ROOT/ProgramData/DockerDesktop/version-bin"
  "$WIN_ROOT/Program Files (x86)/gnupg/bin"
  "$WIN_ROOT/Program Files/PowerShell/7"
  "$WIN_ROOT/Windows"
)

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/local/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $HOME/.local/bin
  $HOME/.cargo/bin
  $VOLTA_HOME/bin
  $GOLANG_PATH
  $TEXLIVE_PATH
  $WINDOWS_PATHS
  $path
)
